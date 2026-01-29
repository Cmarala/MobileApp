import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapp/data/repositories.dart';

class VoterFilterDrawer extends ConsumerStatefulWidget {
  final Map<String, dynamic> initialFilters;
  final Function(Map<String, dynamic>) onApply;

  const VoterFilterDrawer({
    super.key, 
    required this.initialFilters, 
    required this.onApply,
  });

  @override
  ConsumerState<VoterFilterDrawer> createState() => _VoterFilterDrawerState();
}

class _VoterFilterDrawerState extends ConsumerState<VoterFilterDrawer> {
  late Map<String, dynamic> _localFilters;
  String? _userGeoUnitId;

  @override
  void initState() {
    super.initState();
    // Create a local copy so we can "Cancel" without saving
    _localFilters = Map<String, dynamic>.from(widget.initialFilters);
    _loadUserGeoUnit();
  }

  Future<void> _loadUserGeoUnit() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userGeoUnitId = prefs.getString('geo_unit_id');
    });
  }

  void _updateFilter(String key, dynamic value) {
    setState(() {
      if (value == null) {
        _localFilters.remove(key);
      } else {
        _localFilters[key] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: Colors.white, // Solid background for readability
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => setState(() => _localFilters.clear()),
                          child: const Text('Clear All'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            AppRepository.savePersistentFilters(_localFilters);
                            widget.onApply(_localFilters);
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      _buildGeoUnitsSection(),
                      _buildSection('Castes', 'caste_id', 'castes'),
                      _buildSection('Religions', 'religion_id', 'religions'),
                      _buildFavorabilitySection(),
                      _buildAgeRangeSection(),
                      _buildSectionNumberFilter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(String label, String filterKey, String tableName) {
    return ExpansionTile(
      title: Text(label),
      subtitle: _localFilters[filterKey] != null 
          ? const Text('Filter active', style: TextStyle(color: Colors.blue, fontSize: 12)) 
          : null,
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: AppRepository.getLookupData(tableName),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return Column(
              children: snapshot.data!.map((item) {
                final id = item['id'].toString();
                final isSelected = _localFilters[filterKey]?.toString() == id;
                return RadioListTile<String>(
                  title: Text(item['name'] ?? 'Unknown'),
                  value: id,
                  groupValue: _localFilters[filterKey]?.toString(),
                  onChanged: (val) => _updateFilter(filterKey, val),
                  secondary: isSelected 
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18), 
                        onPressed: () => _updateFilter(filterKey, null)
                      ) 
                    : null,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  /// Get geo units accessible to the current user (user's geo_unit + children)
  Future<List<Map<String, dynamic>>> _getAccessibleGeoUnits() async {
    return await AppRepository.getAccessibleGeoUnits(_userGeoUnitId);
  }

  /// Build geo units section with access control
  Widget _buildGeoUnitsSection() {
    return ExpansionTile(
      title: const Text('Geo Units'),
      subtitle: _localFilters['geo_unit_id'] != null 
          ? const Text('Filter active', style: TextStyle(color: Colors.blue, fontSize: 12)) 
          : null,
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _getAccessibleGeoUnits(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            
            final geoUnits = snapshot.data!;
            
            if (geoUnits.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No accessible geo units found', style: TextStyle(color: Colors.grey)),
              );
            }
            
            return Column(
              children: geoUnits.map((item) {
                final id = item['id'].toString();
                final isSelected = _localFilters['geo_unit_id']?.toString() == id;
                return RadioListTile<String>(
                  title: Text(item['name'] ?? 'Unknown'),
                  value: id,
                  groupValue: _localFilters['geo_unit_id']?.toString(),
                  onChanged: (val) => _updateFilter('geo_unit_id', val),
                  secondary: isSelected 
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18), 
                        onPressed: () => _updateFilter('geo_unit_id', null)
                      ) 
                    : null,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFavorabilitySection() {
    // Helper to get display label for favorability value
    String _getFavorabilityLabel(String? value) {
      switch (value) {
        case 'very_strong':
          return 'Very Strong';
        case 'strong':
          return 'Strong';
        case 'neutral':
          return 'Neutral';
        case 'lean_other':
          return 'Lean Other';
        case 'not_known':
          return 'Not Known';
        default:
          return value ?? '';
      }
    }

    return ExpansionTile(
      title: const Text('Favorability'),
      subtitle: _localFilters['favorability'] != null
          ? Text(_getFavorabilityLabel(_localFilters['favorability']), style: const TextStyle(color: Colors.blue, fontSize: 12))
          : null,
      children: [
        RadioListTile<String>(
          title: const Text('Very Strong'),
          value: 'very_strong',
          groupValue: _localFilters['favorability'],
          onChanged: (val) => _updateFilter('favorability', val),
        ),
        RadioListTile<String>(
          title: const Text('Strong'),
          value: 'strong',
          groupValue: _localFilters['favorability'],
          onChanged: (val) => _updateFilter('favorability', val),
        ),
        RadioListTile<String>(
          title: const Text('Neutral'),
          value: 'neutral',
          groupValue: _localFilters['favorability'],
          onChanged: (val) => _updateFilter('favorability', val),
        ),
        RadioListTile<String>(
          title: const Text('Lean Other'),
          value: 'lean_other',
          groupValue: _localFilters['favorability'],
          onChanged: (val) => _updateFilter('favorability', val),
        ),
        RadioListTile<String>(
          title: const Text('Not Known'),
          value: 'not_known',
          groupValue: _localFilters['favorability'],
          onChanged: (val) => _updateFilter('favorability', val),
        ),
        if (_localFilters['favorability'] != null)
          ListTile(
            leading: const Icon(Icons.clear, size: 18),
            title: const Text('Clear'),
            onTap: () => _updateFilter('favorability', null),
          ),
      ],
    );
  }

  Widget _buildAgeRangeSection() {
    return ExpansionTile(
      title: const Text('Age Range'),
      subtitle: (_localFilters['age_from'] != null || _localFilters['age_to'] != null)
          ? Text(
              'From: ${_localFilters['age_from'] ?? "Any"} - To: ${_localFilters['age_to'] ?? "Any"}',
              style: const TextStyle(color: Colors.blue, fontSize: 12),
            )
          : null,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Age From',
                    border: OutlineInputBorder(),
                    hintText: 'Min age',
                  ),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: _localFilters['age_from']?.toString() ?? '',
                  )..selection = TextSelection.collapsed(
                      offset: (_localFilters['age_from']?.toString() ?? '').length,
                    ),
                  onChanged: (val) {
                    final age = int.tryParse(val);
                    _updateFilter('age_from', age);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Age To',
                    border: OutlineInputBorder(),
                    hintText: 'Max age',
                  ),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: _localFilters['age_to']?.toString() ?? '',
                  )..selection = TextSelection.collapsed(
                      offset: (_localFilters['age_to']?.toString() ?? '').length,
                    ),
                  onChanged: (val) {
                    final age = int.tryParse(val);
                    _updateFilter('age_to', age);
                  },
                ),
              ),
            ],
          ),
        ),
        if (_localFilters['age_from'] != null || _localFilters['age_to'] != null)
          ListTile(
            leading: const Icon(Icons.clear, size: 18),
            title: const Text('Clear Age Range'),
            onTap: () {
              _updateFilter('age_from', null);
              _updateFilter('age_to', null);
            },
          ),
      ],
    );
  }

  Widget _buildSectionNumberFilter() {
    return ExpansionTile(
      title: const Text('Section Number'),
      subtitle: _localFilters['section_number'] != null
          ? Text(_localFilters['section_number'], style: const TextStyle(color: Colors.blue, fontSize: 12))
          : null,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Section Number',
              border: OutlineInputBorder(),
              hintText: 'e.g., 001, 002',
            ),
            controller: TextEditingController(
              text: _localFilters['section_number']?.toString() ?? '',
            )..selection = TextSelection.collapsed(
                offset: (_localFilters['section_number']?.toString() ?? '').length,
              ),
            onChanged: (val) {
              _updateFilter('section_number', val.isEmpty ? null : val);
            },
          ),
        ),
        if (_localFilters['section_number'] != null)
          ListTile(
            leading: const Icon(Icons.clear, size: 18),
            title: const Text('Clear Section'),
            onTap: () => _updateFilter('section_number', null),
          ),
      ],
    );
  }
}