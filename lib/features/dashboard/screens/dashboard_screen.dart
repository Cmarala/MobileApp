import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/dashboard/controllers/dashboard_controller.dart';
import 'package:mobileapp/features/dashboard/models/dashboard_filters.dart';
import 'package:mobileapp/features/dashboard/widgets/kpi_card.dart';
import 'package:mobileapp/features/dashboard/widgets/favorability_chart.dart';
import 'package:mobileapp/features/dashboard/widgets/geo_unit_performance_list.dart';
import 'package:mobileapp/features/dashboard/widgets/full_screen_filter.dart';
import 'package:mobileapp/l10n/app_localizations.dart';
import 'package:mobileapp/features/voter_search/screens/voter_console_screen.dart';
import 'package:mobileapp/features/reports/screens/reports_entry_screen.dart';
import 'package:powersync/powersync.dart' hide Column;
import 'package:mobileapp/sync/powersync_service.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final theme = Theme.of(context);
    final filters = ref.watch(dashboardFiltersProvider);
    final statsAsync = ref.watch(dashboardStatsProvider);
    final favorabilityAsync = ref.watch(favorabilityDistributionProvider);
    final performanceAsync = ref.watch(geoUnitPerformanceProvider);
    final geoUnitNameAsync = ref.watch(currentGeoUnitNameProvider);
    final appUserAsync = ref.watch(appUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard),
        elevation: 1,
        actions: [
          // Filter icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FullScreenFilter(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              if (filters.hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '${filters.activeFilterCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatsProvider);
          ref.invalidate(favorabilityDistributionProvider);
          ref.invalidate(geoUnitPerformanceProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // Context Bar
            _buildContextBar(appUserAsync, geoUnitNameAsync),
            const SizedBox(height: 16),

            // Section 1: KPI Cards (2x2 Grid)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildKpiSection(statsAsync, l10n),
            ),
            const SizedBox(height: 24),

            // Section 2: Favorability Distribution
            _buildSection(
              title: l10n.favorabilityDistribution,
              child: favorabilityAsync.when(
                data: (distribution) {
                  if (distribution.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No favorability data available'),
                      ),
                    );
                  }
                  return FavorabilityChart(
                    distribution: distribution,
                    onTapBar: (code) {
                      // Navigate to voter console with favorability filter
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const VoterConsoleScreen(),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stack) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 8),
                          Text('Error: ${error.toString()}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Section 4: Geo-Unit Performance
            _buildSection(
              title: l10n.geoUnitPerformance,
              child: performanceAsync.when(
                data: (performance) => GeoUnitPerformanceList(
                  performance: performance,
                  onTapGeoUnit: (geoUnitId) {
                    // Drill down to this geo unit
                    ref.read(currentGeoUnitProvider.notifier).state = geoUnitId;
                  },
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stack) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 8),
                          Text('Error: ${error.toString()}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      // Section 6: Quick Actions (FABs)
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'search',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const VoterConsoleScreen(),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'reports',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ReportsEntryScreen(),
                ),
              );
            },
            child: const Icon(Icons.assessment),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'export',
            onPressed: _exportCsv,
            child: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }

  Widget _buildContextBar(
    AsyncValue<dynamic> appUserAsync,
    AsyncValue<String> geoUnitNameAsync,
  ) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              Icon(
                Icons.person,
                size: 20,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 8),
              appUserAsync.when(
                data: (user) => Text(
                  user?.userName ?? 'Unknown User',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                loading: () => const Text('Loading...'),
                error: (_, __) => const Text('Unknown User'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Geo unit
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 20,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 8),
              geoUnitNameAsync.when(
                data: (name) => Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                loading: () => const Text('Loading...'),
                error: (_, __) => const Text('Unknown'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Online/Offline indicator
          StreamBuilder<SyncStatus>(
            stream: PowerSyncService().db.statusStream,
            builder: (context, snapshot) {
              final isOnline = snapshot.data?.connected ?? false;
              
              return Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  
                  // Last sync time
                  if (snapshot.data?.lastSyncedAt != null)
                    Text(
                      'Last sync: ${_formatLastSync(snapshot.data!.lastSyncedAt!)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKpiSection(AsyncValue<dynamic> statsAsync, AppLocalizations l10n) {
    return statsAsync.when(
      data: (stats) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.4,
          children: [
            KpiCard(
              icon: Icons.people,
              label: l10n.totalVoters,
              value: stats.totalVoters,
              onTap: () {
                // Navigate to all voters
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VoterConsoleScreen(),
                  ),
                );
              },
            ),
            KpiCard(
              icon: Icons.phone_in_talk,
              label: l10n.votersContactedToday,
              value: stats.contactedToday,
              percentage: stats.contactedTodayPercentage,
              iconColor: Colors.blue,
              onTap: () {
                // Navigate to contacted today voters
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VoterConsoleScreen(),
                  ),
                );
              },
            ),
            KpiCard(
              icon: Icons.how_to_vote,
              label: l10n.polledVoters,
              value: stats.polledVoters,
              percentage: stats.polledPercentage,
              iconColor: Colors.green,
              onTap: () {
                // Navigate to polled voters
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VoterConsoleScreen(),
                  ),
                );
              },
            ),
            KpiCard(
              icon: Icons.pending_actions,
              label: l10n.pendingContacts,
              value: stats.pendingContacts,
              iconColor: Colors.orange,
              onTap: () {
                // Navigate to pending voters
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VoterConsoleScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text('Error loading stats: ${error.toString()}'),
                const SizedBox(height: 8),
                Text('Stack: ${stack.toString()}', style: const TextStyle(fontSize: 10)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  String _formatLastSync(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  Future<void> _exportCsv() async {
    // TODO: Implement CSV export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('CSV export coming soon')),
    );
  }
}

