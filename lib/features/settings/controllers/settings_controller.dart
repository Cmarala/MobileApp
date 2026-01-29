import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  final SharedPreferences _prefs;

  // Keys for SharedPreferences
  static const _langKey = 'selected_language_code';
  static const _headerEnabledKey = 'header_enabled';
  static const _footerEnabledKey = 'footer_enabled';

  SettingsController(this._prefs)
      : super(SettingsState(
          langCode: _prefs.getString(_langKey) ?? 'en', // Default to English
          headerEnabled: _prefs.getBool(_headerEnabledKey) ?? false,
          footerEnabled: _prefs.getBool(_footerEnabledKey) ?? false,
        ));

  /// Update Language
  Future<void> setLanguage(String langCode) async {
    await _prefs.setString(_langKey, langCode);
    state = state.copyWith(langCode: langCode);
  }

  /// Toggle Header Message Visibility
  Future<void> toggleHeader(bool enabled) async {
    await _prefs.setBool(_headerEnabledKey, enabled);
    state = state.copyWith(headerEnabled: enabled);
  }

  /// Toggle Footer Message Visibility
  Future<void> toggleFooter(bool enabled) async {
    await _prefs.setBool(_footerEnabledKey, enabled);
    state = state.copyWith(footerEnabled: enabled);
  }

  /// Reset settings to defaults if needed
  Future<void> clearSettings() async {
    await _prefs.remove(_headerEnabledKey);
    await _prefs.remove(_footerEnabledKey);
    state = SettingsState(langCode: state.langCode);
  }
}
