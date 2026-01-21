import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:mobileapp/config/env.dart';
import 'package:mobileapp/utils/logger.dart';

class AuthService {
  static const _deviceIdKey = 'device_id';

  static Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);

    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs.setString(_deviceIdKey, deviceId);
    }

    return deviceId;
  }

  static Future<void> activateApp(String name, String phone, String passcode) async {
    try {
      final deviceId = await _getDeviceId();

      final response = await http.post(
        Uri.parse('$supabaseUrl/functions/v1/smart-handler'),
        headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseAnonKey,
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'passcode': passcode,
          'device_id': deviceId,
        }),
      );

      if (response.statusCode != 200) {
        Logger.logInfo('Activation failed: ${response.statusCode} - ${response.body}');
        throw Exception('Activation failed');
      }

      final data = jsonDecode(response.body);
      if (data == null || data['token'] == null) {
        throw Exception('Invalid response format');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', data['user_id'].toString());
      await prefs.setString('campaign_id', data['campaign_id'].toString());
      await prefs.setString('geo_unit_id', data['geo_unit_id'].toString());
      await prefs.setString('powersync_token', data['token'].toString());

      Logger.logInfo('App activated successfully for user: ${data['user_id']}');
    } catch (error, stackTrace) {
      Logger.logError(error, stackTrace);
      throw Exception('Failed to activate app. Please check your credentials.');
    }
  }
}
