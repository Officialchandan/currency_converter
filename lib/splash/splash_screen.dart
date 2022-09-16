import 'dart:async';

import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  String version = "1.0.0";
  Map? _deepLinkData;
  Map? _gcd;
  @override
  void initState() {
    init();
    getPackage();
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
      bottomNavigationBar: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text("app version : $version"),
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
      print("font-->$fonts");
      if (Constants.selectedFontSize == 'fontLarge') {
        Constants.textScaleFactor = 1;
      } else if (Constants.selectedFontSize == "fontMedium") {
        Constants.textScaleFactor = .95;
      } else if (Constants.selectedFontSize == "fontSmall") {
        Constants.textScaleFactor = 0.9;
      } else {
        Constants.textScaleFactor = 0.9;
        Constants.selectedFontSize = Constants.fontSmall;
      }
      // Constants.textScaleFactor = 1;
    } else {
      print("print_on_else");
      Constants.textScaleFactor = 0.9;
      Constants.selectedFontSize = Constants.fontSmall;
    }
    setState(() {});
  }

  void getPackage() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {});
  }
}
