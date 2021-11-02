import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/splash/splash_screen.dart';
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await insertData();
  await insertion();

  runApp(EasyLocalization(
      child: MyApp(),
      path: "assets/language_final",
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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
          child: child!,
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashScreen(),
    );
  }

  void getTheme() async {
    await Utility.getColorTheme();

    int red = MyColors.colorPrimary.red;
    int blue = MyColors.colorPrimary.blue;
    int green = MyColors.colorPrimary.green;

    var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
    print("************************-> $grayscale");

    if (grayscale > 128) {
      MyColors.textColor = Colors.grey.shade700;
      MyColors.insideTextFieldColor = Colors.white;
      MyColors.darkModeCheck = true;
      MyColors.lightModeCheck = false;
    } else {
      MyColors.textColor = Colors.white;
      MyColors.insideTextFieldColor = Colors.black;
      MyColors.lightModeCheck = true;
      MyColors.darkModeCheck = false;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
      statusBarColor: MyColors.colorPrimary, // status bar color
    ));
  }
}

Future<void> insertData() async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  String url = "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

  Dio _dio = Dio();
  try {
    Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      Map res = response.data!;
      Map<String, dynamic> quotes = res["quotes"];
      quotes.forEach((key, value) async {
        Map<String, dynamic> map = Constants.countryList.singleWhere((element) => element["code"] == key, orElse: () {
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
  String monetary = await Utility.getStringPreference(Constants.monetaryFormat);
  String decimal = await Utility.getStringPreference(Constants.decimalFormat);

  monetary = monetary == "" ? "1" : monetary;
  decimal = decimal == "" ? "2" : decimal;
  MyColors.monetaryFormat = int.parse(monetary);
  MyColors.decimalFormat = int.parse(decimal);
}
