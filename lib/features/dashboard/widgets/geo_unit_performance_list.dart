import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/dashboard/models/geo_unit_performance.dart';
import 'package:mobileapp/features/dashboard/controllers/dashboard_controller.dart';

class GeoUnitPerformanceList extends ConsumerWidget {
  final List<GeoUnitPerformance> performance;
  final Function(String geoUnitId)? onTapGeoUnit;

  const GeoUnitPerformanceList({
    super.key,
    required this.performance,
    this.onTapGeoUnit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metric = ref.watch(performanceMetricProvider);
    final theme = Theme.of(context);
    
    if (performance.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No sub-areas available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        // Radio Toggle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _RadioOption(
                  label: 'Voters Contacted',
                  isSelected: metric == PerformanceMetric.contacted,
                  onTap: () {
                    ref.read(performanceMetricProvider.notifier).state = 
                        PerformanceMetric.contacted;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RadioOption(
                  label: 'Polled',
                  isSelected: metric == PerformanceMetric.polled,
                  onTap: () {
                    ref.read(performanceMetricProvider.notifier).state = 
                        PerformanceMetric.polled;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // Performance List
        ...performance.map((item) {
          return _PerformanceListItem(
            geoUnitName: item.geoUnitName,
            geoUnitNameLocal: item.geoUnitNameLocal,
            totalVoters: item.totalVoters,
            metricCount: item.metricCount,
            percentage: item.percentage,
            color: theme.primaryColor,
            onTap: onTapGeoUnit != null 
                ? () => onTapGeoUnit!(item.geoUnitId) 
                : null,
          );
        }),
      ],
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceListItem extends StatelessWidget {
  final String geoUnitName;
  final String geoUnitNameLocal;
  final int totalVoters;
  final int metricCount;
  final double percentage;
  final Color color;
  final VoidCallback? onTap;

  const _PerformanceListItem({
    required this.geoUnitName,
    required this.geoUnitNameLocal,
    required this.totalVoters,
    required this.metricCount,
    required this.percentage,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Geo unit info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      geoUnitName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$metricCount / $totalVoters voters',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Percentage badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              
              // Arrow icon
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey[400],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
