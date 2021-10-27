import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/locals.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await insertData();
  await insertion();

  runApp(EasyLocalization(
      child: MyApp(),
      path: "assets/languagecode",
      fallbackLocale: Locale('en'),
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      supportedLocales: Locals.supportedLang));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyTabBarWidget(),
    );
  }

  void getTheme() async {
    await Utility.getColorTheme();
    MyColors.checkBoxValue2 =
        useWhiteForeground(MyColors.colorPrimary) ? false : true;
    if (MyColors.checkBoxValue2) {
      MyColors.textColor = Colors.black;
      MyColors.insideTextFieldColor = Colors.white;
      MyColors.checkBoxValue2 = true;
      MyColors.checkBoxValue1 = false;
    } else {
      MyColors.textColor = Colors.white;
      MyColors.insideTextFieldColor = Colors.black;
      MyColors.checkBoxValue1 = true;
      MyColors.checkBoxValue2 = false;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
      statusBarColor: MyColors.colorPrimary, // status bar color
    ));
  }
}

Future<void> insertData() async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  String url =
      "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

  Dio _dio = Dio();
  try {
    Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      Map res = response.data!;
      Map<String, dynamic> quotes = res["quotes"];
      quotes.forEach((key, value) async {
        Map<String, dynamic> map = Constants.countryList
            .singleWhere((element) => element["code"] == key, orElse: () {
          print("database data ->$key");

          return {};
        });

        DataModel currencyData = DataModel(
            value: value.toString(),
            code: key,
            image: map["image"],
            name: map["country_name"],
            fav: 0,
            selected: 0,
            symbol: map["Symbol"]);

        int id = await dbHelper.insert(currencyData.toMap());
      });
    } else {
      print("NOT FOUND DATA");
    }
  } catch (e) {
    print(e);
  }
}

insertion() async {
  MyColors.text = await Utility.getFormatExmaplePreference("FormatExmaple");

  int x = await Utility.getMonetaryValuePreference("MonetaryValue");

  MyColors.monetaryFormat = x;
  print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$x");
  for (int i = 0; i < MyColors.boolMonetaryFormate.length; i++) {
    if (i == x - 1) {
      MyColors.boolMonetaryFormate[i] = true;
    } else {
      MyColors.boolMonetaryFormate[i] = false;
    }
  }

  int y = await Utility.getDecimalValuePreference("DecimalValue");
  MyColors.decimalFormat = y;
  print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$y");
  for (int i = 0; i < MyColors.boolDecimalFormate.length; i++) {
    if (y == 0) {
      MyColors.boolDecimalFormate[5] = true;
      MyColors.boolDecimalFormate[4] = false;
      MyColors.boolDecimalFormate[3] = false;
      MyColors.boolDecimalFormate[2] = false;
      MyColors.boolDecimalFormate[1] = false;
      MyColors.boolDecimalFormate[0] = false;
      break;
    }
    if (i == y - 2) {
      MyColors.boolDecimalFormate[i] = true;
    } else {
      MyColors.boolDecimalFormate[i] = false;
    }
  }
}
