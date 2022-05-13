import 'dart:developer';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../in_app_parchase/product_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late InAppProvider _inAppProvider;

  late AppsflyerSdk _appsflyerSdk;
  @override
  void initState() {
    final provider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = provider;
    getHistory();
    init();
    appsFlyer();
    super.initState();
  }

  getHistory() async {
    await _inAppProvider.initPlatformState();
    await _inAppProvider.getPurchaseHistoryOfAds();
    await _inAppProvider.getPurchaseHistoryOfColors();
  }

  appsFlyer() {
    AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: "bqqKJwEoTTHopf8vS4r8Z6",
        appId: "com.currencywiki.currencyconverter",
        timeToWaitForATTUserAuthorization: 15,
        showDebug: true);
    _appsflyerSdk = AppsflyerSdk(options);
    _appsflyerSdk.onAppOpenAttribution((res) {
      debugPrint("onAppOpenAttribution res: " + res.toString());
      log("onAppOpenAttribution res: " + res.toString());
      setState(() {});
    });
    _appsflyerSdk.onInstallConversionData((res) {
      debugPrint("onInstallConversionData res: " + res.toString());
      log("onInstallConversionData res:" + res.toString());
      setState(() {});
    });
    _appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        // child: const InApp(),
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: Constants.textScaleFactor,
                ),
                child: const MyTabBarWidget())));
  }
}
