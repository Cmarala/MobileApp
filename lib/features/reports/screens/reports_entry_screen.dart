import 'package:flutter/material.dart';
import 'voter_report_screen.dart';

class ReportsEntryScreen extends StatelessWidget {
  const ReportsEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ReportCard(
              icon: Icons.people_alt_rounded,
              title: 'Voter Insights',
              description: 'Detailed voter demographics, coverage & sentiment analysis',
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VoterReportScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _ReportCard(
              icon: Icons.poll_rounded,
              title: 'Survey Insights',
              description: 'Survey responses, completion rates & trending topics',
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
              ),
              onTap: () {
                // TODO: Implement Survey Insights
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Survey Insights - Coming Soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ReportCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
