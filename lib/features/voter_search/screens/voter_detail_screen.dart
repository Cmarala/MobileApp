import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/voter_search/controllers/voter_detail_controller.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:mobileapp/models/enums.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';

class VoterDetailScreen extends ConsumerStatefulWidget {
  final String voterId;

  const VoterDetailScreen({super.key, required this.voterId});

  @override
  ConsumerState<VoterDetailScreen> createState() => _VoterDetailScreenState();
}

class _VoterDetailScreenState extends ConsumerState<VoterDetailScreen> {
  late VoterDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VoterDetailController(voterId: widget.voterId);
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveVoter() async {
    try {
      final success = await _controller.saveVoter();
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Voter saved successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error saving voter'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving voter: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _sendSMS() async {
    try {
      await _controller.sendSMS();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('SMS sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending SMS: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _sendWhatsApp() async {
    try {
      await _controller.sendWhatsApp();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('WhatsApp opened successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening WhatsApp: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _printVoterSlip() async {
    try {
      final slip = _controller.getPrintableSlip();
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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error printing slip: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _navigateToSection() {
    try {
      final filters = _controller.getSectionFilters();
      if (filters != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VoterConsoleScreen(initialFilters: filters),
          ),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Section information not available')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to section: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _navigateToBooth() {
    try {
      final filters = _controller.getBoothFilters();
      if (filters != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VoterConsoleScreen(initialFilters: filters),
          ),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booth information not available')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to booth: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _dialPhone() async {
    try {
      await _controller.dialPhone();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_controller.voter == null) {
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
            icon: const Icon(Icons.phone),
            tooltip: 'Call',
            onPressed: _dialPhone,
          ),
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
                onPressed: _controller.saving ? null : _saveVoter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: _controller.saving
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

  Widget _buildInfoCard() {
    final voter = _controller.voter!;
    final langCode = ref.watch(settingsProvider).langCode;
    return Card(
      elevation: 4,
      color: Colors.blueGrey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode).isEmpty
                ? 'Unknown'
                : BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              voter.relationName != null
                  ? "${voter.relation ?? ''} ${BilingualHelper.getRelationName(voter.relationName, voter.relationNameLocal, langCode)}"
                  : "Relative Name N/A",
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const Divider(),
            Text(
              'EPIC: ${voter.epicId ?? 'N/A'}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 4),
            Text(
              'House No: ${voter.houseNo ?? 'N/A'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${voter.age ?? '?'} | Gender: ${voter.gender?.label ?? '?'}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggles() {
    final voter = _controller.voter!;
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
              value: voter.isDead,
              onChanged: (value) => _controller.updateVoterStatus(isDead: value),
            ),
            SwitchListTile(
              title: const Text('Shifted'),
              value: voter.isShifted,
              onChanged: (value) => _controller.updateVoterStatus(isShifted: value),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: VoterFavorability.values.map((fav) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _buildFavorabilityCircle(fav, size: 44, iconSize: 20, fontSize: 12),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorabilityCircle(VoterFavorability favorability, {double size = 44, double iconSize = 20, double fontSize = 12}) {
    final isSelected = _controller.voter!.favorability == favorability;
    return InkWell(
      onTap: () => _controller.updateFavorability(favorability),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: favorability.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: iconSize)
                : null,
          ),
          const SizedBox(height: 6),
          Text(favorability.label, style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }

  Widget _buildMobileField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _controller.mobileController,
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
            if (_controller.currentPosition != null)
              Text(
                'Lat: ${_controller.currentPosition!.latitude.toStringAsFixed(6)}, '
                'Lng: ${_controller.currentPosition!.longitude.toStringAsFixed(6)}',
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
