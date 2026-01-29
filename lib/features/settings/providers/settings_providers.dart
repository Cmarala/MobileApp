import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_state.dart';

// Initialized in main.dart via ProviderScope override
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// The main provider managing settings state
final settingsProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsController(prefs);
});

// Helper provider for language checks
final isEnglishProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).langCode == 'en';
});

// Helper provider for header visibility
final headerEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).headerEnabled;
});

// Helper provider for footer visibility
final footerEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).footerEnabled;
});
