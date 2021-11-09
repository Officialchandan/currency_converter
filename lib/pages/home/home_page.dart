import 'dart:convert';
import 'dart:core';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/TapScreens/decimalsceen.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_tab.dart';
import 'package:currency_converter/pages/my_currency.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/tramandconditions/teram_and_condition.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTabBarWidget extends StatefulWidget {
  const MyTabBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTabBarWidget> createState() => _MyTabBarWidgetState();
}

class _MyTabBarWidgetState extends State<MyTabBarWidget> with TickerProviderStateMixin {
  List<int> index = [0];
  int escapeIndex = 0;
  int previousIndex = 0;
  late TabController _tabController;
  TabChangeListener? listener;

  String theme = "";

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
      statusBarColor: MyColors.colorPrimary, // status bar color
    ));
    setState(() {});
    super.initState();

    _tabController = TabController(length: 6, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      tabChangeListener(_tabController.index);
      debugPrint("index1->${_tabController.index}");
    });

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String textCurrency = "USA";
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        elevation: 0,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              indicator: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2.9, color: MyColors.textColor),
              )),
              controller: _tabController,
              indicatorWeight: 2.5,
              onTap: (_selectedIndex) async {
                if (_selectedIndex == 3) {
                  _tabController.index = _tabController.previousIndex;
                }
              },
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Container(
                    width: 40,
                    height: 35,
                    child: Image.asset("assets/images/tab-ic1.png",
                        fit: BoxFit.fill,
                        //scale: 6,
                        color: MyColors.textColor),
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    "assets/images/tab-ic2.png",
                    scale: 7,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    "assets/images/tab-ic3.png",
                    scale: 7,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    "assets/images/tab-ic4.png",
                    scale: 7,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    "assets/images/tab-ic5.png",
                    scale: 7,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    "assets/images/tab-ic6.png",
                    scale: 7,
                    color: MyColors.textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
          statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,

          // sys
        ),
        // brightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
      ),

      ///***Backraunde colors */
      body: Container(
        height: appheight,
        width: appwidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            MyColors.colorPrimary.withOpacity(0.6),
            MyColors.colorPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: TabBarView(
          controller: _tabController,
          children: [
            TapHome(
              onInitialize: (tabChangeListener) {
                listener = tabChangeListener;
              },
            ),
            MyCurrency(),
            const DecimalScreens(),
            const InkWell(),
            const TeramAndCondition(),
            SettingScreen(onThemeChange),
          ],
        ),
      ),
    );
  }

  tabChangeListener(int index) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (index == 0 && listener != null) {
      listener!.onTabChange();
    }

    debugPrint("index ->$index");
    if (index == 3) {
      ratingBottomSheet(context);
    }

    setState(() {});
  }

  onThemeChange() {
    setState(() {});
  }

  ratingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),

        //backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                gradient: LinearGradient(
                  colors: [
                    MyColors.colorPrimary.withOpacity(0.5),
                    MyColors.colorPrimary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(top: 15, bottom: 8),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/currency1.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text(
                    "firstTextRatingPage".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                    style: GoogleFonts.roboto(fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "secondTextRatingPage".tr().toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: MyColors.textColor,
                                fontWeight: FontWeight.normal,
                              )),
                        ])),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL(
                          "https://play.google.com/store/apps?utm_source=apac_med&utm_medium=hasem&utm_content=Oct0121&utm_campaign=Evergreen&pcampaignid=MKT-EDR-apac-in-1003227-med-hasem-ap-Evergreen-Oct0121-Text_Search_BKWS-BKWS%7cONSEM_kwid_43700064490253526_creativeid_480912223122_device_c&gclid=CjwKCAjw7--KBhAMEiwAxfpkWKQxO989RVc1NUOy0A3km9V2HeHxoiIcDUM4CFT1AO2Aul2mPkJpCBoCGP0QAvD_BwE&gclsrc=aw.ds");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 40,
                          color: MyColors.textColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 40,
                          color: MyColors.textColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 40,
                          color: MyColors.textColor,
                        ),
                        Icon(
                          Icons.star_border_purple500_sharp,
                          size: 40,
                          color: MyColors.textColor,
                        ),
                        Icon(
                          Icons.star_border_purple500_sharp,
                          size: 40,
                          color: MyColors.textColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                      child: Divider(
                        color: MyColors.textColor,
                        height: 22.2,
                        thickness: 1.2,
                      )),
                  Container(
                    width: 120,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: MyColors.textColor),
                      onPressed: () {
                        Navigator.pop(context);
                        if (_tabController.previousIndex == 2 || _tabController.previousIndex == 4) {
                          _tabController.animateTo(_tabController.previousIndex);
                        }
                      },
                      child: AutoSizeText(
                        "not".tr().toString(),
                        style: TextStyle(fontSize: 18, color: MyColors.colorPrimary, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13.0,
                  )
                ],
              ),
            ),
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    theme = prefs.getString(Constants.themeColor) ?? "";
    debugPrint("color->>>> $theme");

    if (theme.isNotEmpty) {
      int value = int.parse(theme);
      var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$code");
      MyColors.colorPrimary = Color(int.parse("0x$code"));
    } else {
      debugPrint("color is empty");
    }

    setState(() {});
  }
}

class CurrencyData {
  String key;
  double value;
  bool favorite = false;
  bool changeIcon = false;
  TextEditingController controller = TextEditingController();

  CurrencyData({required this.key, required this.value, this.favorite = false, this.changeIcon = false});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["key"] = key;
    map["value"] = value;
    map["favorite"] = favorite;
    map["changeIcon"] = changeIcon;

    return map;
  }

  factory CurrencyData.fromMap(String data) {
    Map map = jsonDecode(data);

    return CurrencyData(
        key: map["key"] ?? "", value: map["value"] ?? "", favorite: map["favorite"] ?? false, changeIcon: map["changeIcon"] ?? false);
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}

abstract class TabChangeListener {
  void onTabChange();
}
