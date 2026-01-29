import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/models/enums.dart';

class VoterDetailController extends ChangeNotifier {
  final String voterId;
  final TextEditingController mobileController = TextEditingController();

  Voter? _voter;
  bool _loading = true;
  bool _saving = false;
  Position? _currentPosition;

  Voter? get voter => _voter;
  bool get loading => _loading;
  bool get saving => _saving;
  Position? get currentPosition => _currentPosition;

  VoterDetailController({required this.voterId}) {
    _init();
  }

  Future<void> _init() async {
    await loadVoter();
    await fetchLocation();
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  Future<void> loadVoter() async {
    try {
      final voter = await AppRepository.getVoter(voterId);
      if (voter != null) {
        _voter = voter;
        mobileController.text = voter.phone ?? '';
        _loading = false;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
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
    }
  }

  Future<bool> saveVoter() async {
    _saving = true;
    notifyListeners();

    try {
      if (_currentPosition == null) {
        await fetchLocation();
      }

      final updatedVoter = _voter!.copyWith(
        phone: mobileController.text.trim(),
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
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

  Future<void> sendSMS() async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }
    final uri = Uri.parse('sms:$mobile');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> sendWhatsApp() async {
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      throw Exception('No mobile number available');
    }
    final uri = Uri.parse('https://wa.me/$mobile');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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

  String getPrintableSlip() {
    if (_voter == null) return '';

    return '''
=============================
       VOTER SLIP
=============================
Name: ${_voter!.name ?? 'N/A'}
EPIC: ${_voter!.epicId ?? 'N/A'}
House No: ${_voter!.houseNo ?? 'N/A'}
Age: ${_voter!.age ?? 'N/A'}
Gender: ${_voter!.gender?.label ?? 'N/A'}
Section: ${_voter!.sectionNumber ?? 'N/A'}
Phone: ${_voter!.phone ?? 'N/A'}
=============================
Favorability: ${_voter!.favorability.label}
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
