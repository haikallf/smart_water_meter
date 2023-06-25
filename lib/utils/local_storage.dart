import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;

  static const _keyEmail = "email";

  static const _keyFullName = "fullName";

  static const _keyDeviceToken = "deviceToken";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  static Future clearEmail() async {
    return await _preferences.remove(_keyEmail);
  }

  static Future setFullName(String fullname) async =>
      await _preferences.setString(_keyFullName, fullname);

  static String? getFullName() => _preferences.getString(_keyFullName);

  static Future clearFullName() async =>
      await _preferences.remove(_keyFullName);

  static Future clearAll() async => await _preferences.clear();

  static Future setDeviceToken(String deviceToken) async =>
      await _preferences.setString(_keyDeviceToken, deviceToken);

  static String? getDeviceToken() => _preferences.getString(_keyDeviceToken);

  static Future clearDeviceToken() async {
    return await _preferences.remove(_keyDeviceToken);
  }
}
