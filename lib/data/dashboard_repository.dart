import 'package:powersync/powersync.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/utils/logger.dart';

class DashboardRepository {
  static PowerSyncDatabase get db => PowerSyncService().db;
  static const String tableVoters = 'voters';

  /// Get dashboard statistics for a specific geo unit
  /// Applies hierarchical filtering (includes children)
  static Future<Map<String, dynamic>> getDashboardStats({
    required String geoUnitId,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final whereClause = _buildWhereClause(geoUnitId, filters);
      final params = _buildParams(geoUnitId, filters);
      
      // Total voters
      final totalResult = await db.getOptional(
        'SELECT COUNT(*) as count FROM $tableVoters WHERE $whereClause',
        params,
      );
      final totalVoters = totalResult?['count'] as int? ?? 0;
      
      // Voters contacted (all time)
      final contactedResult = await db.getOptional(
        '''
        SELECT COUNT(*) as count FROM $tableVoters 
        WHERE $whereClause AND last_visited_at IS NOT NULL
        ''',
        params,
      );
      final contacted = contactedResult?['count'] as int? ?? 0;
      
      // Polled voters
      final polledResult = await db.getOptional(
        'SELECT COUNT(*) as count FROM $tableVoters WHERE $whereClause AND is_polled = 1',
        params,
      );
      final polledVoters = polledResult?['count'] as int? ?? 0;
      
      // Pending contacts (never visited or no phone)
      final pendingResult = await db.getOptional(
        '''
        SELECT COUNT(*) as count FROM $tableVoters 
        WHERE $whereClause AND (last_visited_at IS NULL OR phone IS NULL)
        ''',
        params,
      );
      final pendingContacts = pendingResult?['count'] as int? ?? 0;
      
      return {
        'totalVoters': totalVoters,
        'contactedToday': contacted,
        'polledVoters': polledVoters,
        'pendingContacts': pendingContacts,
        'contactedTodayPercentage': totalVoters > 0 ? (contacted / totalVoters * 100) : 0.0,
        'polledPercentage': totalVoters > 0 ? (polledVoters / totalVoters * 100) : 0.0,
      };
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get dashboard stats');
      return {
        'totalVoters': 0,
        'contactedToday': 0,
        'polledVoters': 0,
        'pendingContacts': 0,
        'contactedTodayPercentage': 0.0,
        'polledPercentage': 0.0,
      };
    }
  }
  
  /// Get favorability distribution for dashboard chart
  static Future<List<Map<String, dynamic>>> getFavorabilityDistribution({
    required String geoUnitId,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final whereClause = _buildWhereClause(geoUnitId, filters);
      final params = _buildParams(geoUnitId, filters);
      
      // Get total count for percentage calculation
      final totalResult = await db.getOptional(
        'SELECT COUNT(*) as count FROM $tableVoters WHERE $whereClause',
        params,
      );
      final totalVoters = totalResult?['count'] as int? ?? 0;
      
      if (totalVoters == 0) return [];
      
      // Get favorability distribution
      // Note: favorability column stores enum values (very_strong, strong, neutral, lean_other, not_known) or might be NULL/empty
      final results = await db.getAll(
        '''
        SELECT 
          CASE 
            WHEN v.favorability IS NULL OR v.favorability = '' THEN 'not_known'
            ELSE LOWER(TRIM(v.favorability))
          END as code,
          COUNT(*) as count
        FROM $tableVoters v
        WHERE $whereClause
        GROUP BY LOWER(TRIM(COALESCE(v.favorability, 'not_known')))
        ORDER BY 
          CASE 
            WHEN LOWER(TRIM(COALESCE(v.favorability, 'not_known'))) = 'very_strong' THEN 1
            WHEN LOWER(TRIM(COALESCE(v.favorability, 'not_known'))) = 'strong' THEN 2
            WHEN LOWER(TRIM(COALESCE(v.favorability, 'not_known'))) = 'neutral' THEN 3
            WHEN LOWER(TRIM(COALESCE(v.favorability, 'not_known'))) = 'lean_other' THEN 4
            ELSE 5
          END
        ''',
        params,
      );
      
      // Map codes to display names (will be localized in UI)
      final Map<String, Map<String, String>> favorabilityNames = {
        'very_strong': {'name': 'Very Strong', 'nameLocal': 'చాలా బలమైన'},
        'strong': {'name': 'Strong', 'nameLocal': 'బలమైన'},
        'neutral': {'name': 'Neutral', 'nameLocal': 'తటస్థ'},
        'lean_other': {'name': 'Lean Other', 'nameLocal': 'ఇతరుల వైపు'},
        'not_known': {'name': 'Not Known', 'nameLocal': 'తెలియదు'},
      };
      
      return results.map((row) {
        final code = (row['code'] as String?) ?? 'not_known';
        final count = row['count'] as int;
        final names = favorabilityNames[code.toLowerCase()] ?? {'name': 'Not Known', 'nameLocal': 'తెలియదు'};
        
        return {
          'favorability': names['name'],
          'favorabilityLocal': names['nameLocal'],
          'code': code,
          'count': count,
          'percentage': (count / totalVoters * 100),
        };
      }).toList();
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get favorability distribution');
      return [];
    }
  }
  
