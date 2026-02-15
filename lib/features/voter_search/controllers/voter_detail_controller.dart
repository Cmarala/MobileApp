import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/models/enums.dart';
import 'package:mobileapp/utils/thermal_slip_formatter.dart';
import 'package:mobileapp/utils/printer_service.dart';

class VoterDetailController extends ChangeNotifier {
  final String voterId;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController shiftedHouseNoController = TextEditingController();
  final TextEditingController shiftedAddressController = TextEditingController();

  Voter? _voter;
  bool _loading = true;
  bool _saving = false;
  Position? _currentPosition;
  String? _boothName;

  Voter? get voter => _voter;
  bool get loading => _loading;
  bool get saving => _saving;
  Position? get currentPosition => _currentPosition;
  String? get boothName => _boothName;

  VoterDetailController({required this.voterId}) {
    _init();
  }

  Future<void> _init() async {
    await loadVoter();
    await fetchBoothInfo();
  }

  @override
  void dispose() {
    mobileController.dispose();
    shiftedHouseNoController.dispose();
    shiftedAddressController.dispose();
    super.dispose();
  }

  Future<void> loadVoter() async {
    try {
      final voter = await AppRepository.getVoter(voterId);
      if (voter != null) {
        _voter = voter;
        mobileController.text = voter.phone ?? '';
        shiftedHouseNoController.text = voter.shiftedHouseNo ?? '';
        shiftedAddressController.text = voter.shiftedAddress ?? '';
        
        // Load existing location if available
        if (voter.latitude != null && voter.longitude != null) {
          _currentPosition = Position(
            latitude: voter.latitude!,
            longitude: voter.longitude!,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
        }
        
        _loading = false;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBoothInfo() async {
    try {
      if (_voter?.geoUnitId != null && _voter!.geoUnitId!.isNotEmpty) {
        final result = await AppRepository.db.getOptional(
          'SELECT name, booth_number FROM geo_units WHERE id = ?',
          [_voter!.geoUnitId],
        );
        if (result != null) {
          final name = result['name'] as String?;
          final boothNumber = result['booth_number'] as String?;
          _boothName = boothNumber != null && boothNumber.isNotEmpty
              ? '$boothNumber - $name'
              : name;
          notifyListeners();
        }
      }
    } catch (e) {
      // Booth info failed, continue without it
    }
  }

  Future<void> fetchLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition();
      _currentPosition = position;
      notifyListeners();
    } catch (e) {
      // Location failed, continue without it
      rethrow;
    }
  }

  Future<void> openDirections() async {
    double? lat;
    double? lng;
    
    if (_currentPosition != null) {
      lat = _currentPosition!.latitude;
      lng = _currentPosition!.longitude;
    } else if (_voter?.latitude != null && _voter?.longitude != null) {
      lat = _voter!.latitude;
      lng = _voter!.longitude;
    }
    
    if (lat != null && lng != null) {
      // Use geo: URI scheme first as it works better on Android
      final url = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
      try {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        // Fallback to Google Maps web URL
        final webUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } else {
      throw Exception('No location available');
    }
  }

  Future<void> generateMessage(String langCode) async {
    if (_voter == null) return;

    try {
      // Get campaign ID and settings from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      
      if (campaignId == null) {
        return;
      }

      // Fetch campaign data
      final campaign = await AppRepository.getCampaign(campaignId);
      if (campaign == null) {
        return;
      }
    } catch (e) {
      debugPrint('Error generating message: $e');
    }
  }

  /// Get section texts respecting campaign settings
  Future<Map<String, String>> _getSectionTexts(String langCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final headerTextEnabled = prefs.getBool('headerTextEnabled') ?? true;
      final footerEnabled = prefs.getBool('footerEnabled') ?? true;

      String section1 = '';
      String section3 = '';

      if (campaignId != null) {
        final campaign = await AppRepository.getCampaign(campaignId);

        if (campaign != null) {
          section1 = headerTextEnabled && langCode == 'en'
              ? (campaign['section1_text'] ?? '')
              : headerTextEnabled
                  ? (campaign['section1_text_local'] ?? campaign['section1_text'] ?? '')
                  : '';

          section3 = footerEnabled && langCode == 'en'
              ? (campaign['section3_text'] ?? '')
              : footerEnabled
                  ? (campaign['section3_text_local'] ?? campaign['section3_text'] ?? '')
                  : '';
        }
      }

      return {'section1': section1, 'section3': section3};
    } catch (e) {
      debugPrint('Error getting section texts: $e');
      return {'section1': '', 'section3': ''};
    }
  }

  /// Get image URL if enabled in settings
  Future<String?> _getImageUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final headerImageEnabled = prefs.getBool('headerImageEnabled') ?? true;

      if (!headerImageEnabled || campaignId == null) {
        return null;
      }

      return await AppRepository.getCampaignImageUrl(campaignId, 'message_section_1_image');
    } catch (e) {
      debugPrint('Error getting image URL: $e');
      return null;
    }
  }

