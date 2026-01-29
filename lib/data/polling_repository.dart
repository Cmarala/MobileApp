import 'package:powersync/powersync.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/utils/logger.dart';

class PollingRepository {
  final PowerSyncDatabase _db;

  PollingRepository(this._db);

  // --- 1. DASHBOARD LOGIC (Raw Stats) ---

  /// Streams the raw counts for the 5 favorability tiers for a specific booth.
  /// Used to drive the simple table on Screen 2.
  Stream<List<Map<String, dynamic>>> watchBoothStats(String geoUnitId) {
    // We use a raw SQL query to get the grouped counts in one go.
    // This is faster than fetching all voters and grouping in Dart.
    // COALESCE ensures we handle null favorability values properly
    return _db.watch('''
      SELECT 
        COALESCE(favorability, 'not_known') as favorability,
        COUNT(*) as total,
        CAST(SUM(CASE WHEN is_polled = 1 THEN 1 ELSE 0 END) AS INTEGER) as polled,
        CAST(SUM(CASE WHEN is_polled = 0 THEN 1 ELSE 0 END) AS INTEGER) as remaining
      FROM voters
      WHERE geo_unit_id = ? AND is_deleted = 0
      GROUP BY COALESCE(favorability, 'not_known')
    ''', parameters: [geoUnitId]);
  }

  // --- 2. CONSOLE LOGIC (The Swipe List) ---

  /// Streams unpolled voters for the 'Burn-down' list.
  /// Ordered by Serial Number for fast booth lookup.
  Stream<List<Voter>> watchPendingVoters({
    required String geoUnitId,
    String? searchquery,
  }) {
    String sql = 'SELECT * FROM voters WHERE geo_unit_id = ? AND is_polled = 0 AND is_deleted = 0';
    List<dynamic> args = [geoUnitId];

    if (searchquery != null && searchquery.isNotEmpty) {
      // Prioritize numeric search for Serial Number
      if (int.tryParse(searchquery) != null) {
        sql += ' AND serial_number = ?';
        args.add(int.parse(searchquery));
      } else {
        sql += ' AND name LIKE ?';
        args.add('%$searchquery%');
      }
    }

    sql += ' ORDER BY serial_number ASC';

    return _db.watch(sql, parameters: args).map((rows) {
      return rows.map((row) => Voter.fromMap(row)).toList();
    });
  }

  /// Streams already polled voters for the 'Undo' functionality.
  Stream<List<Voter>> watchPolledVoters(String geoUnitId) {
    return _db.watch(
      'SELECT * FROM voters WHERE geo_unit_id = ? AND is_polled = 1 AND is_deleted = 0 ORDER BY polled_at DESC',
      parameters: [geoUnitId]
    ).map((rows) => rows.map((row) => Voter.fromMap(row)).toList());
  }

  // --- 3. ACTIONS ---

  /// Marks a voter as voted. 
  /// Updates the status, timestamp, and audit trail.
  Future<void> markAsVoted({
    required String voterId,
    required String userId,
  }) async {
    try {
      await _db.execute('''
        UPDATE voters 
        SET 
          is_polled = 1, 
          polled_at = ?, 
          polled_by_user_id = ? 
        WHERE id = ?
      ''', [
        DateTime.now().toIso8601String(),
        userId,
        voterId,
      ]);
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Error marking voter as voted');
      rethrow;
    }
  }

  /// Reverts a voting action (Undo).
  Future<void> undoVote(String voterId) async {
    try {
      await _db.execute('''
        UPDATE voters 
        SET 
          is_polled = 0, 
          polled_at = NULL, 
          polled_by_user_id = NULL 
        WHERE id = ?
      ''', [voterId]);
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Error undoing vote');
      rethrow;
    }
  }
}