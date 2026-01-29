import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_state.dart';

class SettingsService {
  static const String _key = 'app_settings';

  Future<SettingsState> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_key);
      if (json != null) {
        return SettingsState.fromJson(jsonDecode(json));
      }
      return const SettingsState();
    } catch (e) {
      return const SettingsState();
    }
  }

  Future<void> save(SettingsState settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, jsonEncode(settings.toJson()));
    } catch (e) {
      // Silent fail - settings will use default values
    }
  }
}
