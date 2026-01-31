import 'package:flutter/material.dart';
import 'package:mobileapp/features/dashboard/models/dashboard_stats.dart';
import 'package:mobileapp/models/enums.dart';

class FavorabilityChart extends StatelessWidget {
  final List<FavorabilityDistribution> distribution;
  final Function(String code)? onTapBar;

  const FavorabilityChart({
    super.key,
    required this.distribution,
    this.onTapBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (distribution.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No data available'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: distribution.map((item) {
        return _FavorabilityBar(
          favorability: item.favorability,
          code: item.code,
          count: item.count,
          percentage: item.percentage,
          color: _getColorForCode(item.code, theme),
          onTap: onTapBar != null ? () => onTapBar!(item.code) : null,
        );
      }).toList(),
    );
  }

  Color _getColorForCode(String code, ThemeData theme) {
    final favorability = VoterFavorability.fromString(code);
    return favorability.color;
  }
}

class _FavorabilityBar extends StatelessWidget {
  final String favorability;
  final String code;
  final int count;
  final double percentage;
  final Color color;
  final VoidCallback? onTap;

  const _FavorabilityBar({
    required this.favorability,
    required this.code,
    required this.count,
    required this.percentage,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label and percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    favorability,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}% ($count)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Bar
              Stack(
                children: [
                  // Background
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  
                  // Foreground (percentage)
                  FractionallySizedBox(
                    widthFactor: percentage / 100,
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
