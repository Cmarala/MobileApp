import 'package:powersync/powersync.dart' as ps;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/env.dart';

class MyPowerSyncBackendConnector extends ps.PowerSyncBackendConnector {
  @override
  Future<ps.PowerSyncCredentials?> fetchCredentials() async {
    print('[DEBUG] fetchCredentials called');
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('powersync_token');
    if (jwt == null) {
      print('[DEBUG] fetchCredentials: No JWT found, returning null');
      // Not signed in
      return null;
    }
    print('[DEBUG] fetchCredentials: Returning credentials for endpoint: $powerSyncUrl');
    // Return credentials for PowerSync
    return ps.PowerSyncCredentials(
      endpoint: powerSyncUrl,
      token: jwt,
    );
  }

  @override
  Future<void> uploadData(ps.PowerSyncDatabase database) async {
    // No-op for now
  }
}
