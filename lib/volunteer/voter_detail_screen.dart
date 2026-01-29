import 'package:flutter/material.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/models/enums.dart';

class VoterDetailScreen extends StatefulWidget {
  final String voterId;

  const VoterDetailScreen({super.key, required this.voterId});

  @override
  State<VoterDetailScreen> createState() => _VoterDetailScreenState();
}

class _VoterDetailScreenState extends State<VoterDetailScreen> {
  Voter? _voter;
  bool _loading = true;
  bool _saving = false;

  // Form state
  Position? _currentPosition;
  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadVoter();
    _fetchLocation();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _loadVoter() async {
    try {
      final voter = await AppRepository.getVoter(widget.voterId);
      if (voter != null && mounted) {
        setState(() {
          _voter = voter;
          _mobileController.text = voter.phone ?? '';
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _fetchLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() => _currentPosition = position);
      }
    } catch (e) {
      // Location failed, continue without it
    }
  }

  Future<void> _saveVoter() async {
    setState(() => _saving = true);
    try {
      // Location Guard: Ensure location is fetched before saving
      if (_currentPosition == null) {
        await _fetchLocation();
      }

      final updatedVoter = _voter!.copyWith(
        phone: _mobileController.text.trim(),
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
      );

      await AppRepository.saveVoter(updatedVoter);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voter saved successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _sendSMS() async {
    final mobile = _mobileController.text.trim();
    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No mobile number available')),
      );
      return;
    }
    final uri = Uri.parse('sms:$mobile');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendWhatsApp() async {
    final mobile = _mobileController.text.trim();
    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No mobile number available')),
      );
      return;
    }
    final uri = Uri.parse('https://wa.me/$mobile');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _printVoterSlip() async {
    if (_voter == null) return;

    // Format voter slip for thermal printer
    final slip = '''
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

    // TODO: Integrate with Bluetooth thermal printer service
    // For now, log to console and show in snackbar
    debugPrint('THERMAL PRINT OUTPUT:');
    debugPrint(slip);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Voter slip ready (check console)'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void _navigateToSection() {
    // Navigation Safety: Check typed model property
    if (_voter?.sectionNumber != null && _voter!.sectionNumber!.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const VoterConsoleScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Section information not available')),
      );
    }
  }

  void _navigateToBooth() {
    // Navigation Safety: Check typed model property
    if (_voter?.geoUnitId != null && _voter!.geoUnitId!.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const VoterConsoleScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booth information not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_voter == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Voter Detail')),
        body: const Center(child: Text('Voter not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voter Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'SMS',
            onPressed: _sendSMS,
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_rounded),
            tooltip: 'WhatsApp',
            onPressed: _sendWhatsApp,
          ),
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: 'Print',
            onPressed: _printVoterSlip,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildStatusToggles(),
            const SizedBox(height: 16),
            _buildFavorabilitySelector(),
            const SizedBox(height: 16),
            _buildMobileField(),
            const SizedBox(height: 16),
            _buildLocationInfo(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _saveVoter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: _saving
                    ? const CircularProgressIndicator()
                    : const Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _navigateToSection,
              icon: const Icon(Icons.group),
              label: const Text('Section Voters'),
            ),
            TextButton.icon(
              onPressed: _navigateToBooth,
              icon: const Icon(Icons.location_on),
              label: const Text('Booth Voters'),
            ),
          ],
        ),
      ),
    );
  }

  // Refined Info Card with Household Context
  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      color: Colors.blueGrey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _voter!.name ?? 'Unknown',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Added Relative Name for Field Accuracy
            Text(
              _voter!.relationName != null
                  ? "${_voter!.relation ?? ''} ${_voter!.relationName}"
                  : "Relative Name N/A",
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const Divider(),
            Text(
              'EPIC: ${_voter!.epicId ?? 'N/A'}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 4),
            // Added Door Number for "Voter Console" context
            Text(
              'House No: ${_voter!.houseNo ?? 'N/A'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${_voter!.age ?? '?'} | Gender: ${_voter!.gender?.label ?? '?'}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggles() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Dead'),
              value: _voter!.isDead,
              onChanged: (value) => setState(() => _voter = _voter!.copyWith(isDead: value)),
            ),
            SwitchListTile(
              title: const Text('Shifted'),
              value: _voter!.isShifted,
              onChanged: (value) => setState(() => _voter = _voter!.copyWith(isShifted: value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorabilitySelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favorability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: VoterFavorability.values.map((fav) {
                return _buildFavorabilityCircle(fav);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorabilityCircle(VoterFavorability favorability) {
    final isSelected = _voter!.favorability == favorability;
    return InkWell(
      onTap: () => setState(() => _voter = _voter!.copyWith(favorability: favorability)),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: favorability.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 3,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 30)
                : null,
          ),
          const SizedBox(height: 8),
          Text(favorability.label),
        ],
      ),
    );
  }

  Widget _buildMobileField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _mobileController,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GPS Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_currentPosition != null)
              Text(
                'Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}, '
                'Lng: ${_currentPosition!.longitude.toStringAsFixed(6)}',
              )
            else
              const Text(
                'Fetching location...',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
