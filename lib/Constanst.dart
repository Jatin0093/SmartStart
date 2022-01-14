import 'package:shared_preferences/shared_preferences.dart';

class Constanst {
  static late SharedPreferences _preferences;

  static const _keylogIn = 'username';
  static const _keyUsername = 'username';
  static const _keyPhone = 'phone';
  static const _keyUid = 'Uid';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future setLogIn(bool value) async =>
      await _preferences.setBool(_keyUsername, value);

  static bool? getLogIn() => _preferences.getBool(_keylogIn);

  static Future setPhone(String phone) async =>
      await _preferences.setString(_keyPhone, phone);

  static String? getPhone() => _preferences.getString(_keyPhone);

  static Future setUid(String Uid) async {

    return await _preferences.setString(_keyUid, Uid);
  }
  static String? getUid() => _preferences.getString(_keyUid);
}