  /// Build core message without image: section1 + voter info + section3
  /// Used for SMS (which cannot include images)
  Future<String> _buildSlipContent(String langCode) async {
    if (_voter == null) return '';

    try {
      final sections = await _getSectionTexts(langCode);
      final section1 = sections['section1'] ?? '';
      final section3 = sections['section3'] ?? '';
      final voterDetails = _buildVoterDetailsSection(langCode);

      final buffer = StringBuffer();

      if (section1.isNotEmpty) {
        buffer.writeln(section1);
        buffer.writeln();
      }

      buffer.write(voterDetails);

      if (section3.isNotEmpty) {
        buffer.writeln();
        buffer.writeln();
        buffer.write(section3);
      }

      return buffer.toString();
    } catch (e) {
      debugPrint('Error building slip content: $e');
      return _buildVoterDetailsSection(langCode);
    }
  }

  /// Build core message with image first: image URL + section1 + voter info + section3
  Future<String> _buildSlipContentWithImage(String langCode) async {
    if (_voter == null) return '';

    try {
      final sections = await _getSectionTexts(langCode);
      final section1 = sections['section1'] ?? '';
      final section3 = sections['section3'] ?? '';
      final voterDetails = _buildVoterDetailsSection(langCode);
      final imageUrl = await _getImageUrl();

      final buffer = StringBuffer();

      // Image URL first (if enabled)
      if (imageUrl != null && imageUrl.isNotEmpty) {
        buffer.writeln(imageUrl);
        buffer.writeln();
      }

      // Section 1 (Header)
      if (section1.isNotEmpty) {
        buffer.writeln(section1);
        buffer.writeln();
      }

      // Voter details
      buffer.write(voterDetails);

      // Section 3 (Footer)
      if (section3.isNotEmpty) {
        buffer.writeln();
        buffer.writeln();
        buffer.write(section3);
      }

      return buffer.toString();
    } catch (e) {
      debugPrint('Error building slip content with image: $e');
      return _buildVoterDetailsSection(langCode);
    }
  }

  /// Generate final message with optional image URL
  Future<String> generateVoterMessage(String langCode) async {
    if (_voter == null) return '';

    try {
      final slipContent = await _buildSlipContent(langCode);
      final imageUrl = await _getImageUrl();

      final buffer = StringBuffer();

      // Add image URL at the top if available
      if (imageUrl != null && imageUrl.isNotEmpty) {
        buffer.writeln(imageUrl);
        buffer.writeln();
      }

      buffer.write(slipContent);

      return buffer.toString();
    } catch (e) {
      debugPrint('Error generating voter message: $e');
      return '';
    }
  }

  String _buildVoterDetailsSection(String langCode) {
    final name = langCode == 'en'
        ? (_voter!.name ?? 'N/A')
        : (_voter!.nameLocal ?? _voter!.name ?? 'N/A');
    
    final epicId = _voter!.epicId ?? 'N/A';
    final serialNo = _voter!.serialNumber?.toString() ?? 'N/A';
    final boothName = _boothName ?? _voter!.sectionName ?? 'N/A';

    return '''Name: $name
EPIC ID: $epicId
Serial No: $serialNo
Booth: $boothName''';
  }

  String _buildMessageWithoutCampaign(String langCode) {
    return _buildVoterDetailsSection(langCode);
  }