  /// Get geo unit performance (children performance)
  static Future<List<Map<String, dynamic>>> getGeoUnitPerformance({
    required String geoUnitId,
    required String metric, // 'contacted' or 'polled'
    Map<String, dynamic>? filters,
  }) async {
    try {
      // First, check if this geo unit has children
      final children = await db.getAll(
        'SELECT id, name, name_local FROM geo_units WHERE parent_id = ? AND is_active = 1',
        [geoUnitId],
      );
      
      if (children.isEmpty) return [];
      
      final metricColumn = metric == 'contacted' 
          ? 'last_visited_at IS NOT NULL' 
          : 'is_polled = 1';
      
      final results = <Map<String, dynamic>>[];
      
      for (final child in children) {
        final childId = child['id'] as String;
        final childName = child['name'] as String;
        final childNameLocal = child['name_local'] as String?;
        
        // Build where clause for this child geo unit
        final whereClause = _buildWhereClause(childId, filters);
        final params = _buildParams(childId, filters);
        
        // Get total voters in this child geo unit
        final totalResult = await db.getOptional(
          'SELECT COUNT(*) as count FROM $tableVoters WHERE $whereClause',
          params,
        );
        final totalVoters = totalResult?['count'] as int? ?? 0;
        
        if (totalVoters == 0) continue;
        
        // Get metric count
        final metricResult = await db.getOptional(
          'SELECT COUNT(*) as count FROM $tableVoters WHERE $whereClause AND $metricColumn',
          params,
        );
        final metricCount = metricResult?['count'] as int? ?? 0;
        
        results.add({
          'geoUnitId': childId,
          'geoUnitName': childName,
          'geoUnitNameLocal': childNameLocal ?? childName,
          'totalVoters': totalVoters,
          'metricCount': metricCount,
          'percentage': (metricCount / totalVoters * 100),
        });
      }
      
      // Sort by percentage descending
      results.sort((a, b) => (b['percentage'] as double).compareTo(a['percentage'] as double));
      
      return results;
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get geo unit performance');
      return [];
    }
  }
  
  /// Build WHERE clause for dashboard queries with filters
  static String _buildWhereClause(String geoUnitId, Map<String, dynamic>? filters) {
    final conditions = <String>[
      // Hierarchical geo unit filter (user's geo_unit + children)
      // Check: direct match OR geoUnitId appears in JSON ancestors array
      '(geo_unit_id = ? OR (ancestors IS NOT NULL AND ancestors LIKE ?))',
    ];
    
    if (filters == null || filters.isEmpty) {
      return conditions.join(' AND ');
    }
    
    // Geographic filters - include children of selected geo units
    if (filters['selectedGeoUnitIds'] != null && 
        (filters['selectedGeoUnitIds'] as List).isNotEmpty) {
      final geoUnits = filters['selectedGeoUnitIds'] as List<String>;
      final placeholders = List.filled(geoUnits.length, '?').join(',');
      // Match: direct geo_unit_id OR ancestors contains any selected geo unit
      final ancestorConditions = geoUnits.map((_) => 'ancestors LIKE ?').join(' OR ');
      conditions.add('(geo_unit_id IN ($placeholders) OR ($ancestorConditions))');
    }
    
    // Demographics filters
    if (filters['ageMin'] != null) {
      conditions.add('age >= ?');
    }
    if (filters['ageMax'] != null) {
      conditions.add('age <= ?');
    }
    if (filters['selectedGenders'] != null && 
        (filters['selectedGenders'] as List).isNotEmpty) {
      final genders = filters['selectedGenders'] as List<String>;
      final placeholders = List.filled(genders.length, '?').join(',');
      conditions.add('gender IN ($placeholders)');
    }
    if (filters['selectedReligionIds'] != null && 
        (filters['selectedReligionIds'] as List).isNotEmpty) {
      final religions = filters['selectedReligionIds'] as List<int>;
      final placeholders = List.filled(religions.length, '?').join(',');
      conditions.add('religion_id IN ($placeholders)');
    }
    if (filters['selectedCasteIds'] != null && 
        (filters['selectedCasteIds'] as List).isNotEmpty) {
      final castes = filters['selectedCasteIds'] as List<int>;
      final placeholders = List.filled(castes.length, '?').join(',');
      conditions.add('caste_id IN ($placeholders)');
    }
    if (filters['selectedEducationIds'] != null && 
        (filters['selectedEducationIds'] as List).isNotEmpty) {
      final educations = filters['selectedEducationIds'] as List<int>;
      final placeholders = List.filled(educations.length, '?').join(',');
      conditions.add('education_id IN ($placeholders)');
    }
    
    // Status filters
    if (filters['isPolled'] != null) {
      conditions.add('is_polled = ?');
    }
    if (filters['isDead'] != null) {
      conditions.add('is_dead = ?');
    }
    if (filters['isShifted'] != null) {
      conditions.add('is_shifted = ?');
    }
    
    // Activity filters
    if (filters['lastVisitedFrom'] != null) {
      conditions.add('DATE(last_visited_at) >= DATE(?)');
    }
    if (filters['lastVisitedTo'] != null) {
      conditions.add('DATE(last_visited_at) <= DATE(?)');
    }
    if (filters['neverVisited'] == true) {
      conditions.add('last_visited_at IS NULL');
    }
    
    // Contact filters
    if (filters['hasPhone'] != null) {
      if (filters['hasPhone'] == true) {
        conditions.add('phone IS NOT NULL AND phone != ""');
      } else {
        conditions.add('(phone IS NULL OR phone = "")');
      }
    }
    if (filters['hasMobile'] == true) {
      conditions.add('LENGTH(phone) = 10');
    }
    
    // Favorability filters
    if (filters['selectedFavorabilities'] != null && 
        (filters['selectedFavorabilities'] as List).isNotEmpty) {
      final favs = filters['selectedFavorabilities'] as List<String>;
      final placeholders = List.filled(favs.length, '?').join(',');
      conditions.add('favorability IN ($placeholders)');
    }
    
    return conditions.join(' AND ');
  }
  
