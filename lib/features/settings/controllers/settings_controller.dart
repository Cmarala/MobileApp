import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  final SharedPreferences _prefs;

  // Keys for SharedPreferences
  static const _langKey = 'selected_language_code';
  static const _headerTextEnabledKey = 'headerTextEnabled';
  static const _headerImageEnabledKey = 'headerImageEnabled';
  static const _footerEnabledKey = 'footerEnabled';

  SettingsController(this._prefs)
      : super(SettingsState(
          langCode: _prefs.getString(_langKey) ?? 'en', // Default to English
          headerTextEnabled: _prefs.getBool(_headerTextEnabledKey) ?? true,
          headerImageEnabled: _prefs.getBool(_headerImageEnabledKey) ?? true,
          footerEnabled: _prefs.getBool(_footerEnabledKey) ?? true,
        ));

  /// Update Language
  Future<void> setLanguage(String langCode) async {
    await _prefs.setString(_langKey, langCode);
    state = state.copyWith(langCode: langCode);
  }

  /// Toggle Header Text Visibility (Section 1)
  Future<void> toggleHeaderText(bool enabled) async {
    await _prefs.setBool(_headerTextEnabledKey, enabled);
    state = state.copyWith(headerTextEnabled: enabled);
  }

  /// Toggle Header Image Visibility
  Future<void> toggleHeaderImage(bool enabled) async {
    await _prefs.setBool(_headerImageEnabledKey, enabled);
    state = state.copyWith(headerImageEnabled: enabled);
  }

  /// Toggle Footer Message Visibility (Section 3)
  Future<void> toggleFooter(bool enabled) async {
    await _prefs.setBool(_footerEnabledKey, enabled);
    state = state.copyWith(footerEnabled: enabled);
  }

  /// Reset settings to defaults if needed
  Future<void> clearSettings() async {
    await _prefs.remove(_headerTextEnabledKey);
    await _prefs.remove(_headerImageEnabledKey);
    await _prefs.remove(_footerEnabledKey);
    state = SettingsState(langCode: state.langCode);
  }
}
