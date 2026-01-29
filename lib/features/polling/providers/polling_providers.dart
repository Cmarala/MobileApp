import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/data/polling_repository.dart';
import 'package:mobileapp/data/repositories.dart';
import 'package:mobileapp/features/polling/controllers/polling_live_controller.dart';
import 'package:mobileapp/sync/powersync_service.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1. PowerSync Database Provider
final powersyncDatabaseProvider = Provider((ref) {
  return PowerSyncService().db;
});

/// 2. Current User ID Provider
final currentUserIdProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_id');
});

/// 3. The Repository Provider
final pollingRepositoryProvider = Provider<PollingRepository>((ref) {
  final db = ref.watch(powersyncDatabaseProvider); 
  return PollingRepository(db);
});

/// 4. The Controller Provider (StateNotifierProvider)
final pollingLiveControllerProvider = 
    StateNotifierProvider<PollingLiveController, PollingLiveState>((ref) {
  final repo = ref.watch(pollingRepositoryProvider);
  final userIdAsync = ref.watch(currentUserIdProvider);
  final userId = userIdAsync.value ?? 'unknown_user'; 
  
  return PollingLiveController(repo, userId);
});

/// 5. The Voter Stream Provider
/// This reacts automatically to search changes or mode toggles
final pollingVoterStreamProvider = StreamProvider.family<List<Voter>, String>((ref, boothId) {
  final controller = ref.watch(pollingLiveControllerProvider.notifier);
  // This watches the state so the stream recreates whenever searchQuery or isHistoryMode changes
  ref.watch(pollingLiveControllerProvider); 
  
  return controller.watchVoters(boothId);
});

/// 6. Booths Provider (with access control)
final boothsStreamProvider = FutureProvider<List<BoothInfo>>((ref) async {
  // Get user's geo_unit_id from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final userGeoUnitId = prefs.getString('geo_unit_id');
  
  // Import repositories for proper architecture
  final booths = await AppRepository.getAccessibleBooths(userGeoUnitId);
  
  return booths.map((row) => BoothInfo(
    id: row['id'] as String,
    name: row['name'] as String,
  )).toList();
});

/// Simple booth info model
class BoothInfo {
  final String id;
  final String name;

  BoothInfo({required this.id, required this.name});
}