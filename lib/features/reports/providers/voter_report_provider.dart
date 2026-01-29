import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:powersync/powersync.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/models/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Filter State
class VoterReportFilter {
  final String? districtId;
  final String? mandalId;
  final String? boothId;
  final int? religionId;
  final int? casteId;
  final int? subCasteId;
  final bool? isVisited;
  final bool? isPolled;
  final VoterFavorability? favorability;

  const VoterReportFilter({
    this.districtId,
    this.mandalId,
    this.boothId,
    this.religionId,
    this.casteId,
    this.subCasteId,
    this.isVisited,
    this.isPolled,
    this.favorability,
  });

  VoterReportFilter copyWith({
    String? districtId,
    String? mandalId,
    String? boothId,
    int? religionId,
    int? casteId,
    int? subCasteId,
    bool? isVisited,
    bool? isPolled,
    VoterFavorability? favorability,
    bool clearDistrict = false,
    bool clearMandal = false,
    bool clearBooth = false,
    bool clearReligion = false,
    bool clearCaste = false,
    bool clearSubCaste = false,
    bool clearFavorability = false,
  }) {
    return VoterReportFilter(
      districtId: clearDistrict ? null : (districtId ?? this.districtId),
      mandalId: clearMandal ? null : (mandalId ?? this.mandalId),
      boothId: clearBooth ? null : (boothId ?? this.boothId),
      religionId: clearReligion ? null : (religionId ?? this.religionId),
      casteId: clearCaste ? null : (casteId ?? this.casteId),
      subCasteId: clearSubCaste ? null : (subCasteId ?? this.subCasteId),
      isVisited: isVisited ?? this.isVisited,
      isPolled: isPolled ?? this.isPolled,
      favorability: clearFavorability ? null : (favorability ?? this.favorability),
    );
  }
}

// Filter State Notifier
class VoterReportFilterNotifier extends StateNotifier<VoterReportFilter> {
  VoterReportFilterNotifier() : super(const VoterReportFilter());

  void updateFilter({
    String? districtId,
    String? mandalId,
    String? boothId,
    int? religionId,
    int? casteId,
    int? subCasteId,
    bool? isVisited,
    bool? isPolled,
    VoterFavorability? favorability,
  }) {
    state = state.copyWith(
      districtId: districtId,
      mandalId: mandalId,
      boothId: boothId,
      religionId: religionId,
      casteId: casteId,
      subCasteId: subCasteId,
      isVisited: isVisited,
      isPolled: isPolled,
      favorability: favorability,
    );
  }

  void resetFilters() {
    state = const VoterReportFilter();
  }
}

// Aggregated Report Data
class VoterReportData {
  final int totalVoters;
  final int visitedCount;
  final int polledCount;
  final Map<String, int> favorabilityBreakdown;
  final List<BoothSummary> boothSummaries;

  const VoterReportData({
    required this.totalVoters,
    required this.visitedCount,
    required this.polledCount,
    required this.favorabilityBreakdown,
    required this.boothSummaries,
  });

  double get coveragePercentage =>
      totalVoters > 0 ? (visitedCount / totalVoters) * 100 : 0.0;

  double get polledPercentage =>
      totalVoters > 0 ? (polledCount / totalVoters) * 100 : 0.0;
}

class BoothSummary {
  final String boothId;
  final String boothName;
  final int totalVoters;
  final int visitedCount;
  final int polledCount;

  const BoothSummary({
    required this.boothId,
    required this.boothName,
    required this.totalVoters,
    required this.visitedCount,
    required this.polledCount,
  });

  double get coveragePercentage =>
      totalVoters > 0 ? (visitedCount / totalVoters) * 100 : 0.0;

  double get polledPercentage =>
      totalVoters > 0 ? (polledCount / totalVoters) * 100 : 0.0;
}

// Providers
final voterReportFilterProvider =
    StateNotifierProvider<VoterReportFilterNotifier, VoterReportFilter>((ref) {
  return VoterReportFilterNotifier();
});

final powersyncDatabaseProvider = Provider<PowerSyncDatabase>((ref) {
  return PowerSyncService().db;
});

final currentCampaignIdProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('campaign_id');
});

final currentUserGeoUnitIdProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('geo_unit_id');
});

