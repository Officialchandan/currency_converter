import 'dart:async';
import 'dart:developer';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../in_app_parchase/product_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late InAppProvider _inAppProvider;
  String logEventResponse = "No event have been sent";
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // status bar color
    ));
    final provider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = provider;
    Timer(
      const Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: Constants.textScaleFactor,
            ),
            child: const MyTabBarWidget(),
          ),
        ),
      ),
    );
    getHistory();
    appsFlyer();
    init();
    super.initState();
  }

  // void info() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //   debugPrint("androidDeviceInfo-->>${androidDeviceInfo.androidId}");
  //   debugPrint("androidDeviceInfo-->>${androidDeviceInfo.model}");
  // }

  getHistory() async {
    _inAppProvider.initPlatformState();
    _inAppProvider.getPurchaseHistoryOfAds();
    _inAppProvider.getPurchaseHistoryOfColors();
  }

  appsFlyer() {
    AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: "sSciSETKRuU6a8cqCETSSJ",
        appId: "com.currencywiki.currencyconverter",
        showDebug: true);
    Constants.appsflyerSdk = AppsflyerSdk(options);
    Constants.appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);

    try {
      Constants.appsflyerSdk.onAppOpenAttribution((res) {
        debugPrint("onAppOpenAttribution res: " + res.toString());
        log("onAppOpenAttribution res: " + res.toString());
        setState(() {});
      });
    } catch (e) {
      debugPrint("onAppOpenAttribution-->>$e");
    }

    try {
      Constants.appsflyerSdk.onInstallConversionData((res) {
        debugPrint("onInstallConversionData res: " + res.toString());
        log("onInstallConversionData res:" + res.toString());
        setState(() {});
      });
    } catch (e) {
      debugPrint("onInstallConversionData-->>$e");
    }

    try {
      Constants.appsflyerSdk
          .onDeepLinking((onDp) => debugPrint("onDp-->$onDp"));
      Constants.appsflyerSdk.setIsUpdate(true);
    } catch (e) {
      debugPrint("onDeepLinking-->>$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/images/splash.png',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void init() async {
    String dateFormat =
        await Utility.getStringPreference(Constants.DATE_FROMAT);
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
  }
}
