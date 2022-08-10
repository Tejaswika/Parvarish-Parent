import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences prefs;

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setUid(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getUid(String key) {
    return prefs.getString(key) ?? '';
  }

  static setFmcToken(String key, String value) async {
    await prefs.setString(key, value);
  }
  
  static String getFmcToken(String key) {
    return prefs.getString(key) ?? '';
  }
}
