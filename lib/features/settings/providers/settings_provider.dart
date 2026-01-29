import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_state.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in ProviderScope');
});

// Provider for Settings
final settingsProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsController(prefs);
});

// Helper provider to check if current language is English
final isEnglishProvider = Provider<bool>((ref) {
  final settings = ref.watch(settingsProvider);
  return settings.langCode == 'en';
});
