import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/utils/logger.dart';

class PermissionHelper {
  /// The Full Campaign Checklist
  static Future<bool> requestAllPermissions(BuildContext context) async {
    try {
      // 1. Core Permissions (The pop-ups the user sees)
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
        Permission.sms,
        Permission.phone,
        Permission.microphone,
        Permission.bluetoothConnect,
        Permission.bluetoothScan,
        // For Android 13+, use .photos and .videos instead of .storage
        Permission.storage, 
      ].request();

      // 2. Specialized Check: Background Location
      // Must be requested AFTER normal location is granted
      if (statuses[Permission.location]?.isGranted ?? false) {
        await Permission.locationAlways.request();
      }

      // 3. Hardware Check: Is GPS actually toggled ON?
      bool gpsHardwareOn = await Geolocator.isLocationServiceEnabled();

      // 4. Validation Logic
      bool allEssentialGranted = _checkEssentialPermissions(statuses);

      if (!allEssentialGranted || !gpsHardwareOn) {
        if (context.mounted) {
          await _showLockDialog(context, !gpsHardwareOn);
        }
        return false;
      }

      return true;
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Master permission request failed');
      return false;
    }
  }

  static bool _checkEssentialPermissions(Map<Permission, PermissionStatus> statuses) {
    // You can decide which ones are "Fatal" if denied
    final essential = [
      Permission.location,
      Permission.sms,
      Permission.camera
      //Permission.storage
    ];
    
    for (var p in essential) {
      if (!(statuses[p]?.isGranted ?? false)) return false;
    }
    return true;
  }

  static Future<void> _showLockDialog(BuildContext context, bool gpsOff) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Required Setup', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(gpsOff 
          ? 'Your GPS hardware is OFF. Please turn it on in your device settings.' 
          : 'All requested permissions are mandatory for this field campaign to work offline. Please enable them in App Settings.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); 
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}