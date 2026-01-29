import 'package:geocoding/geocoding.dart';
import 'package:mobileapp/utils/logger.dart';

class GeoHelper {
  /// Converts GPS coordinates into the most detailed address string possible.
  static Future<String?> getAddressFromCoords(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return null;
      
      final p = placemarks.first;

      // Greedy capture of all available data fields
      final parts = [
        p.name,           // Building/House Name
        p.subThoroughfare, // Door Number
        p.thoroughfare,    // Street
        p.subLocality,     // Area/Colony
        p.locality,        // City
        p.subAdministrativeArea, // District
        p.administrativeArea,    // State
        p.postalCode,      // Pincode
      ];

      // Clean, filter, and remove duplicates
      final cleanAddress = parts
          .where((e) => e != null && e.toString().isNotEmpty)
          .map((e) => e.toString().trim())
          .toSet() 
          .join(', ');

      return cleanAddress.isNotEmpty ? cleanAddress : null;
          
    } catch (e, stackTrace) {
      Logger.logError(e, stackTrace, 'Geocoding utility failed');
      return null;
    }
  }
}