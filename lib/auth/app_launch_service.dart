import 'package:shared_preferences/shared_preferences.dart';

class AppLaunchService {
  static const _activationKey = 'user_id';

  /// Returns true if the app is activated (user_id exists in prefs)
  static Future<bool> isActivated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activationKey) != null;
  }
}
