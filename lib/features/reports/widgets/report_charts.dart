import 'package:flutter/material.dart';
import '../providers/voter_report_provider.dart';

class FavorabilityBarChart extends StatelessWidget {
  final Map<String, int> favorabilityBreakdown;
  final int totalVoters;

  const FavorabilityBarChart({
    super.key,
    required this.favorabilityBreakdown,
    required this.totalVoters,
  });

  @override
  Widget build(BuildContext context) {
    if (totalVoters == 0) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('No data available'),
        ),
      );
    }

    final data = [
      _FavorabilityData('Very Strong', favorabilityBreakdown['veryStrong'] ?? 0, Colors.green[700]!),
      _FavorabilityData('Strong', favorabilityBreakdown['strong'] ?? 0, Colors.green[400]!),
      _FavorabilityData('Neutral', favorabilityBreakdown['neutral'] ?? 0, Colors.grey[400]!),
      _FavorabilityData('Lean Other', favorabilityBreakdown['leanOther'] ?? 0, Colors.orange[400]!),
      _FavorabilityData('Not Known', favorabilityBreakdown['notKnown'] ?? 0, Colors.red[400]!),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Favorability Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: data.map((item) {
              final percentage = totalVoters > 0 ? (item.count / totalVoters) * 100 : 0.0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: _BarItem(
                  label: item.label,
                  count: item.count,
                  percentage: percentage,
                  color: item.color,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _FavorabilityData {
  final String label;
  final int count;
  final Color color;

  _FavorabilityData(this.label, this.count, this.color);
}

class _BarItem extends StatelessWidget {
  final String label;
  final int count;
  final double percentage;
  final Color color;

  const _BarItem({
    required this.label,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '$count (${percentage.toStringAsFixed(1)}%)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BoothListCard extends StatelessWidget {
  final BoothSummary booth;

  const BoothListCard({
    super.key,
    required this.booth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booth.boothName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${booth.totalVoters} voters',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatColumn(
                    label: 'Coverage',
                    value: '${booth.coveragePercentage.toStringAsFixed(1)}%',
                    subtitle: '${booth.visitedCount}/${booth.totalVoters}',
                    color: Colors.blue,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                Expanded(
                  child: _StatColumn(
                    label: 'Polled',
                    value: '${booth.polledPercentage.toStringAsFixed(1)}%',
                    subtitle: '${booth.polledCount}/${booth.totalVoters}',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color color;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
