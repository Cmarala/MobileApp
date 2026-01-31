import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/dashboard/models/dashboard_stats.dart';
import 'package:mobileapp/features/dashboard/models/dashboard_filters.dart';
import 'package:mobileapp/features/dashboard/models/geo_unit_performance.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/data/dashboard_repository.dart';
import 'package:mobileapp/models/app_user.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for current dashboard filters
final dashboardFiltersProvider = StateProvider<DashboardFilters>((ref) {
  return const DashboardFilters();
});

/// Provider for current performance metric (contacted vs polled)
final performanceMetricProvider = StateProvider<PerformanceMetric>((ref) {
  return PerformanceMetric.contacted;
});

/// Provider for current geo unit context (for drill-down)
/// If null, uses user's geo_unit_id from AppUser
final currentGeoUnitProvider = StateProvider<String?>((ref) => null);

/// Provider for dashboard statistics
final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((ref) async {
  try {
    // Get user's geo unit (or current context if drilled down)
    final appUserAsync = ref.watch(appUserProvider);
    final currentGeoUnit = ref.watch(currentGeoUnitProvider);
    final filters = ref.watch(dashboardFiltersProvider);
    
    return await appUserAsync.when(
      data: (appUser) async {
        if (appUser == null) {
          return const DashboardStats();
        }
        
        final geoUnitId = currentGeoUnit ?? appUser.geoUnitId;
        
        final statsMap = await DashboardRepository.getDashboardStats(
          geoUnitId: geoUnitId,
          filters: filters.hasActiveFilters ? _filtersToMap(filters) : null,
        );
        
        return DashboardStats.fromJson(statsMap);
      },
      loading: () => const DashboardStats(),
      error: (_, __) => const DashboardStats(),
    );
  } catch (e, st) {
    Logger.logError(e, st, 'Failed to load dashboard stats');
    return const DashboardStats();
  }
});

/// Provider for favorability distribution
final favorabilityDistributionProvider = 
    FutureProvider.autoDispose<List<FavorabilityDistribution>>((ref) async {
  try {
    final appUserAsync = ref.watch(appUserProvider);
    final currentGeoUnit = ref.watch(currentGeoUnitProvider);
    final filters = ref.watch(dashboardFiltersProvider);
    
    return await appUserAsync.when(
      data: (appUser) async {
        if (appUser == null) {
          return [];
        }
        
        final geoUnitId = currentGeoUnit ?? appUser.geoUnitId;
        
        final distributionList = await DashboardRepository.getFavorabilityDistribution(
          geoUnitId: geoUnitId,
          filters: filters.hasActiveFilters ? _filtersToMap(filters) : null,
        );
        
        return distributionList
            .map((map) => FavorabilityDistribution.fromJson(map))
            .toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  } catch (e, st) {
    Logger.logError(e, st, 'Failed to load favorability distribution');
    return [];
  }
});

/// Provider for geo unit performance
final geoUnitPerformanceProvider = 
    FutureProvider.autoDispose<List<GeoUnitPerformance>>((ref) async {
  try {
    final appUserAsync = ref.watch(appUserProvider);
    final currentGeoUnit = ref.watch(currentGeoUnitProvider);
    final filters = ref.watch(dashboardFiltersProvider);
    final metric = ref.watch(performanceMetricProvider);
    
    return await appUserAsync.when(
      data: (appUser) async {
        if (appUser == null) {
          return [];
        }
        
        final geoUnitId = currentGeoUnit ?? appUser.geoUnitId;
        
        final performanceList = await DashboardRepository.getGeoUnitPerformance(
          geoUnitId: geoUnitId,
          metric: metric == PerformanceMetric.contacted ? 'contacted' : 'polled',
          filters: filters.hasActiveFilters ? _filtersToMap(filters) : null,
        );
        
        return performanceList
            .map((map) => GeoUnitPerformance.fromJson(map))
            .toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  } catch (e, st) {
    Logger.logError(e, st, 'Failed to load geo unit performance');
    return [];
  }
});

/// Provider for current geo unit name (for context bar)
final currentGeoUnitNameProvider = FutureProvider.autoDispose<String>((ref) async {
  try {
    final appUserAsync = ref.watch(appUserProvider);
    final currentGeoUnit = ref.watch(currentGeoUnitProvider);
    
    return await appUserAsync.when(
      data: (appUser) async {
        if (appUser == null) return 'Unknown';
        
        final geoUnitId = currentGeoUnit ?? appUser.geoUnitId;
        
        final result = await AppRepository.db.getOptional(
          'SELECT name FROM geo_units WHERE id = ?',
          [geoUnitId],
        );
        
        return result?['name'] as String? ?? 'Unknown';
      },
      loading: () => 'Loading...',
      error: (_, __) => 'Unknown',
    );
  } catch (e, st) {
    Logger.logError(e, st, 'Failed to load geo unit name');
    return 'Unknown';
  }
});

/// Helper to convert DashboardFilters to Map for repository
Map<String, dynamic> _filtersToMap(DashboardFilters filters) {
  return filters.toJson();
}

/// App user provider - loads from SharedPreferences
final appUserProvider = FutureProvider<AppUser?>((ref) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    
    // Try to load from saved user data
    final userId = prefs.getString('user_id');
    final userName = prefs.getString('user_name');
    final campaignId = prefs.getString('campaign_id');
    final geoUnitId = prefs.getString('geo_unit_id');
    final token = prefs.getString('powersync_token');
    
    if (userId == null || campaignId == null || geoUnitId == null || token == null) {
      Logger.logInfo('No user data found in SharedPreferences');
      return null;
    }
    
    return AppUser(
      id: userId,
      userName: userName,
      campaignId: campaignId,
      geoUnitId: geoUnitId,
      token: token,
      isActive: true,
    );
  } catch (e, st) {
    Logger.logError(e, st, 'Failed to load app user');
    return null;
  }
});
