import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/enums.dart';
import '../providers/voter_report_provider.dart';

class ReportFilterDrawer extends ConsumerWidget {
  const ReportFilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(voterReportFilterProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.filter_alt_rounded, color: Colors.white, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Report Filters',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _FilterSection(
                    title: 'Geography',
                    icon: Icons.location_on,
                    child: Column(
                      children: [
                        _FilterChip(
                          label: 'District',
                          value: filterState.districtId,
                          onTap: () => _showGeoUnitPicker(
                            context,
                            ref,
                            'District',
                            'district',
                          ),
                        ),
                        _FilterChip(
                          label: 'Mandal',
                          value: filterState.mandalId,
                          onTap: () => _showGeoUnitPicker(
                            context,
                            ref,
                            'Mandal',
                            'mandal',
                          ),
                        ),
                        _FilterChip(
                          label: 'Booth',
                          value: filterState.boothId,
                          onTap: () => _showGeoUnitPicker(
                            context,
                            ref,
                            'Booth',
                            'booth',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  _FilterSection(
                    title: 'Identity',
                    icon: Icons.person,
                    child: Column(
                      children: [
                        _FilterChip(
                          label: 'Religion',
                          value: filterState.religionId?.toString(),
                          onTap: () => _showMasterDataPicker(
                            context,
                            ref,
                            'Religion',
                            'religions',
                          ),
                        ),
                        _FilterChip(
                          label: 'Caste',
                          value: filterState.casteId?.toString(),
                          onTap: () => _showMasterDataPicker(
                            context,
                            ref,
                            'Caste',
                            'castes',
                          ),
                        ),
                        _FilterChip(
                          label: 'Sub-Caste',
                          value: filterState.subCasteId?.toString(),
                          onTap: () => _showMasterDataPicker(
                            context,
                            ref,
                            'Sub-Caste',
                            'sub_castes',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  _FilterSection(
                    title: 'Status',
                    icon: Icons.check_circle,
                    child: Column(
                      children: [
                        _BooleanFilterChip(
                          label: 'Visited',
                          value: filterState.isVisited,
                          onChanged: (val) {
                            ref.read(voterReportFilterProvider.notifier).updateFilter(
                              isVisited: val,
                            );
                          },
                        ),
                        _BooleanFilterChip(
                          label: 'Polled',
                          value: filterState.isPolled,
                          onChanged: (val) {
                            ref.read(voterReportFilterProvider.notifier).updateFilter(
                              isPolled: val,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  _FilterSection(
                    title: 'Sentiment',
                    icon: Icons.sentiment_satisfied,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: VoterFavorability.values.map((fav) {
                        final isSelected = filterState.favorability == fav;
                        return FilterChip(
                          label: Text(_favorabilityLabel(fav)),
                          selected: isSelected,
                          onSelected: (selected) {
                            ref.read(voterReportFilterProvider.notifier).updateFilter(
                              favorability: selected ? fav : null,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref.read(voterReportFilterProvider.notifier).resetFilters();
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Reset All'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.done),
                          label: const Text('Apply'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _favorabilityLabel(VoterFavorability fav) {
    switch (fav) {
      case VoterFavorability.veryStrong:
        return 'Very Strong';
      case VoterFavorability.strong:
        return 'Strong';
      case VoterFavorability.neutral:
        return 'Neutral';
      case VoterFavorability.leanOther:
        return 'Lean Other';
      case VoterFavorability.notKnown:
        return 'Not Known';
    }
  }

  void _showGeoUnitPicker(
    BuildContext context,
    WidgetRef ref,
    String title,
    String type,
  ) {
    // TODO: Implement geo unit picker with hierarchy
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title filter - Coming soon')),
    );
  }

  void _showMasterDataPicker(
    BuildContext context,
    WidgetRef ref,
    String title,
    String table,
  ) {
    // TODO: Implement master data picker
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title filter - Coming soon')),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _FilterSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: hasValue
                ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasValue
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: hasValue ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              Icon(
                hasValue ? Icons.check_circle : Icons.arrow_forward_ios,
                size: 16,
                color: hasValue
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BooleanFilterChip extends StatelessWidget {
  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const _BooleanFilterChip({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          SegmentedButton<bool?>(
            segments: const [
              ButtonSegment(value: null, label: Text('All')),
              ButtonSegment(value: true, label: Text('Yes')),
              ButtonSegment(value: false, label: Text('No')),
            ],
            selected: {value},
            onSelectionChanged: (Set<bool?> newSelection) {
              onChanged(newSelection.first);
            },
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
