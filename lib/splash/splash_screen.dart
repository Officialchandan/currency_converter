import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/main.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
      ),
    );
  }

  Future<void> insert() async {
    String url = "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        //ConverterData converterData = ConverterData.fromJson(response.toString());
        Map res = response.data!;
        Map<String, dynamic> quotes = res["quotes"];
        quotes.forEach((key, value) async {
          DataModel currencyData = DataModel(value: value.toString(), code: key, image: "", name: "", fav: 0, selected: 0);

          await dbHelper.insert(currencyData.toMap());
        });
      } else {
        print("NOT FOUND DATA");
      }
    } catch (e) {
      print(e);
    }
  }

  void init() async {
    // DataModel currencyData = DataModel(value: "0", code: "", image: "", name: "", fav: 0, selected: 0);
    // await dbHelper.insert(currencyData.toMap());
    //
    //
    // await insert();

    String dateFormat = await Utility.getStringPreference(Constants.DATE_FROMAT);
    if (dateFormat.isNotEmpty) {
      Constants.dateFormat = dateFormat;
    } else {
      Constants.dateFormat = Constants.mmDdYyyy;
    }

    String fonts = await Utility.getStringPreference(Constants.fontSize);
    if (fonts.isNotEmpty) {
      Constants.selectedFontSize = fonts;
    } else {
      Constants.selectedFontSize = Constants.fontSmall;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyTabBarWidget()));
  }
}