// Main Report Data Provider
final voterReportDataProvider = StreamProvider<VoterReportData>((ref) {
  final db = ref.watch(powersyncDatabaseProvider);
  final filter = ref.watch(voterReportFilterProvider);
  final campaignIdAsync = ref.watch(currentCampaignIdProvider);
  final userGeoUnitIdAsync = ref.watch(currentUserGeoUnitIdProvider);

  final campaignId = campaignIdAsync.value;
  final userGeoUnitId = userGeoUnitIdAsync.value;

  if (campaignId == null || userGeoUnitId == null) {
    return Stream.value(const VoterReportData(
      totalVoters: 0,
      visitedCount: 0,
      polledCount: 0,
      favorabilityBreakdown: {},
      boothSummaries: [],
    ));
  }

  try {
    // Build SQL query with filters - use table alias 'v.' for voters table
    final conditions = <String>['v.campaign_id = ?'];
    final params = <dynamic>[campaignId];

    // Always apply user's geo unit hierarchy constraint
    conditions.add('(v.geo_unit_id = ? OR v.ancestors LIKE ?)');
    params.add(userGeoUnitId);
    params.add('%"$userGeoUnitId"%');

    // Apply additional filters
    if (filter.boothId != null) {
      conditions.add('v.geo_unit_id = ?');
      params.add(filter.boothId);
    } else if (filter.mandalId != null) {
      conditions.add('(v.geo_unit_id = ? OR v.ancestors LIKE ?)');
      params.add(filter.mandalId);
      params.add('%"${filter.mandalId}"%');
    } else if (filter.districtId != null) {
      conditions.add('(v.geo_unit_id = ? OR v.ancestors LIKE ?)');
      params.add(filter.districtId);
      params.add('%"${filter.districtId}"%');
    }

    if (filter.religionId != null) {
      conditions.add('v.religion_id = ?');
      params.add(filter.religionId);
    }

    if (filter.casteId != null) {
      conditions.add('v.caste_id = ?');
      params.add(filter.casteId);
    }

    if (filter.subCasteId != null) {
      conditions.add('v.sub_caste_id = ?');
      params.add(filter.subCasteId);
    }

    if (filter.isVisited != null) {
      if (filter.isVisited!) {
        conditions.add('v.last_visited_at IS NOT NULL');
      } else {
        conditions.add('v.last_visited_at IS NULL');
      }
    }

    if (filter.isPolled != null) {
      conditions.add('v.is_polled = ?');
      params.add(filter.isPolled! ? 1 : 0);
    }

    if (filter.favorability != null) {
      conditions.add('v.favorability = ?');
      params.add(filter.favorability!.name);
    }

    final whereClause = conditions.join(' AND ');

    // Aggregated query for KPIs
    final kpiSql = '''
      SELECT 
        COUNT(*) as total_voters,
        SUM(CASE WHEN v.last_visited_at IS NOT NULL THEN 1 ELSE 0 END) as visited_count,
        SUM(CASE WHEN v.is_polled = 1 THEN 1 ELSE 0 END) as polled_count,
        SUM(CASE WHEN v.favorability = 'veryStrong' THEN 1 ELSE 0 END) as very_strong_count,
        SUM(CASE WHEN v.favorability = 'strong' THEN 1 ELSE 0 END) as strong_count,
        SUM(CASE WHEN v.favorability = 'neutral' THEN 1 ELSE 0 END) as neutral_count,
        SUM(CASE WHEN v.favorability = 'leanOther' THEN 1 ELSE 0 END) as lean_other_count,
        SUM(CASE WHEN v.favorability = 'notKnown' THEN 1 ELSE 0 END) as not_known_count
      FROM voters v
      WHERE $whereClause
    ''';

    // Booth-level aggregation
    final boothSql = '''
      SELECT 
        v.geo_unit_id as booth_id,
        g.name as booth_name,
        COUNT(*) as total_voters,
        SUM(CASE WHEN v.last_visited_at IS NOT NULL THEN 1 ELSE 0 END) as visited_count,
        SUM(CASE WHEN v.is_polled = 1 THEN 1 ELSE 0 END) as polled_count
      FROM voters v
      LEFT JOIN geo_units g ON v.geo_unit_id = g.id
      WHERE $whereClause
      GROUP BY v.geo_unit_id, g.name
      ORDER BY total_voters DESC
    ''';

    return db.watch(kpiSql, parameters: params).asyncMap((kpiRows) async {
      final kpiRow = kpiRows.isNotEmpty ? kpiRows.first : <String, dynamic>{};

      final boothRows = await db.getAll(boothSql, params);

    return VoterReportData(
      totalVoters: kpiRow['total_voters'] as int? ?? 0,
      visitedCount: kpiRow['visited_count'] as int? ?? 0,
      polledCount: kpiRow['polled_count'] as int? ?? 0,
      favorabilityBreakdown: {
        'veryStrong': kpiRow['very_strong_count'] as int? ?? 0,
        'strong': kpiRow['strong_count'] as int? ?? 0,
        'neutral': kpiRow['neutral_count'] as int? ?? 0,
        'leanOther': kpiRow['lean_other_count'] as int? ?? 0,
        'notKnown': kpiRow['not_known_count'] as int? ?? 0,
      },
      boothSummaries: boothRows.map((row) {
        return BoothSummary(
          boothId: row['booth_id'] as String? ?? '',
          boothName: row['booth_name'] as String? ?? 'Unknown Booth',
          totalVoters: row['total_voters'] as int? ?? 0,
          visitedCount: row['visited_count'] as int? ?? 0,
          polledCount: row['polled_count'] as int? ?? 0,
        );
      }).toList(),
    );
    });
  } catch (e) {
    // Return empty data on error
    return Stream.value(const VoterReportData(
      totalVoters: 0,
      visitedCount: 0,
      polledCount: 0,
      favorabilityBreakdown: {},
      boothSummaries: [],
    ));
  }
});
