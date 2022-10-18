import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/TapScreens/decimalsceen.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_tab.dart';
import 'package:currency_converter/pages/my_currency.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/tramandconditions/teram_and_condition.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

enum Availability { loading, available, unavailable }

class MyTabBarWidget extends StatefulWidget {
  const MyTabBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTabBarWidget> createState() => _MyTabBarWidgetState();
}

class _MyTabBarWidgetState extends State<MyTabBarWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  List<int> index = [0];
  int escapeIndex = 0;
  int previousIndex = 0;
  bool muliticonverter = false;
  late TabController _tabController;
  TabChangeListener? listener;
  String theme = "";
  String theme1 = "";
  String checkStatusCodeViaWidget = '0';
  int _isAppCount = 0;

  final InAppReview _inAppReview = InAppReview.instance;

  String _appStoreId = '';
  String _microsoftStoreId = '';
  Availability _availability = Availability.loading;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness:
          !MyColors.isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
      statusBarColor: MyColors.colorPrimary, // status bar color
    ));
    _tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      tabChangeListener(_tabController.index);
      debugPrint("index1->${_tabController.index}");
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getStatusCodeOnOpenWidget();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        print("isAvailable-->${isAvailable}");

        setState(() {
          _availability = isAvailable && Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
          print("_availability-->${_availability}");
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  saveStatusCode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.openViaWidgetStatus, '0');
    debugPrint("Yes_I_AM");
  }

  getStatusCodeOnOpenWidget() async {
    checkStatusCodeViaWidget = '0';
    final prefs = await SharedPreferences.getInstance();
    checkStatusCodeViaWidget =
        prefs.getString(Constants.openViaWidgetStatus) ?? "0";
    debugPrint("checkStatusCodeViaWidget---->$checkStatusCodeViaWidget");
    if (MyColors.muliConverter) {
      if (checkStatusCodeViaWidget == '1') {
        debugPrint("dddddddddddd--->${checkStatusCodeViaWidget}");
        try {
          _tabController.animateTo(
            0,
          );
        } catch (e) {
          debugPrint("exception in navigation to my currency-->$e");
        }
      } else {
        debugPrint("dddddddddddd2--->${checkStatusCodeViaWidget}");
        try {
          _tabController.animateTo(
            1,
          );
        } catch (e) {
          debugPrint("exception in navigation to my currency-->$e");
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    debugPrint("didChangeAppLifecycleState $state");

    if (state == AppLifecycleState.resumed) {
      _isAppCount += 1;
      print("iiii->$_isAppCount");
      if (_isAppCount == 5) {
        if (_availability == Availability.available) {
          _inAppReview.requestReview();
        }
        print("_isAppCount00-->$_isAppCount");
      }
      if (_isAppCount > 5) {
        _isAppCount = 0;
      }
      print("_isAppCount-->$_isAppCount");
      setState(() {});
    }

    if (MyColors.muliConverter) {
      if (state == AppLifecycleState.resumed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            _tabController.animateTo(
              1,
            );
          } catch (e) {
            debugPrint("exception in navigation to my currency-->$e");
          }
        });
      }
    } else if (state == AppLifecycleState.resumed) {
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _tabController.animateTo(
            0,
          );
          await Utility.getSelectedColorForUnlock();
          setState(() {});
        });
      } catch (e) {
        debugPrint("exception in navigation to my currency-->$e");
      }
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      saveStatusCode();
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        elevation: 0,
        leading: Container(),
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
              physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
              indicatorColor: Colors.white,
              labelPadding: const EdgeInsets.all(0),
              tabs: <Widget>[
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/logo.svg",
                    height: 40.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/multi-currency-light.svg",
                    height: 23.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/monetary-light.svg",
                    height: 21.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/rate-light.svg",
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/about-light.svg",
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    "assets/images/settings-light.svg",
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                    color: MyColors.textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              !MyColors.isDarkMode ? Brightness.light : Brightness.dark,

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
            MyColors.colorPrimary.withOpacity(1.0),
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
            MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: Constants.textScaleFactor,
              ),
              child: const MyCurrency(),
            ),
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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),

        //backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
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
                    "rate_the_app".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        color: MyColors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "rate_app_desc".tr().toString(),
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
                    onTap: () async {
                      // PackageInfo packageInfo =
                      //     await PackageInfo.fromPlatform();
                      // Navigator.pop(context);
                      if (_availability == Availability.available) {
                        print("HII_THERE");
                        await _inAppReview.requestReview();
                      } else {
                        print("enrtttt");
                        await _inAppReview.openStoreListing();
                      }
                      // if (await _inAppReview.isAvailable()) {
                      //   print("hii_there");
                      // } else {
                      //   await _inAppReview.openStoreListing();
                      // }
                      // try {
                      //   print("market");
                      //   _launchURL(
                      //       "market://details?id=${packageInfo.packageName}");
                      // } on PlatformException catch (e) {
                      //   print("https://play.google.com--$e");
                      //   _launchURL(
                      //       "https://play.google.com/store/apps/details?id=${packageInfo.packageName}");
                      // } finally {
                      //   print("market");
                      //   _launchURL(
                      //       "https://play.google.com/store/apps/details?id=${packageInfo.packageName}");
                      // }
                      // _launchURL(
                      //     "https://play.google.com/store/apps?utm_source=apac_med&utm_medium=hasem&utm_content=Oct0121&utm_campaign=Evergreen&pcampaignid=MKT-EDR-apac-in-1003227-med-hasem-ap-Evergreen-Oct0121-Text_Search_BKWS-BKWS%7cONSEM_kwid_43700064490253526_creativeid_480912223122_device_c&gclid=CjwKCAjw7--KBhAMEiwAxfpkWKQxO989RVc1NUOy0A3km9V2HeHxoiIcDUM4CFT1AO2Aul2mPkJpCBoCGP0QAvD_BwE&gclsrc=aw.ds");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/star-rate.svg",
                          color: MyColors.textColor,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/star-rate.svg",
                          color: MyColors.textColor,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/star-rate.svg",
                          color: MyColors.textColor,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/star-rate-blank.svg",
                          color: MyColors.textColor,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        SvgPicture.asset(
                          "assets/images/star-rate-blank.svg",
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
                    width: 120,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: MyColors.textColor),
                      onPressed: () {
                        Navigator.pop(context);
                        if (_tabController.previousIndex == 2 ||
                            _tabController.previousIndex == 4) {
                          _tabController
                              .animateTo(_tabController.previousIndex);
                        }
                      },
                      child: AutoSizeText(
                        "not_now".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
                        style: TextStyle(
                            fontSize: 18,
                            color: MyColors.colorPrimary,
                            fontWeight: FontWeight.bold),
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

    final prefs1 = await SharedPreferences.getInstance();
    theme1 = prefs1.getString(Constants.themeofDensityColor) ?? "";
    debugPrint("color->>>> $theme1");

    if (theme.isNotEmpty) {
      int value = int.parse(theme);
      var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$code");
      MyColors.colorPrimary = Color(int.parse("0x$code"));
    } else if (theme1.isNotEmpty) {
      int value = int.parse(theme1);
      var code = (value.toRadixString(16));
      debugPrint("color code ->>>>$code");
      MyColors.colorPrimary = Color(int.parse("0x$code"));
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

  CurrencyData(
      {required this.key,
      required this.value,
      this.favorite = false,
      this.changeIcon = false});

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
        key: map["key"] ?? "",
        value: map["value"] ?? "",
        favorite: map["favorite"] ?? false,
        changeIcon: map["changeIcon"] ?? false);
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}

abstract class TabChangeListener {
  void onTabChange();
}
