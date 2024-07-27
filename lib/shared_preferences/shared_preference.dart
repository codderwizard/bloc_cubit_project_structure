import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CustomTheme { light, dark }

class SharedPrefUtils {
  static final SharedPrefUtils _instance = SharedPrefUtils.internal();

  factory SharedPrefUtils() => _instance;

  SharedPrefUtils.internal();

  static SharedPreferences? sharedPreferences;

  Future<SharedPreferences?> get pref async {
    if (sharedPreferences != null) {
      return sharedPreferences;
    }
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  setIntValue(String key, int value) async {
    var sharedPref = await pref;
    sharedPref?.setInt(key, value);
  }

  setStringValue(String key, String value) async {
    var sharedPref = await pref;
    sharedPref?.setString(key, value);
  }

  setStringListValue(String key, var value) async {
    var sharedPref = await pref;
    sharedPref?.setStringList(key, value);
  }

  setBoolValue(String key, bool value) async {
    var sharedPref = await pref;
    sharedPref?.setBool(key, value);
  }

  Future<String?> getStringValue(String key) async {
    var sharedPref = await pref;
    return sharedPref?.getString(key);
  }

  Future getStringListValue(dynamic key) async {
    var sharedPref = await pref;
    return sharedPref?.getStringList(key);
  }

  Future<int?> getIntValue(String key) async {
    var sharedPref = await pref;
    return sharedPref?.getInt(key);
  }

  Future<bool?> getBoolValue(String key) async {
    var sharedPref = await pref;
    return sharedPref?.getBool(key);
  }

  clearAllData() async {
    var sharedPref = await pref;
    sharedPref?.clear();
  }

  setDoubleValue(String key, double value) async {
    var sharedPref = await pref;
    sharedPref?.setDouble(key, value);
  }

  static void cleanData() async {
    debugPrint('in clear of shared preference');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
