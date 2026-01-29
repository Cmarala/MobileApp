// lib/features/survey/services/location_service.dart

import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Gets current GPS coordinates
  /// Returns null if permission denied or location unavailable
  static Future<Position?> getCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await Geolocator.requestPermission();
        if (requested == LocationPermission.denied || 
            requested == LocationPermission.deniedForever) {
          return null;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return position;
    } catch (e) {
      return null;
    }
  }

  /// Gets current coordinates as (latitude, longitude) tuple
  static Future<(double, double)?> getCurrentCoordinates() async {
    final position = await getCurrentPosition();
    if (position == null) return null;
    return (position.latitude, position.longitude);
  }
}
