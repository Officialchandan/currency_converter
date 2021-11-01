import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {


  static Future<String> getStringPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> setStringPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<int> getIntPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setIntPreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

 static Future<int> getLangIndexPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setLangIndexPreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }


  static Future<String> getSymbolFromPreference(String key)async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key)??"\$";

  }
  static Future<bool> setSymbolFromPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
  static Future<String> getSymboltoPreference(String key)async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key)??"€";

  }
  static Future<bool> setSymboltoPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<int> getMonetaryValuePreference(String key)async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key)??1;

  }
  static Future<bool> setMonetaryValuePreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }
  static Future<int> getDecimalValuePreference(String key)async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key)??2;

  }
  static Future<bool> setDecimalValuePreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<String> getFormatExmaplePreference(String key)async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key)??"123456.02";

  }
  static Future<bool> setFormatExmaplePreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }




  static Future getColorTheme() async {
    String colorCode = await getStringPreference(Constants.themeColor);
    debugPrint("color->>>> $colorCode");

    if (colorCode.isNotEmpty) {
      int value = int.parse(colorCode);
      var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$code");
      MyColors.colorPrimary = Color(int.parse("0x$code"));
      MyColors.calcuColor = MyColors.colorPrimary;
    } else {
      debugPrint("color is empty");
    }
  }
}
