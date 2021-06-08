import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
 static SharedPreferences sharedPreference;

  static init()async{
    sharedPreference = await SharedPreferences.getInstance();
  }

  static dynamic getData({@required String key}){

   return sharedPreference.get(key);
  }

  static Future<bool> saveData({@required dynamic value,@required String key}) async {
    if(value is String) return await sharedPreference.setString(key, value);
    if(value is bool) return await sharedPreference.setBool(key, value);
    if(value is int) return await sharedPreference.setInt(key, value);

      return await sharedPreference.setDouble(key, value);

  }

  static Future<bool>  remove({@required String key}) async {
    return await sharedPreference.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreference.clear();
  }
}