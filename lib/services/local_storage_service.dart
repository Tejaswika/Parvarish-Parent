import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences prefs;

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setData(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getData(String key) {
    return prefs.getString(key) ?? '';
  }
}
