import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/voter_search/controllers/voter_detail_controller.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:mobileapp/models/enums.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';
import 'package:mobileapp/widgets/app_bottom_nav.dart';
import 'package:mobileapp/l10n/app_localizations.dart';

class VoterDetailScreen extends ConsumerStatefulWidget {
  final String voterId;

  const VoterDetailScreen({super.key, required this.voterId});

  @override
  ConsumerState<VoterDetailScreen> createState() => _VoterDetailScreenState();
}

class _VoterDetailScreenState extends ConsumerState<VoterDetailScreen> {
  late VoterDetailController _controller;
  int _currentNavIndex = 0;

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
      final langCode = ref.read(settingsProvider).langCode;
      await _controller.sendSMS(langCode);
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
      final langCode = ref.read(settingsProvider).langCode;
      await _controller.sendWhatsApp(langCode);
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
      final langCode = ref.read(settingsProvider).langCode;
      final slip = await _controller.getPrintableSlip(langCode);
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
            builder: (context) => const VoterConsoleScreen(),
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
            builder: (context) => const VoterConsoleScreen(),
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
    final l10n = AppLocalizations.of(context);
    
    // Ensure localization is loaded
    if (l10n == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_controller.loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_controller.voter == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.voterDetails)),
        body: Center(child: Text(l10n.noData)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.voterDetails),
      ),
      body: Column(
        children: [
          // Fixed action buttons bar at the top
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Row 1: Save and Cancel
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _controller.saving ? null : _saveVoter,
                        icon: _controller.saving 
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Icon(Icons.save, size: 20),
                        label: Text(
                          l10n.save,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 20),
                        label: Text(
                          l10n.cancel,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          padding: EdgeInsets.symmetric(vertical: 10),
                          side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Row 2: Other Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.message,
                      label: l10n.sms,
                      onPressed: _sendSMS,
                    ),
                    _buildActionButton(
                      icon: Icons.chat_bubble_rounded,
                      label: l10n.whatsapp,
                      onPressed: _sendWhatsApp,
                    ),
                    _buildActionButton(
                      icon: Icons.print,
                      label: l10n.print,
                      onPressed: _printVoterSlip,
                    ),
                    _buildActionButton(
                      icon: Icons.phone,
                      label: l10n.call,
                      onPressed: _dialPhone,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompactInfoCard(l10n),
                  const SizedBox(height: 8),
                  _buildEditableSection(l10n),
                  const SizedBox(height: 8),
                  // Section and Booth Voters buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _navigateToSection,
                          icon: const Icon(Icons.group, size: 18),
                          label: Text(l10n.sectionVoters),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _navigateToBooth,
                          icon: const Icon(Icons.location_on, size: 18),
                          label: Text(l10n.boothVoters),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          // TODO: Handle navigation based on index
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    Color? color,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: onPressed == null 
                ? Colors.grey 
                : (color ?? Colors.black87),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: onPressed == null 
                  ? Colors.grey 
                  : (color ?? Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfoCard(AppLocalizations l10n) {
    final voter = _controller.voter!;
    final langCode = ref.watch(settingsProvider).langCode;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.voterInformation,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            // Part/Serial Number (First)
            _buildInfoRow(
              icon: Icons.list_alt_outlined,
              label: '${l10n.part}/${l10n.srno}',
              value: '${voter.partNo ?? 'N/A'}/${voter.serialNumber ?? 'N/A'}',
              isBold: true,
            ),
            const SizedBox(height: 4),
            // EPIC ID (Second)
            _buildInfoRow(
              icon: Icons.badge,
              label: l10n.epicId,
              value: voter.epicId ?? 'N/A',
              fontFamily: 'monospace',
            ),
            const SizedBox(height: 4),
            // Voter Name (Third)
            _buildInfoRow(
              icon: Icons.person,
              label: l10n.name,
              value: BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode).isEmpty
                ? 'Unknown'
                : BilingualHelper.getVoterName(voter.name, voter.nameLocal, langCode),
              isBold: true,
            ),
            const SizedBox(height: 4),
            // Relation Name (Fourth)
            _buildInfoRow(
              icon: Icons.person_outline,
              label: l10n.relationName,
              value: voter.relationName != null
                  ? "${BilingualHelper.getRelationName(voter.relationName, voter.relationNameLocal, langCode)}${voter.relation != null && voter.relation!.isNotEmpty ? ' (${voter.relation})' : ''}"
                  : 'N/A',
            ),
            const SizedBox(height: 4),
            // Age (Fifth)
            _buildInfoRow(
              icon: Icons.cake,
              label: l10n.age,
              value: '${voter.age ?? '?'}',
            ),
            const SizedBox(height: 4),
            // Booth Number/Address (Sixth)
            _buildInfoRow(
              icon: Icons.location_on,
              label: l10n.booth,
              value: _controller.boothName ?? voter.sectionName ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isBold = false,
    String? fontFamily,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableSection(AppLocalizations l10n) {
    final voter = _controller.voter!;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Favorability
            Text(
              l10n.favorability,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: VoterFavorability.values.map((fav) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _buildFavorabilityCircle(fav, size: 50, iconSize: 24, fontSize: 10),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            
            // Mobile Field
            TextField(
              controller: _controller.mobileController,
              decoration: InputDecoration(
                labelText: l10n.mobileNumber,
                prefixIcon: const Icon(Icons.phone, size: 20),
                isDense: true,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            
            // Status Toggles
            Text(
              l10n.status,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: Text(l10n.isDead, style: const TextStyle(fontSize: 13)),
                    value: voter.isDead,
                    onChanged: (value) => _controller.updateVoterStatus(isDead: value),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: Text(l10n.isShifted, style: const TextStyle(fontSize: 13)),
                    value: voter.isShifted,
                    onChanged: (value) => _controller.updateVoterStatus(isShifted: value),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            
            // Shifted Address Fields (conditional)
            if (voter.isShifted) ...[
              const SizedBox(height: 12),
              Text(
                l10n.shiftedAddress,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _controller.shiftedHouseNoController,
                decoration: InputDecoration(
                  labelText: l10n.shiftedHouseNo,
                  isDense: true,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controller.shiftedAddressController,
                decoration: InputDecoration(
                  labelText: l10n.shiftedAddress,
                  isDense: true,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                maxLines: 2,
                style: const TextStyle(fontSize: 13),
              ),
            ],
            const SizedBox(height: 12),
            
            // Location Section
            Text(
              l10n.locationInfo,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            if (_controller.currentPosition != null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${l10n.latitude}: ${_controller.currentPosition!.latitude.toStringAsFixed(6)}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${l10n.longitude}: ${_controller.currentPosition!.longitude.toStringAsFixed(6)}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ] else
              Text(
                'No location captured',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            const SizedBox(height: 8),
            // Always show address box
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _controller.voter!.geoAddress ?? 'Address will appear here after getting location',
                      style: TextStyle(
                        fontSize: 11,
                        color: _controller.voter!.geoAddress != null ? Colors.black : Colors.grey[600],
                        fontStyle: _controller.voter!.geoAddress != null ? FontStyle.normal : FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      try {
                        await _controller.fetchLocation();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Location captured successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error getting location: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.my_location, size: 18),
                    label: Text(l10n.getLocation),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_controller.currentPosition != null || 
                                (_controller.voter!.latitude != null && _controller.voter!.longitude != null))
                        ? () async {
                            try {
                              await _controller.openDirections();
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    icon: const Icon(Icons.directions, size: 18),
                    label: Text(l10n.showDirections),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggles(AppLocalizations l10n) {
    final voter = _controller.voter!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.status,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text(l10n.isDead, style: const TextStyle(fontSize: 13)),
              value: voter.isDead,
              onChanged: (value) => _controller.updateVoterStatus(isDead: value),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: Text(l10n.isShifted, style: const TextStyle(fontSize: 13)),
              value: voter.isShifted,
              onChanged: (value) => _controller.updateVoterStatus(isShifted: value),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorabilitySelector(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.favorability,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: VoterFavorability.values.map((fav) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _buildFavorabilityCircle(fav, size: 50, iconSize: 24, fontSize: 10),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorabilityCircle(VoterFavorability favorability, {double size = 50, double iconSize = 24, double fontSize = 10}) {
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
          const SizedBox(height: 4),
          Text(favorability.label, style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }

  Widget _buildMobileField(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: TextField(
          controller: _controller.mobileController,
          decoration: InputDecoration(
            labelText: l10n.mobileNumber,
            prefixIcon: const Icon(Icons.phone, size: 20),
            isDense: true,
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildLocationInfo(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.locationInfo,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            if (_controller.currentPosition != null)
              Text(
                '${l10n.latitude}: ${_controller.currentPosition!.latitude.toStringAsFixed(6)}\n'
                '${l10n.longitude}: ${_controller.currentPosition!.longitude.toStringAsFixed(6)}',
                style: const TextStyle(fontSize: 12),
              )
            else
              Text(
                l10n.loading,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftedAddressFields(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.isShifted} ${l10n.address}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _controller.shiftedHouseNoController,
              decoration: InputDecoration(
                labelText: l10n.shiftedHouseNo,
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller.shiftedAddressController,
              decoration: InputDecoration(
                labelText: l10n.shiftedAddress,
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
