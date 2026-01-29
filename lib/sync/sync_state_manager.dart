import 'package:shared_preferences/shared_preferences.dart';

/// Manages sync state persistence to differentiate between first-time and returning users.
/// This prevents unnecessary full sync operations on every app launch.
class SyncStateManager {
  static const _syncCompletedKey = 'initial_sync_completed';
  static const _lastSyncKey = 'last_sync_timestamp';
  
  /// Checks if the initial sync has been completed.
  /// Returns true for returning users, false for first-time users.
  static Future<bool> hasCompletedInitialSync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_syncCompletedKey) ?? false;
  }
  
  /// Marks the initial sync as complete and records the timestamp.
  /// Should be called after waitForFirstSync() completes successfully.
  static Future<void> markInitialSyncComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_syncCompletedKey, true);
    await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());
  }
  
  /// Clears sync state - useful for testing or resetting the app.
  /// Forces next launch to perform full sync.
  static Future<void> clearSyncState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_syncCompletedKey);
    await prefs.remove(_lastSyncKey);
  }
  
  /// Gets the timestamp of the last successful sync.
  /// Returns null if never synced.
  static Future<DateTime?> getLastSyncTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(_lastSyncKey);
    return timestamp != null ? DateTime.parse(timestamp) : null;
  }
}
