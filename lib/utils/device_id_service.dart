import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Service to get a persistent device ID that survives app reinstallation
class DeviceIdService {
  static const _deviceIdKey = 'device_id';

  /// Gets a persistent device ID. On Android, uses Android ID which survives
  /// app reinstallation. On iOS, uses identifierForVendor. Falls back to
  /// generated UUID if hardware ID is unavailable.
  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);
    
    if (deviceId == null) {
      // Try to get hardware-based ID first
      try {
        final deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          final androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id; // Android ID - survives reinstallation
        } else if (Platform.isIOS) {
          final iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor; // iOS equivalent
        } else {
          // Fallback for other platforms
          deviceId = const Uuid().v4();
        }
      } catch (e) {
        // Fallback to generated UUID if hardware ID fails
        deviceId = const Uuid().v4();
      }
      
      // Cache the device ID
      await prefs.setString(_deviceIdKey, deviceId!);
    }
    
    return deviceId;
  }

  /// Clears the cached device ID (useful for testing/debugging)
  static Future<void> clearDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceIdKey);
  }
}