  /// Build parameters for dashboard queries with filters
  static List<dynamic> _buildParams(String geoUnitId, Map<String, dynamic>? filters) {
    final params = <dynamic>[
      geoUnitId,
      '%"$geoUnitId"%', // For ancestors LIKE check
    ];
    
    if (filters == null || filters.isEmpty) {
      return params;
    }
    
    // Geographic filters - add both direct IDs and ancestor patterns
    if (filters['selectedGeoUnitIds'] != null && 
        (filters['selectedGeoUnitIds'] as List).isNotEmpty) {
      final geoUnits = filters['selectedGeoUnitIds'] as List<String>;
      // First add the direct geo_unit_id values for IN clause
      params.addAll(geoUnits);
      // Then add ancestor LIKE patterns for each geo unit
      for (final geoUnitId in geoUnits) {
        params.add('%"$geoUnitId"%');
      }
    }
    
    // Demographics filters
    if (filters['ageMin'] != null) {
      params.add(filters['ageMin']);
    }
    if (filters['ageMax'] != null) {
      params.add(filters['ageMax']);
    }
    if (filters['selectedGenders'] != null && 
        (filters['selectedGenders'] as List).isNotEmpty) {
      params.addAll(filters['selectedGenders'] as List<String>);
    }
    if (filters['selectedReligionIds'] != null && 
        (filters['selectedReligionIds'] as List).isNotEmpty) {
      params.addAll(filters['selectedReligionIds'] as List<int>);
    }
    if (filters['selectedCasteIds'] != null && 
        (filters['selectedCasteIds'] as List).isNotEmpty) {
      params.addAll(filters['selectedCasteIds'] as List<int>);
    }
    if (filters['selectedEducationIds'] != null && 
        (filters['selectedEducationIds'] as List).isNotEmpty) {
      params.addAll(filters['selectedEducationIds'] as List<int>);
    }
    
    // Status filters
    if (filters['isPolled'] != null) {
      params.add(filters['isPolled'] == true ? 1 : 0);
    }
    if (filters['isDead'] != null) {
      params.add(filters['isDead'] == true ? 1 : 0);
    }
    if (filters['isShifted'] != null) {
      params.add(filters['isShifted'] == true ? 1 : 0);
    }
    
    // Activity filters
    if (filters['lastVisitedFrom'] != null) {
      params.add((filters['lastVisitedFrom'] as DateTime).toIso8601String());
    }
    if (filters['lastVisitedTo'] != null) {
      params.add((filters['lastVisitedTo'] as DateTime).toIso8601String());
    }
    
    // Favorability filters
    if (filters['selectedFavorabilities'] != null && 
        (filters['selectedFavorabilities'] as List).isNotEmpty) {
      params.addAll(filters['selectedFavorabilities'] as List<String>);
    }
    
    return params;
  }
}
