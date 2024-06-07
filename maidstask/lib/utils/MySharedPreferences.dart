
// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static const String keyIsLogIn = "key_isLogIn";
  static const String keyLoginId = "loginId";
  static const String keyFullName = "fullName";
  static const String keyIsGetTasks = "isGetTasks";

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


  static bool get isLogIn => _sharedPreferences.getBool(keyIsLogIn) ?? false;

  static set isLogIn(bool value) =>
      _sharedPreferences.setBool(keyIsLogIn, value);



  static int get loginId {
    return _sharedPreferences.getInt(keyLoginId) ?? -1;
  }

  static set loginId(int value) {
    _sharedPreferences.setInt(keyLoginId, value);
  }





  static String get fullName {
    return _sharedPreferences.getString(keyFullName) ?? '';
  }

  static set fullName(String value) {
    _sharedPreferences.setString(keyFullName, value);
  }



  static bool get isGetTasks {
    return _sharedPreferences.getBool(keyIsGetTasks) ?? false;
  }

  static set isGetTasks(bool value) {
    _sharedPreferences.setBool(keyIsGetTasks, value);
  }
}
