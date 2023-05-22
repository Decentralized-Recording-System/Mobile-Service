import 'package:shared_preferences/shared_preferences.dart';

class UserSharePreference {
  // static SharedPreferences? _preference;
  static const authNameKey = "authName";

  static Future setAuth(String authNumber) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    await preference.setString(authNameKey, authNumber);
  }

  static Future<String?> getAuth() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(authNameKey);
  }
}