  String _formatPhoneNumberForWhatsApp(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length == 10) {
      cleaned = '91$cleaned';
    }
    return cleaned;
  }

  Future<bool> saveVoter() async {
    _saving = true;
    notifyListeners();

    try {
      if (_currentPosition == null) {
        await fetchLocation();
      }

      // Get current user ID for last_visited_by
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');

      final updatedVoter = _voter!.copyWith(
        phone: mobileController.text.trim(),
        shiftedHouseNo: shiftedHouseNoController.text.trim().isEmpty 
            ? null 
            : shiftedHouseNoController.text.trim(),
        shiftedAddress: shiftedAddressController.text.trim().isEmpty 
            ? null 
            : shiftedAddressController.text.trim(),
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
        lastVisitedAt: DateTime.now().toIso8601String(),
        lastVisitedBy: userId,
      );

      await AppRepository.saveVoter(updatedVoter);
      _saving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _saving = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> sendSMS(String langCode) async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }

    final message = await _buildSlipContent(langCode);
    final uri = Uri.parse('sms:$mobile?body=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> sendWhatsApp(String langCode) async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }

    try {
      final formattedPhone = _formatPhoneNumberForWhatsApp(mobile);
      final prefs = await SharedPreferences.getInstance();
      final headerImageEnabled = prefs.getBool('headerImageEnabled') ?? true;

      String? imagePath;

      // Try to download and send image if enabled (Android only)
      if (headerImageEnabled && Platform.isAndroid) {
        final imageUrl = await _getImageUrl();

        if (imageUrl != null && imageUrl.isNotEmpty) {
          try {
            final response = await http.get(Uri.parse(imageUrl));
            if (response.statusCode == 200) {
              final tempDir = await getTemporaryDirectory();
              final fileName = 'voter_message_${DateTime.now().millisecondsSinceEpoch}.jpg';
              final file = File('${tempDir.path}/$fileName');
              await file.writeAsBytes(response.bodyBytes);
              imagePath = file.path;
            }
          } catch (e) {
            debugPrint('Error downloading image: $e');
          }
        }

        // Try native Android method if image available
        if (imagePath != null) {
          try {
            // Use message WITHOUT image URL since image is attached
            final message = await _buildSlipContent(langCode);
            const platform = MethodChannel('com.example.mobileapp/whatsapp');
            await platform.invokeMethod('sendWhatsAppMessage', {
              'phone': formattedPhone,
              'message': message,
              'imagePath': imagePath,
            });
            return;
          } catch (e) {
            debugPrint('Native WhatsApp send failed, falling back to URL: $e');
          }
        }
      }

      // Fallback: send via WhatsApp URL (text with image URL included)
      final messageWithImageUrl = await _buildSlipContentWithImage(langCode);
      final uri = Uri.parse('https://wa.me/$formattedPhone?text=${Uri.encodeComponent(messageWithImageUrl)}');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error sending WhatsApp: $e');
      rethrow;
    }
  }

  Future<void> dialPhone() async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }
    final uri = Uri.parse('tel:$mobile');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Get voter slip content for printing
  /// Returns text formatted as: section1 + voter info + section3
  /// Image URL is NOT included since image data is passed separately
  Future<String> getVoterSlipContent(String langCode) async {
    return await _buildSlipContent(langCode);
  }

  /// Print voter slip to thermal printer with image support
  /// Image -> Section1 -> Voter Info -> Section3
  Future<bool> printVoterSlip(String langCode) async {
    if (_voter == null) {
      throw Exception('Voter data not loaded');
    }

    try {
      final printerService = PrinterService();

      // Check if printer is connected
      final isConnected = await printerService.isConnectedToPrinter();
      if (!isConnected) {
        throw Exception('Printer not connected. Please connect from Settings first.');
      }

      // Check if image is enabled
      final prefs = await SharedPreferences.getInstance();
      final headerImageEnabled = prefs.getBool('headerImageEnabled') ?? true;

      Uint8List? imageData;

      // Download image if enabled
      if (headerImageEnabled) {
        try {
          final imageUrl = await _getImageUrl();
          if (imageUrl != null && imageUrl.isNotEmpty) {
            final response = await http.get(Uri.parse(imageUrl));
            if (response.statusCode == 200) {
              imageData = response.bodyBytes;
            }
          }
        } catch (e) {
          debugPrint('Error downloading image for printer: $e');
          // Continue without image if download fails
        }
      }

      // Get text content with image marker: image -> section1 + voter info + section3
      final textContent = await getVoterSlipContent(langCode);

      // Generate ESC/POS commands with image
      final commands = await ThermalSlipFormatter.generateESCPOSCommandsWithImage(
        textContent: textContent,
        imageData: imageData,
      );

      // Print to thermal printer
      final result = await printerService.printBytes(commands);

      return result;
    } catch (e) {
      debugPrint('Error printing voter slip: $e');
      rethrow;
    }
  }

  Map<String, dynamic>? getSectionFilters() {
    if (_voter?.sectionNumber != null && _voter!.sectionNumber!.isNotEmpty) {
      return {'section_number': _voter!.sectionNumber};
    }
    return null;
  }

  Map<String, dynamic>? getBoothFilters() {
    if (_voter?.geoUnitId != null && _voter!.geoUnitId!.isNotEmpty) {
      return {'geo_unit_id': _voter!.geoUnitId};
    }
    return null;
  }

  void updateVoterStatus({bool? isDead, bool? isShifted}) {
    if (_voter == null) return;
    
    // Clear shifted fields when isShifted is set to false
    if (isShifted != null && !isShifted) {
      shiftedHouseNoController.clear();
      shiftedAddressController.clear();
    }
    
    _voter = _voter!.copyWith(
      isDead: isDead ?? _voter!.isDead,
      isShifted: isShifted ?? _voter!.isShifted,
    );
    notifyListeners();
  }

  void updateFavorability(VoterFavorability favorability) {
    if (_voter == null) return;
    _voter = _voter!.copyWith(favorability: favorability);
    notifyListeners();
  }
}
