import 'dart:core';
import 'dart:developer';
import 'package:currency_converter/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:currency_converter/TapScreens/decimalsceen.dart';
import 'package:currency_converter/pages/home/home_tab.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:currency_converter/tramandconditions/teram_and_condition.dart';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/second_screen.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:google_fonts/google_fonts.dart';

  class MyTabBarWidget extends StatefulWidget {
  const MyTabBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTabBarWidget> createState() => _MyTabBarWidgetState();
}

class _MyTabBarWidgetState extends State<MyTabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<int> index = [0];
  int escapeIndex = 0;
  int previousIndex = 0;
  String theme="";
   Color? background;

  @override
  void initState() {
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
        backgroundColor: MyColors.firstthemecolorgr,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tabController,
              indicatorWeight: 2.5,

              onTap: (_selectedIndex) {
                index.add(_selectedIndex);

                if (index.length > 2) {
                  escapeIndex = index[index.length - 2];

                  log("previous ->>>>${index[index.length - 2]}");
                } else if (index.length == 2) {
                  escapeIndex = index[index.length - 2];

                  log("previous->>>>${index[index.length - 2]}");
                } else {
                  escapeIndex = index[index.length - 1];

                  log("previous->>>>${index[0]}");
                }

                if (_selectedIndex == 3) {
                  ratingBottomSheet(context);
                  _tabController.index = escapeIndex;
                }
              },

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
                  child: IconButton(
                    onPressed: () {
                      ratingBottomSheet(context);
                    },
                    icon: Image.asset("assets/tab-ic4.png",
                        color: MyColors.textColor, scale: 4),
                  ),
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
            const InkWell(),
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

  ratingBottomSheet(BuildContext context) {

    return showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: LinearGradient(
                  colors: [
                    Colors.white12,
                    MyColors.firstthemecolorgr,
                  ],
                  stops: const [0.0, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(top: 10, bottom: 8),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset("assets/app-icon.png")),
                  ),
                  Text(
                    "Please rate our app!",
                    style: GoogleFonts.roboto(
                        fontSize: MyColors.fontsmall
                            ? (MyColors.textSize - 17) * (-1)
                            : MyColors.fontlarge
                                ? (MyColors.textSize + 17)
                                : 17,
                        color: MyColors.textColor,
                        fontWeight: FontWeight.normal),
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
                              text:
                                  "Tap on stars and open with Google Play Store to rate",
                              style: GoogleFonts.roboto(
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 18) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 18)
                                        : 18,
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      child: Divider(
                        color: MyColors.textColor,
                        height: 22.2,
                        thickness: 1.2,
                      )),
                  Container(
                    width: 130,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: MyColors.textColor),
                      onPressed: () {
                        Navigator.pop(context);
                        if (_tabController.previousIndex == 2 ||
                            _tabController.previousIndex == 4)
                          _tabController
                              .animateTo(_tabController.previousIndex);
                      },
                      child: Text(
                        "NOT NOW",
                        style: TextStyle(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 18) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 18)
                                    : 18,
                            color: MyColors.insideTextFieldColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  tabChangeListener(int index) {
    debugPrint("index ->$index");

    if (index == 3) {
      ratingBottomSheet(context);
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // getCurrencyCode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //    theme = prefs.getString(Constants.theme) ?? "";
  //
  //
  //   if (theme.isNotEmpty ) {
  //     int value=int.parse(theme);
  //     var code = (value.toRadixString(16));
  //     background= Color(int.parse("0x$code"));
  //
  //   }
  //   setState(() {});
  // }
}

class CurrencyData {
  String key;
  double value;
  bool favorite = false;
  bool changeIcon = false;

  CurrencyData({
    required this.key,
    required this.value,
  });
}
