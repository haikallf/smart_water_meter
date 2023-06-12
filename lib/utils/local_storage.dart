import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;

  static const _keyEmail = "email";

  static const _keyFullname = "fullname";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  static Future clearEmail() async {
    return await _preferences.remove(_keyEmail);
  }

  static Future setFullname(String fullname) async =>
      await _preferences.setString(_keyFullname, fullname);

  static String? getFullname() => _preferences.getString(_keyFullname);

  static Future clearFullname() async {
    return await _preferences.remove(_keyFullname);
  }
}
