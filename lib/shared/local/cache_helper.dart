import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async => sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> setData({
    @required String key,
    @required value,
  }) {
    if (value is String)
      return sharedPreferences.setString(key, value);
    else if (value is bool)
      return sharedPreferences.setBool(key, value);
    else if (value is List)
      return sharedPreferences.setStringList(key, value);
    else if (value is int)
      return sharedPreferences.setInt(key, value);

    return sharedPreferences.setDouble(key, value);
  }

  static getData({@required String key}) => sharedPreferences.get(key);

  static bool isLogged() => sharedPreferences.getString('userData') != null;
}
