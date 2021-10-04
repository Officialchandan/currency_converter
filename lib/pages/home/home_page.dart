import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:math';

import 'package:currency_converter/TapScreens/decimalsceen.dart';
import 'package:currency_converter/pages/home/home_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:currency_converter/API/apis.dart';
import 'package:currency_converter/Models/converter_data.dart';
import 'package:currency_converter/Models/model.dart';
import 'package:currency_converter/TapScreens/ReatingPop.dart';
import 'package:currency_converter/TapScreens/TeramAndCondition.dart';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/second_screen.dart';
import 'package:currency_converter/pages/setting_screen.dart';

class MyTabBarWidget extends StatefulWidget {
  const MyTabBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTabBarWidget> createState() => _MyTabBarWidgetState();
}

class _MyTabBarWidgetState extends State<MyTabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String textCurrency = "USA";
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.firstthemecolorgr,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tabController,
              indicatorWeight: 2.5,

              indicatorColor: Colors.white,

              // labelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Image.asset("assets/tab-ic1.png",
                      color: MyColors.textColor, scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic2.png",
                      color: MyColors.textColor, scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic3.png",
                      color: MyColors.textColor, scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic4.png",
                      color: MyColors.textColor, scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic5.png",
                      color: MyColors.textColor, scale: 4),
                ),
                Tab(
                  icon: Image.asset("assets/tab-ic6.png",
                      color: MyColors.textColor, scale: 4),
                ),
              ],
            ),
          ],
        ),
      ),

      ///***Backraunde colors */
      body: Container(
        height: appheight,
        width: appwidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            MyColors.firstthemecolorgr1,
            MyColors.firstthemecolorgr,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: TabBarView(
          controller: _tabController,
          children: [
            const TapHome(),
            const SecondScreen(),
            const DecimalScreens(),
            const ReatingPop(),
            const TeramAndCondition(),
            SettingScreen(onThemeChange),
          ],
        ),
      ),
    );
  }

  onThemeChange() {
    setState(() {});
  }
}

class CurrencyData {
  String key;
  double value;
  CurrencyData({required this.key, required this.value});
}
