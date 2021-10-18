import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/locals.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await insertData();

  runApp(EasyLocalization(
      child: const MyApp(),
      path: "assets/langs",
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
        Map<String,dynamic> map =   Constants.countryList.singleWhere((element) => element["code"]==key,
            orElse:(){

          print("database data ->$key");

          return{};
        });
          print(map);



        DataModel currencyData = DataModel(
            value: value.toString(),
            code: key,
            image: map["image"],
             name: map["country_name"],
            fav: 0,
            selected: 0,
            symbol: ""
        );

        int id = await dbHelper.insert(currencyData.toMap());

         log("$id");
      });
    } else {
      print("NOT FOUND DATA");
    }
  } catch (e) {
    print(e);
  }
  dbHelper.queryAll();

}
