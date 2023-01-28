import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  late SharedPreferences _pref;

  Future<bool> read(String key) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(key) ?? false;
  }

  Future<bool> store(String key, bool isActive) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.setBool(key, isActive);
  }
}
