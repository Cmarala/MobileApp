import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:mobileapp/config/env.dart';
import 'package:mobileapp/utils/logger.dart';
import 'package:mobileapp/models/app_user.dart'; // New Import

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

  static Future<AppUser> activateApp(String name, String phone, String passcode) async {
    const maxRetries = 3;
    const baseDelay = Duration(seconds: 2);

    for (var attempt = 1; attempt <= maxRetries; attempt++) {
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
        ).timeout(const Duration(seconds: 15));

        if (response.statusCode != 200) {
          throw Exception('Activation failed: Invalid credentials');
        }

        final data = jsonDecode(response.body);
        
        
        
        // Use Freezed Model to parse data
        final user = AppUser.fromJson(data);

        // Persistent Storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id);
        await prefs.setString('campaign_id', user.campaignId);
        await prefs.setString('geo_unit_id', user.geoUnitId);
        await prefs.setString('powersync_token', user.token);
        await prefs.setString('user_name', user.userName ?? '');

        Logger.logInfo('App activated successfully for user: ${user.id}');
        return user; 

      } on SocketException {
        if (attempt == maxRetries) throw Exception('Network unreachable.');
        await Future.delayed(baseDelay * (1 << (attempt - 1)));
      } on TimeoutException {
        if (attempt == maxRetries) throw Exception('Connection timeout.');
        await Future.delayed(baseDelay * (1 << (attempt - 1)));
      } catch (error, stackTrace) {
        Logger.logError(error, stackTrace, 'Activation failed.');
        rethrow;
      }
    }
    throw Exception('Unknown error during activation');
  }
}