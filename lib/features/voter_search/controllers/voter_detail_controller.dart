import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/models/enums.dart';

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

  Future<String> generateVoterMessage(String langCode) async {
    if (_voter == null) return '';

    try {
      // Get campaign ID and settings from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final headerTextEnabled = prefs.getBool('headerTextEnabled') ?? true;
      final headerImageEnabled = prefs.getBool('headerImageEnabled') ?? true;
      final footerEnabled = prefs.getBool('footerEnabled') ?? true;
      
      if (campaignId == null) {
        return _buildMessageWithoutCampaign(langCode);
      }

      // Fetch campaign data
      final campaign = await AppRepository.getCampaign(campaignId);
      
      if (campaign == null) {
        return _buildMessageWithoutCampaign(langCode);
      }

      // Fetch image URL only if header image is enabled
      String? imageUrl;
      if (headerImageEnabled) {
        imageUrl = await AppRepository.getCampaignImageUrl(campaignId, 'message_section_1_image');
      }

      // Build message with three sections
      final section1 = headerTextEnabled && langCode == 'en' 
          ? (campaign['section1_text'] ?? '')
          : headerTextEnabled
            ? (campaign['section1_text_local'] ?? campaign['section1_text'] ?? '')
            : '';
      
      final section3 = footerEnabled && langCode == 'en'
          ? (campaign['section3_text'] ?? '')
          : footerEnabled
            ? (campaign['section3_text_local'] ?? campaign['section3_text'] ?? '')
            : '';

      final section2 = _buildVoterDetailsSection(langCode);

      final message = StringBuffer();
      
      // Add image URL at the top if available and header image is enabled
      if (headerImageEnabled && imageUrl != null && imageUrl.isNotEmpty) {
        message.writeln(imageUrl);
        message.writeln();
      }
      
      if (section1.isNotEmpty) {
        message.writeln(section1);
        message.writeln();
      }
      message.write(section2);
      if (section3.isNotEmpty) {
        message.writeln();
        message.writeln();
        message.write(section3);
      }

      return message.toString();
    } catch (e) {
      return _buildMessageWithoutCampaign(langCode);
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
    // Remove all non-digit characters
    String cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // If number doesn't start with country code, assume India (+91)
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
    final message = await _generateVoterMessageWithoutImage(langCode);
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
      // Get campaign ID and settings
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final headerImageEnabled = prefs.getBool('headerImageEnabled') ?? true;
      
      String? imagePath;
      
      // Only download image if headerImageEnabled is true
      if (campaignId != null && headerImageEnabled) {
        final imageUrl = await AppRepository.getCampaignImageUrl(campaignId, 'message_section_1_image');
        
        if (imageUrl != null && imageUrl.isNotEmpty) {
          // Download image
          final response = await http.get(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            // Save image to temporary directory
            final tempDir = await getTemporaryDirectory();
            final fileName = 'voter_message_${DateTime.now().millisecondsSinceEpoch}.jpg';
            final file = File('${tempDir.path}/$fileName');
            await file.writeAsBytes(response.bodyBytes);
            imagePath = file.path;
          }
        }
      }
      
      // Generate message without image URL
      final message = await _generateVoterMessageWithoutImage(langCode);
      final formattedPhone = _formatPhoneNumberForWhatsApp(mobile);
      
      if (imagePath != null && Platform.isAndroid) {
        // Use native Android intent to send directly to WhatsApp with phone number
        const platform = MethodChannel('com.example.mobileapp/whatsapp');
        try {
          await platform.invokeMethod('sendWhatsAppMessage', {
            'phone': formattedPhone,
            'message': message,
            'imagePath': imagePath,
          });
        } catch (e) {
          // Fallback to text only if native method fails
          await sendWhatsAppTextOnly(langCode);
        }
      } else {
        // Fallback: send without image via WhatsApp URL
        await sendWhatsAppTextOnly(langCode);
      }
    } catch (e) {
      // Last resort fallback
      await sendWhatsAppTextOnly(langCode);
    }
  }

  Future<void> sendWhatsAppTextOnly(String langCode) async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }
    
    final message = await _generateVoterMessageWithoutImage(langCode);
    final formattedPhone = _formatPhoneNumberForWhatsApp(mobile);
    final uri = Uri.parse('https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<String> _generateVoterMessageWithoutImage(String langCode) async {
    if (_voter == null) return '';

    try {
      final prefs = await SharedPreferences.getInstance();
      final campaignId = prefs.getString('campaign_id');
      final headerTextEnabled = prefs.getBool('headerTextEnabled') ?? true;
      final footerEnabled = prefs.getBool('footerEnabled') ?? true;
      
      if (campaignId == null) {
        return _buildMessageWithoutCampaign(langCode);
      }

      final campaign = await AppRepository.getCampaign(campaignId);
      
      if (campaign == null) {
        return _buildMessageWithoutCampaign(langCode);
      }

      final section1 = headerTextEnabled && langCode == 'en' 
          ? (campaign['section1_text'] ?? '')
          : headerTextEnabled
            ? (campaign['section1_text_local'] ?? campaign['section1_text'] ?? '')
            : '';
      
      final section3 = footerEnabled && langCode == 'en'
          ? (campaign['section3_text'] ?? '')
          : footerEnabled
            ? (campaign['section3_text_local'] ?? campaign['section3_text'] ?? '')
            : '';

      final section2 = _buildVoterDetailsSection(langCode);

      final message = StringBuffer();
      
      if (section1.isNotEmpty) {
        message.writeln(section1);
        message.writeln();
      }
      message.write(section2);
      if (section3.isNotEmpty) {
        message.writeln();
        message.writeln();
        message.write(section3);
      }

      return message.toString();
    } catch (e) {
      return _buildMessageWithoutCampaign(langCode);
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

  Future<String> getPrintableSlip(String langCode) async {
    if (_voter == null) return '';

    final message = await generateVoterMessage(langCode);
    
    return '''
=============================
       VOTER SLIP
=============================
$message
=============================
''';
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
