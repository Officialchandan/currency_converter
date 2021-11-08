import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  static Future<String> getTryColorPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> setTryColorPreference(String key, String value) async {
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

  static Future<String> getSymbolFromPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "\$";
  }

  static Future<bool> setSymbolFromPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> getSymboltoPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "€";
  }

  static Future<bool> setSymboltoPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<int> getMonetaryValuePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 1;
  }

  static Future<bool> setMonetaryValuePreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int> getDecimalValuePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 2;
  }

  static Future<bool> setDecimalValuePreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<String> getFormatExmaplePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "123456.02";
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

  static String getFormatDate() {
    DateTime dateTime = DateTime.now();
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      String date = DateFormat('dd/MM/yyyy').format(dateTime).toString();
      debugPrint("date--> $date");
      return date;
    } else {
      String date = DateFormat('MM/dd/yyyy').format(dateTime).toString();
      debugPrint("date--> $date");
      return date;
    }
  }

  static getTestStyle({int fontSize = 14}) {
    int textSize = fontSize;
  }

  static String getFormatText(String s) {
    String text1 = "";
    debugPrint("MyColors.decimalformat-->${MyColors.decimalFormat}");
    debugPrint("getFormatText-->$s");

    int i = MyColors.monetaryFormat;
    debugPrint("monetaryFormat-->$i");
    int afterdecimal = MyColors.decimalFormat;

    // double amount =
    //       double.parse(s);
    //
    // debugPrint("amount-->$amount");
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      text1 = mformat.format(s.replaceAll(".", ""));

      text1 = text1.replaceAll(",", ",");

      text1 = text1.replaceAll(".", ".");

      return text1;
    } else if (i == 2) {
      text1 = mformat.format(s.replaceAll(".", ""));
      log(text1);
      text1 = text1.replaceAll(".", " ");
      log(text1);
      text1 = text1.replaceAll(",", ".");
      log(text1);
      text1 = text1.replaceAll(" ", ",");
      return text1;
      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text1 = mformat.format(s.replaceAll(".", ""));
      text1 = text1.replaceAll(".", "=");
      log(text1);
      text1 = text1.replaceAll(",", ".");
      log(text1);
      text1 = text1.replaceAll(".", " ");
      text1 = text1.replaceAll("=", ".");

      log(text1);
      return text1;
    } else if (i == 4) {
      text1 = mformat.format(s.replaceAll(".", ""));
      log(text1);
      text1 = text1.replaceAll(",", " ");
      log(text1);
      text1 = text1.replaceAll(".", ",");
      log(text1);
      return text1;
    }
    return text1;
  }
}
