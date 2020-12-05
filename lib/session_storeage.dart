import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<void> setData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  Future<String> getData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
