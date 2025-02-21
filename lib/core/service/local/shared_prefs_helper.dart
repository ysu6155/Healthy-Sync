import 'package:shared_preferences/shared_preferences.dart';

sealed class SharedHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool?> sava(String key, value) async {
    if (value is int) {
      return await prefs?.setInt(key, value);
    } else if (value is String) {
      return await prefs?.setString(key, value);
    } else if (value is num) {
      return await prefs?.setDouble(key, value.toDouble());
    } else if (value is bool) {
      return await prefs?.setBool(key, value);
    } else if (value is List<String>) {
      return await prefs?.setStringList(key, value);
    } else {
      throw Exception("UnSupported Type for Shared Helper");
    }
  }

  static get(String key) {
    return prefs?.get(key);
  }

  static Future<void> removeKay(String key) async {
    await prefs?.remove(key);
  }

  static Future<void> clear() async {
    await prefs?.clear();
  }
}
