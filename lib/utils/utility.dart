import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/color_data.dart';
import '../main.dart';

class Utility {
  static int? checkOfValue;

  static Future<bool> getMulticonverter(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setMulticonverter(String key, bool multi) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, multi);
  }

  static Future<String> getStringPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  ///********* */

  static Future<String> getAdId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? "";
  }

  static Future<bool> setAdId(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> setStringPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> getStringPreferenceForDensityColor(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "0xff4e7dcb";
  }

  static Future<bool> setStringPreferenceForDensityColor(
      String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> getBooleanPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setBooleanPreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<int> getIntPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setIntPreference(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<bool> setDoublePreference(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double> getDoublePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }

  static Future<int> getLangIndexPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 11;
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

  static Future<bool> setFormatExmaplePreference(
      String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> getBoolDisplayCodePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  static Future<bool> setBoolDisplayCodePreference(
      String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBoolDisplayflagPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setBoolDisplayflagPreference(
      String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBoolDisplaysymbolPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setBoolDisplaysymbolPreference(
      String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future getColorTheme() async {
    String colorCode = await getStringPreference(Constants.themeColor);
    String colorCode1 =
        await getStringPreference(Constants.themeofDensityColor);

    debugPrint("color->>>> $colorCode");
    debugPrint("color->>>> $colorCode1");
    if (colorCode.isNotEmpty) {
      int value = int.parse("0x" + "$colorCode");
      // int value = int.parse(colorCode);
      var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$code");
      MyColors.colorPrimary = Color(value);
      // MyColors.colorPrimary = Color(int.parse("0x$code"));
      // MyColors.colorPrimary = Color(int.parse("0xffff5722"));
      MyColors.calcuColor = MyColors.colorPrimary;
    } else {
      debugPrint("color is empty");
    }

    if (colorCode1.isNotEmpty) {
      // int value = int.parse(colorCode1);
      int value = int.parse("0x" + "$colorCode");
      // var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$value");
      MyColors.colorPrimary = Color(value);
      MyColors.calcuColor = MyColors.colorPrimary;
    } else {
      debugPrint("color is empty");
    }
    setStringPreference(Constants.primaryColorCode,
        MyColors.colorPrimary.value.toRadixString(16));
  }

  static void check() async {
    checkOfValue = await Utility.getLangIndexPreference("LanuageIndex");
    debugPrint(" checkOfValue $checkOfValue");
  }

  static String getEn() {
    var now = DateTime.now();
    var formatterEn =
        DateFormat.d('en').addPattern('/').add_M().addPattern('/').add_y();
    var formatterEn1 =
        DateFormat.M('en').addPattern('/').add_d().addPattern('/').add_y();

    String formatted = formatterEn.format(now);
    String formatted1 = formatterEn1.format(now);

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      initializeDateFormatting("en").then((_) {
        return formatted;
      });
    } else {
      initializeDateFormatting("en").then((_) {
        return formatted1;
      });
    }
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      return formatted;
    } else {
      return formatted1;
    }
  }

  static String getAr() {
    var now = DateTime.now();
    var formatterAr =
        DateFormat.d('ar').addPattern('/').add_M().addPattern('/').add_y();

    var formatterAr1 =
        DateFormat.M('ar').addPattern('/').add_d().addPattern('/').add_y();

    String formattedAr = formatterAr.format(now);
    String formattedAr1 = formatterAr1.format(now);

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      initializeDateFormatting("ar").then((_) {
        return formatterAr;
      });
    } else {
      initializeDateFormatting("ar").then((_) {
        return formatterAr1;
      });
    }
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      return formattedAr;
    } else {
      return formattedAr1;
    }
  }

  static String getBn() {
    var now = DateTime.now();
    var formatterBn =
        DateFormat.d('bn').addPattern('/').add_M().addPattern('/').add_y();

    var formatterBn1 =
        DateFormat.M('bn').addPattern('/').add_d().addPattern('/').add_y();

    String formattedBn = formatterBn.format(now);
    String formattedBn1 = formatterBn1.format(now);

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      initializeDateFormatting("bn").then((_) {
        return formattedBn;
      });
    } else {
      initializeDateFormatting("bn").then((_) {
        return formattedBn1;
      });
    }
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      return formattedBn;
    } else {
      return formattedBn1;
    }
  }

  static String getMr() {
    var now = DateTime.now();
    var formatterMr =
        DateFormat.d('mr').addPattern('/').add_M().addPattern('/').add_y();

    var formatterMr1 =
        DateFormat.M('mr').addPattern('/').add_d().addPattern('/').add_y();

    String formattedMr = formatterMr.format(now);
    String formattedMr1 = formatterMr1.format(now);

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      initializeDateFormatting("mr").then((_) {
        return formattedMr;
      });
    } else {
      initializeDateFormatting("mr").then((_) {
        return formattedMr1;
      });
    }
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      return formattedMr;
    } else {
      return formattedMr1;
    }
  }

  static String getNe() {
    var now = DateTime.now();
    var formatterNe =
        DateFormat.d('ne_Np').addPattern('/').add_M().addPattern('/').add_y();

    var formatterNe1 =
        DateFormat.M('ne_Np').addPattern('/').add_d().addPattern('/').add_y();

    String formattedNe = formatterNe.format(now);
    String formattedNe1 = formatterNe1.format(now);

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      initializeDateFormatting("ne_Np").then((_) {
        return formattedNe;
      });
    } else {
      initializeDateFormatting("ne_Np").then((_) {
        return formattedNe1;
      });
    }

    if (Constants.dateFormat == Constants.ddMmYyyy) {
      return formattedNe;
    } else {
      return formattedNe1;
    }
  }

  static String getFormatDate() {
    if (Constants.dateFormat == Constants.ddMmYyyy) {
      if (checkOfValue == 0) {
        return getAr();
      } else if (checkOfValue == 2) {
        return getBn();
      } else if (checkOfValue == 27) {
        return getMr();
      } else if (checkOfValue == 28) {
        return getNe();
      } else {
        getEn();
      }
    } else {
      if (checkOfValue == 0) {
        return getAr();
      } else if (checkOfValue == 2) {
        return getBn();
      } else if (checkOfValue == 27) {
        return getMr();
      } else if (checkOfValue == 28) {
        return getNe();
      } else {
        getEn();
      }
    }
    return getEn();
  }

  static String getFormatText(String s) {
    String text1 = "";
    debugPrint("MyColors.decimalformat-->${MyColors.decimalFormat}");
    debugPrint("getFormatText-->$s");

    if (s.contains("e")) {
      HapticFeedback.vibrate();
      BotToast.showText(
        text: "Value limit exeed",
        animationDuration: const Duration(milliseconds: 100),
        align: Alignment.center,
        contentColor: const Color(0xff333333),
        contentPadding: const EdgeInsets.all(10.0),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 17.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      );
      debugPrint("getFormatText");
    }

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

  static Color lighten(Color color, [double amount = 0.49]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);

    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static notifyThemeChange() async {
    debugPrint("notifyThemeChange--->");
    const platform =
        MethodChannel('com.example.currency_converter/notifyThemeChange');
    try {
      final result = await platform.invokeMethod('notifyThemeChange');
      debugPrint("exception--->$result");
    } on PlatformException catch (e) {
      debugPrint("exception--->$e");
    }
  }

  static notifyLanguageChange() async {
    const platform =
        MethodChannel('com.example.currency_converter/notifyThemeChange');
    try {
      final result = await platform.invokeMethod('notifyLanguageChange');
      debugPrint("exception--->$result");
    } on PlatformException catch (e) {
      debugPrint("exception--->$e");
    }
  }

  static getSelectedColorForUnlock() async {
    print("getThemeColor-->");
    List<ColorTable> selectedColor = await dbHelper.getSelectedColor();

    if (selectedColor.isNotEmpty) {
      ColorTable colorTable = selectedColor.first;

      if (colorTable.isLocked == ColorsConst.lockedColor) {
        await dbHelper.selectColor(ColorTable(
          previousColor: 0,
          colorCode: colorTable.colorCode,
          selected: 1,
          isLocked: ColorsConst.lockedColor,
        ));
        String colorCode =
            Constants.unlockColors.first.mainColor.value.toRadixString(16);
        await Utility.setStringPreference(
            Constants.primaryColorCode, colorCode);
        await dbHelper.selectColor(ColorTable(
          previousColor: 0,
          colorCode: colorCode,
          selected: 0,
          isLocked: ColorsConst.unLockedColor,
        ));
        MyColors.colorPrimary = Constants.unlockColors.first.mainColor;
      } else {
        int code = int.parse("0x" + colorTable.colorCode);
        Color c = Color(code);
        MyColors.colorPrimary = c;
        print("printOnMyColor");
        await Utility.setStringPreference(
            Constants.primaryColorCode, c.value.toRadixString(16));
        Utility.notifyThemeChange();
      }
      await Utility.getColorTheme();
      int red = MyColors.colorPrimary.red;
      int blue = MyColors.colorPrimary.blue;
      int green = MyColors.colorPrimary.green;
      var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
      print("************************-> $grayscale");
      if (await Utility.getBooleanPreference(Constants.isDarkMode)) {
        MyColors.isDarkMode = true;
        // MyColors.lightModeCheck = !MyColors.lightModeCheck;
        MyColors.textColor = const Color(0xff333333);
        MyColors.insideTextFieldColor = Colors.white;
        MyColors.calcuColor = const Color(0xff333333);

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:
              MyColors.colorPrimary, // navigation bar color
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: MyColors.colorPrimary, // status bar color
        ));
      } else if (grayscale > 200) {
        debugPrint("Hello Dark Mode Colors");
        MyColors.textColor = Colors.grey.shade700;
        MyColors.insideTextFieldColor = Colors.white;
        MyColors.isDarkMode = true;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          // statusBarIconBrightness: !MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              MyColors.colorPrimary, // navigation bar color
          statusBarColor: MyColors.colorPrimary, // status bar color
        ));
      } else {
        debugPrint("grayscale > 1 $grayscale");
        MyColors.textColor = Colors.white;
        MyColors.insideTextFieldColor = Colors.black;
        MyColors.isDarkMode = false;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor:
              MyColors.colorPrimary, // navigation bar color
          statusBarColor: MyColors.colorPrimary, // status bar color
        ));
      }
    }
  }
}
