import 'dart:convert';
import 'package:powersync/powersync.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/utils/geo_helper.dart';


class AppRepository {
  
  static PowerSyncDatabase get db => PowerSyncService().db;
  /// Fetches the current active campaign (used for HomeScreen title)
  static Future<Map<String, dynamic>?> getActiveCampaign() async {
    try {
      final results = await db.getAll("SELECT * FROM campaigns WHERE status = 'active' LIMIT 1");
      if (results.isNotEmpty) return results.first;
      
      // Fallback: If none are marked active, get the most recent one
      final all = await db.getAll("SELECT * FROM campaigns ORDER BY created_at DESC LIMIT 1");
      return all.firstOrNull;
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get active campaign');
      return null;
    }
  }

  /// Watches for changes in campaign assets (like banners/images)
  static Stream<List<Map<String, dynamic>>> watchCampaignAssets({List<String>? assetTypes}) {
    if (assetTypes != null && assetTypes.isNotEmpty) {
      final placeholders = List.filled(assetTypes.length, '?').join(',');
      return db.watch(
        'SELECT * FROM campaign_assets WHERE asset_type IN ($placeholders) AND is_active = 1',
        parameters: assetTypes,
      );
    }
    return db.watch('SELECT * FROM campaign_assets WHERE is_active = 1');
  }
  // --- Constants (Single Source of Truth) ---
  static const String tableVoters = 'voters';
  static const List<String> updatableVoterFields = [
    'favorability', 'is_dead', 'is_shifted', 'phone', 
    'latitude', 'longitude', 'geo_address', 'last_visited_at',
    // Polling Live fields
    'serial_number', 'polled_at', 'polled_by_user_id', 'is_polled'
  ];

  // --- Generic Stream Mapper ---
  static Stream<List<T>> _watchList<T>(String sql, List<dynamic> params, T Function(Map<String, dynamic>) mapper) {
    return db.watch(sql, parameters: params).map((rows) => rows.map(mapper).toList());
  }

  // --- Voter Queries (100k+ Optimized) ---

  static Stream<List<Voter>> watchVoters({Map<String, dynamic>? filters, String query = ''}) {
    final params = <dynamic>[];
    final conditions = <String>['1 = 1'];

    if (query.isNotEmpty) {
      conditions.add('(name LIKE ? OR epic_id LIKE ?)');
      params.addAll(['%$query%', '%$query%']);
    }

    // Handle filters
    filters?.forEach((key, value) {
      if (value == null || (value is String && value.isEmpty)) return;
      
      switch (key) {
        case 'epic_id':
          conditions.add('epic_id LIKE ?');
          params.add('%$value%');
          break;
          
        case 'door_no':
          conditions.add('door_no LIKE ?');
          params.add('%$value%');
          break;
          
        case 'booth_no':
          conditions.add('section_number LIKE ?');
          params.add('%$value%');
          break;
          
        case 'phone':
          conditions.add('phone LIKE ?');
          params.add('%$value%');
          break;
          
        case 'geo_unit_id':
          // Hierarchical filter: match direct geo_unit_id OR check if it's in ancestors
          conditions.add('(geo_unit_id = ? OR ancestors LIKE ?)');
          params.add(value);
          params.add('%"$value"%'); // Check if ID appears in ancestors JSON array
          break;
          
        case 'favorability':
          conditions.add('favorability = ?');
          params.add(value);
          break;
          
        case 'age_from':
          conditions.add('age >= ?');
          params.add(value);
          break;
          
        case 'age_to':
          conditions.add('age <= ?');
          params.add(value);
          break;
          
        case 'section_number':
          conditions.add('section_number LIKE ?');
          params.add('%$value%');
          break;
          
        case 'booth_id':
        case 'section_id':
        case 'caste_id':
        case 'religion_id':
          conditions.add('$key = ?');
          params.add(value);
          break;
      }
    });

    final sql = 'SELECT * FROM $tableVoters WHERE ${conditions.join(' AND ')} ORDER BY name ASC LIMIT 500';
    return _watchList(sql, params, Voter.fromMap);
  }

  static Future<Voter?> getVoter(String voterId) async {
    final result = await db.getOptional('SELECT * FROM $tableVoters WHERE id = ?', [voterId]);
    return result != null ? Voter.fromMap(result) : null;
  }

  // --- Smart & Generic Save ---

