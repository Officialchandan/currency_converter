import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        MyColors.firstthemecolorgr, // navigation bar color
    statusBarColor: MyColors.firstthemecolorgr, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      home:  MyTabBarWidget(),
    );
  }
}
