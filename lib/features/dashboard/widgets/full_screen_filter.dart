import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/dashboard/models/dashboard_filters.dart';
import 'package:mobileapp/features/dashboard/controllers/dashboard_controller.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/l10n/app_localizations.dart';
import 'package:mobileapp/models/enums.dart';

enum FilterCategory {
  geographic,
  demographics,
  status,
  activity,
  contact,
  favorability,
}

class FullScreenFilter extends ConsumerStatefulWidget {
  const FullScreenFilter({super.key});

  @override
  ConsumerState<FullScreenFilter> createState() => _FullScreenFilterState();
}

class _FullScreenFilterState extends ConsumerState<FullScreenFilter> {
  FilterCategory _selectedCategory = FilterCategory.geographic;
  late DashboardFilters _workingFilters;

  @override
  void initState() {
    super.initState();
    _workingFilters = ref.read(dashboardFiltersProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    
    if (l10n == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.filters),
        elevation: 1,
      ),
      body: Row(
        children: [
          // Left Panel: Categories (30%)
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.grey[100],
            child: ListView(
              children: [
                _buildCategoryItem(
                  category: FilterCategory.geographic,
                  icon: Icons.location_on,
                  label: l10n.geographic,
                ),
                _buildCategoryItem(
                  category: FilterCategory.demographics,
                  icon: Icons.people,
                  label: l10n.demographics,
                ),
                _buildCategoryItem(
                  category: FilterCategory.status,
                  icon: Icons.check_circle,
                  label: l10n.status,
                ),
                _buildCategoryItem(
                  category: FilterCategory.activity,
                  icon: Icons.history,
                  label: l10n.activity,
                ),
                _buildCategoryItem(
                  category: FilterCategory.contact,
                  icon: Icons.phone,
                  label: l10n.contact,
                ),
                _buildCategoryItem(
                  category: FilterCategory.favorability,
                  icon: Icons.favorite,
                  label: l10n.favorability,
                ),
              ],
            ),
          ),
          
          // Right Panel: Filter Options (70%)
          Expanded(
            child: Container(
              color: Colors.white,
              child: _buildFilterOptions(),
            ),
          ),
        ],
      ),
      
      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Clear All button
            Expanded(
              child: OutlinedButton(
                onPressed: _clearFilters,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.clearAll),
              ),
            ),
            const SizedBox(width: 12),
            
            // Apply button
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.apply),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem({
    required FilterCategory category,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedCategory == category;
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? theme.primaryColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? theme.primaryColor : Colors.grey[600],
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? theme.primaryColor : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    switch (_selectedCategory) {
      case FilterCategory.geographic:
        return _GeographicFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
      case FilterCategory.demographics:
        return _DemographicsFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
      case FilterCategory.status:
        return _StatusFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
      case FilterCategory.activity:
        return _ActivityFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
      case FilterCategory.contact:
        return _ContactFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
      case FilterCategory.favorability:
        return _FavorabilityFilterOptions(
          filters: _workingFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _workingFilters = filters;
            });
          },
        );
    }
  }

  void _clearFilters() {
    setState(() {
      _workingFilters = const DashboardFilters();
    });
  }

  void _applyFilters() {
    ref.read(dashboardFiltersProvider.notifier).state = _workingFilters;
    Navigator.of(context).pop();
  }
}

// Geographic Filter Options
class _GeographicFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _GeographicFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: AppRepository.getLookupData('geo_units'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final geoUnits = snapshot.data!;
        
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              l10n.selectGeoUnits,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...geoUnits.map((unit) {
              final id = unit['id'].toString();
              final name = unit['name'] as String;
              final isSelected = filters.selectedGeoUnitIds.contains(id);
              
              return CheckboxListTile(
                value: isSelected,
                onChanged: (value) {
                  final newIds = List<String>.from(filters.selectedGeoUnitIds);
                  if (value == true) {
                    newIds.add(id);
                  } else {
                    newIds.remove(id);
                  }
                  onFiltersChanged(filters.copyWith(selectedGeoUnitIds: newIds));
                },
                title: Text(name),
              );
            }),
          ],
        );
      },
    );
  }
}