 static Future<void> saveVoter(Voter voter) async {
    try {
      // 1. Dirty Check: Don't do anything if data hasn't changed
      final current = await getVoter(voter.id);
      if (current == voter) {
        Logger.logInfo('No changes detected for voter ${voter.id}');
        return; 
      }

      Voter voterToSave = voter;

      // 2. Auto-Geocoding Logic using Utility
      final coordsChanged = voter.latitude != current?.latitude || 
                            voter.longitude != current?.longitude;

      if (coordsChanged && voter.latitude != null && voter.longitude != null) {
        // Calling the helper from your utils folder
        final address = await GeoHelper.getAddressFromCoords(
          voter.latitude!, 
          voter.longitude!,
        );
        
        voterToSave = voter.copyWith(geoAddress: address);
      }

      // 3. Dynamic Database Update
      await db.writeTransaction((tx) async {
        final json = voterToSave.toJson();
        final updates = <String>[];
        final params = <dynamic>[];

        // Loop through the whitelist defined at the top of the class
        for (var field in updatableVoterFields) {
          if (json.containsKey(field)) {
            updates.add('$field = ?');
            // json[field] might be null, which is fine (SQLite handles NULL)
            params.add(json[field]); 
          }
        }

        if (updates.isEmpty) return;

        // Add the ID for the WHERE clause
        params.add(voterToSave.id);

        await tx.execute(
          'UPDATE $tableVoters SET ${updates.join(', ')} WHERE id = ?',
          params,
        );
      });
      
      Logger.logInfo('Successfully saved voter ${voter.id}');
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to save voter ${voter.id}');
      rethrow;
    }
  }

 

  // --- Filter Persistence (Clean JSON approach) ---

  static Future<void> savePersistentFilters(Map<String, dynamic> filters) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('voter_filters', jsonEncode(filters));
  }

  static Future<Map<String, dynamic>> getPersistentFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('voter_filters');
    return data != null ? jsonDecode(data) : {};
  }

  // --- Lookup Queries (Standardized) ---

  static Future<List<Map<String, dynamic>>> getLookupData(String table) async {
    return await db.getAll('SELECT id, name FROM $table ORDER BY name ASC');
  }

  /// Get geo units accessible to a specific user (user's geo_unit + children)
  /// If userGeoUnitId is null, returns all geo units
  static Future<List<Map<String, dynamic>>> getAccessibleGeoUnits(String? userGeoUnitId) async {
    if (userGeoUnitId == null) {
      // If no user geo unit, return all (fallback for admins or edge cases)
      return await getLookupData('geo_units');
    }

    try {
      // Query: Get user's geo_unit OR any geo_unit where user's ID is in ancestors array
      final results = await db.getAll(
        '''
        SELECT id, name 
        FROM geo_units 
        WHERE id = ? OR ancestors LIKE ? 
        ORDER BY name ASC
        ''',
        [userGeoUnitId, '%"$userGeoUnitId"%'],
      );
      return results;
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get accessible geo units');
      return [];
    }
  }

  /// Get accessible booths (only booths) for a specific user
  /// If userGeoUnitId is null, returns all booths
  static Future<List<Map<String, dynamic>>> getAccessibleBooths(String? userGeoUnitId) async {
    if (userGeoUnitId == null) {
      // If no user geo unit, return all booths (fallback for admins)
      return await db.getAll(
        'SELECT id, name FROM geo_units WHERE is_booth = 1 AND is_active = 1 ORDER BY name ASC',
      );
    }

    try {
      // Query: Get booths under user's geo_unit (booths where user's ID is in ancestors array)
      final results = await db.getAll(
        '''
        SELECT id, name 
        FROM geo_units 
        WHERE is_booth = 1 AND is_active = 1 
          AND (id = ? OR ancestors LIKE ?)
        ORDER BY name ASC
        ''',
        [userGeoUnitId, '%"$userGeoUnitId"%'],
      );
      return results;
    } catch (e, st) {
      Logger.logError(e, st, 'Failed to get accessible booths');
      return [];
    }
  }

  // Use getLookupData('geo_units'), getLookupData('castes'), getLookupData('religions') directly where needed.

// Inside AppRepository class in repositories.dart

static Future<String?> getAssetUrl(String assetType) async {
  try {
    Logger.logInfo('🔍 [DB FETCH] Looking for asset_type: $assetType');
    final results = await db.getOptional(
      'SELECT file_url FROM campaign_assets WHERE asset_type = ? AND is_active = 1 LIMIT 1',
      [assetType],
    );
    final url = results?['file_url'] as String?;
    if (url != null) {
      Logger.logInfo('✅ [DB FETCH] Found URL for $assetType: $url');
    } else {
      Logger.logInfo('❌ [DB FETCH] No URL found for $assetType (results: $results)');
    }
    return url;
  } catch (e, st) {
    Logger.logError(e, st, 'Repository failed to fetch asset URL');
    return null;
  }
}

static Future<List<Map<String, dynamic>>> getActiveAssetMapping() async {
    // Used for the batch caching logic
    return await db.getAll(
      'SELECT file_url, asset_type FROM campaign_assets WHERE is_active = 1 AND file_url IS NOT NULL'
    );
}

  
}
