import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else
      return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> addStringToList(
      {required String key, required String value}) async {
    List<String> currentList = sharedPreferences?.getStringList(key) ?? [];
    currentList.add(value);
    return await sharedPreferences!.setStringList(key, currentList);
  }

  static List<String> getStringList({required String key}) {
    return sharedPreferences?.getStringList(key) ?? [];
  }
  static Future<bool> removeList({required String key}) async {
  return await sharedPreferences!.remove(key);
}

}