// Demographics Filter Options
class _DemographicsFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _DemographicsFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Age Range
        Text(
          l10n.ageRange,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.minAge,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                  text: filters.ageMin?.toString() ?? '',
                ),
                onChanged: (value) {
                  final age = int.tryParse(value);
                  onFiltersChanged(filters.copyWith(ageMin: age));
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.maxAge,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                  text: filters.ageMax?.toString() ?? '',
                ),
                onChanged: (value) {
                  final age = int.tryParse(value);
                  onFiltersChanged(filters.copyWith(ageMax: age));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Gender
        Text(
          l10n.gender,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['Male', 'Female', 'Other'].map((gender) {
            final isSelected = filters.selectedGenders.contains(gender);
            return FilterChip(
              label: Text(gender),
              selected: isSelected,
              onSelected: (value) {
                final newGenders = List<String>.from(filters.selectedGenders);
                if (value) {
                  newGenders.add(gender);
                } else {
                  newGenders.remove(gender);
                }
                onFiltersChanged(filters.copyWith(selectedGenders: newGenders));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        
        // Religion, Caste, Education dropdowns
        _buildLookupFilter(
          context,
          label: l10n.religion,
          tableName: 'religions',
          selectedIds: filters.selectedReligionIds,
          onChanged: (ids) {
            onFiltersChanged(filters.copyWith(selectedReligionIds: ids));
          },
        ),
        const SizedBox(height: 16),
        _buildLookupFilter(
          context,
          label: l10n.caste,
          tableName: 'castes',
          selectedIds: filters.selectedCasteIds,
          onChanged: (ids) {
            onFiltersChanged(filters.copyWith(selectedCasteIds: ids));
          },
        ),
        const SizedBox(height: 16),
        _buildLookupFilter(
          context,
          label: l10n.education,
          tableName: 'educations',
          selectedIds: filters.selectedEducationIds,
          onChanged: (ids) {
            onFiltersChanged(filters.copyWith(selectedEducationIds: ids));
          },
        ),
      ],
    );
  }

  Widget _buildLookupFilter(
    BuildContext context, {
    required String label,
    required String tableName,
    required List<int> selectedIds,
    required Function(List<int>) onChanged,
  }) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: AppRepository.getLookupData(tableName),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        
        final items = snapshot.data!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) {
                final id = item['id'] as int;
                final name = item['name'] as String;
                final isSelected = selectedIds.contains(id);
                
                return FilterChip(
                  label: Text(name),
                  selected: isSelected,
                  onSelected: (value) {
                    final newIds = List<int>.from(selectedIds);
                    if (value) {
                      newIds.add(id);
                    } else {
                      newIds.remove(id);
                    }
                    onChanged(newIds);
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

// Status Filter Options
class _StatusFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _StatusFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBooleanFilter(
          label: l10n.polled,
          value: filters.isPolled,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(isPolled: value));
          },
        ),
        const SizedBox(height: 16),
        _buildBooleanFilter(
          label: l10n.dead,
          value: filters.isDead,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(isDead: value));
          },
        ),
        const SizedBox(height: 16),
        _buildBooleanFilter(
          label: l10n.shifted,
          value: filters.isShifted,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(isShifted: value));
          },
        ),
      ],
    );
  }

  Widget _buildBooleanFilter({
    required String label,
    required bool? value,
    required Function(bool?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('Yes'),
                value: true,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('No'),
                value: false,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('Both'),
                value: null,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Activity Filter Options
class _ActivityFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _ActivityFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CheckboxListTile(
          value: filters.neverVisited,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(neverVisited: value ?? false));
          },
          title: Text(l10n.neverVisited),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.lastVisitedDateRange,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          title: Text(
            filters.lastVisitedFrom != null
                ? '${l10n.from}: ${filters.lastVisitedFrom!.toLocal().toString().split(' ')[0]}'
                : l10n.selectFromDate,
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: filters.lastVisitedFrom ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onFiltersChanged(filters.copyWith(lastVisitedFrom: date));
            }
          },
        ),
        ListTile(
          title: Text(
            filters.lastVisitedTo != null
                ? '${l10n.to}: ${filters.lastVisitedTo!.toLocal().toString().split(' ')[0]}'
                : l10n.selectToDate,
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: filters.lastVisitedTo ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onFiltersChanged(filters.copyWith(lastVisitedTo: date));
            }
          },
        ),
      ],
    );
  }
}

// Contact Filter Options
class _ContactFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _ContactFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBooleanFilter(
          label: l10n.hasPhone,
          value: filters.hasPhone,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(hasPhone: value));
          },
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          value: filters.hasMobile,
          onChanged: (value) {
            onFiltersChanged(filters.copyWith(hasMobile: value ?? false));
          },
          title: Text(l10n.hasMobile),
          subtitle: const Text('10-digit mobile number'),
        ),
      ],
    );
  }

  Widget _buildBooleanFilter({
    required String label,
    required bool? value,
    required Function(bool?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('Yes'),
                value: true,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('No'),
                value: false,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('Both'),
                value: null,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Favorability Filter Options
class _FavorabilityFilterOptions extends StatelessWidget {
  final DashboardFilters filters;
  final Function(DashboardFilters) onFiltersChanged;

  const _FavorabilityFilterOptions({
    required this.filters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final favorabilities = VoterFavorability.values;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.selectFavorability,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: favorabilities.map((fav) {
            final isSelected = filters.selectedFavorabilities.contains(fav.databaseValue);
            
            return FilterChip(
              label: Text(fav.label),
              selected: isSelected,
              onSelected: (value) {
                final newFavs = List<String>.from(filters.selectedFavorabilities);
                if (value) {
                  newFavs.add(fav.databaseValue);
                } else {
                  newFavs.remove(fav.databaseValue);
                }
                onFiltersChanged(filters.copyWith(selectedFavorabilities: newFavs));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
