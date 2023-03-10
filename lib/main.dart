import 'dart:async';
import 'dart:math';

import 'package:advertising_id/advertising_id.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/database/coredata.dart';
import 'package:currency_converter/database/currencydata.dart';
import 'package:currency_converter/splash/splash_screen.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/locals.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

import 'database/color_data.dart';
import 'in_app_parchase/product_provider.dart';

final dbHelper = DatabaseHelper.instance;
Workmanager workmanager = Workmanager();

void callbackDispatcher() {
  debugPrint("callbackDispatcher--->");
  workmanager.executeTask((taskName, inputData) {
    final now = DateTime.now();
    return Future.wait<bool?>([
      HomeWidget.saveWidgetData(
        'title',
        'Updated from Background',
      ),
      HomeWidget.saveWidgetData(
        'message',
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      ),
      HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider',
        iOSName: 'HomeWidgetExample',
      ),
    ]).then((value) {
      debugPrint("callbackDispatcher--->$value");
      return !value.contains(false);
    });
  });
}

void backgroundCallback(Uri? data) async {
  print("data--->$data");
  debugPrint("backgroundCallback--->$data");

  if (data!.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '??????',
      '???????????????',
      'xin ch??o'
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];
    await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
    await HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
  }
}

Uuid uuid = const Uuid();

void isolate1(String arg) async {
  insertData();

  await insertColors();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await insertion();
  final isolate = await FlutterIsolate.spawn(isolate1, "Db");
  Timer(const Duration(seconds: 29), () {
    isolate.pause();
  });
  Timer(const Duration(seconds: 30), () {
    isolate.kill();
  });
  Timer(const Duration(seconds: 32), () {
    FlutterIsolate.killAll();
  });
  if (kDebugMode) {
    print("isolate--");
  }
  workmanager.initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  await Utility.getBooleanPreference(Constants.isDarkMode);
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // MobileAds.setTestDeviceIds([await Utility.getAdId(Constants.GET_ID)]);
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider<InAppProvider>(
    create: (_) => InAppProvider(),
    child: EasyLocalization(
        child: const MyApp(),
        path: "assets/language",
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        useOnlyLangCode: true,
        supportedLocales: Locals.supportedLang),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String advertisingIds = '';
  bool? _isLimitAdTrackingEnabled;
  late InAppProvider _inAppProvider;
  Map? _deepLinkData;
  Map? _gcd;

  @override
  void initState() {
    final provider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = provider;
    SystemChannels.restoration;
    getTheme();
    initAdd();
    HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    HomeWidget.registerBackgroundCallback(backgroundCallback);
    super.initState();
    // appsFlyer();
  }

  initAdd() async {
    getHistory();
    getAds();
    await Utility.getSelectedColorForUnlock();
    setState(() {});
    Utility.notifyThemeChange();
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {}
  }

  // appsFlyer() {
  //   print("appsFLyer-->");
  //   AppsFlyerOptions options = AppsFlyerOptions(
  //     afDevKey: "sSciSETKRuU6a8cqCETSSJ",
  //     appId: "com.currencywiki.currencyconverter",
  //     showDebug: true,
  //     timeToWaitForATTUserAuthorization: 80,
  //   );
  //   Constants.appsflyerSdk = AppsflyerSdk(options);
  //   Constants.appsflyerSdk.initSdk(
  //     registerConversionDataCallback: true,
  //     registerOnAppOpenAttributionCallback: true,
  //     registerOnDeepLinkingCallback: true,
  //   );
  //
  //   Constants.appsflyerSdk.onAppOpenAttribution((res) {
  //     print("onAppOpenAttribution res: " + res.toString());
  //     setState(() {
  //       _deepLinkData = res;
  //     });
  //   });
  //   Constants.appsflyerSdk.onInstallConversionData((res) {
  //     print("onInstallConversionData res: " + res.toString());
  //     setState(() {
  //       _gcd = res;
  //     });
  //   });
  //
  //   // Constants.appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
  //   //   switch (dp.status) {
  //   //     case Status.FOUND:
  //   //       print(dp.deepLink?.toString());
  //   //       print("deep link value: ${dp.deepLink?.deepLinkValue}");
  //   //       break;
  //   //     case Status.NOT_FOUND:
  //   //       print("deep link not found");
  //   //       break;
  //   //     case Status.ERROR:
  //   //       print("deep link error: ${dp.error}");
  //   //       break;
  //   //     case Status.PARSE_ERROR:
  //   //       print("deep link status parsing error");
  //   //       break;
  //   //   }
  //   //   print("onDeepLinking res: " + dp.toString());
  //   //   setState(() {
  //   //     _deepLinkData = dp.toJson();
  //   //   });
  //   // });
  // }

  getHistory() async {
    _inAppProvider.initPlatformState();
    _inAppProvider.getPurchaseHistoryOfAds();
    print("IN_Main");
  }

  getAds() async {
    Constants.isPurchaseOfAds =
        await Utility.getIntPreference(Constants.yearCheckTimeCons);
    print('isPurchaseOfAds->${Constants.isPurchaseOfAds}');

    if (Constants.isPurchaseOfAds == 0) {
      await Utility.setBooleanPreference(
          Constants.checkWidgetPurchaseAds, false);
    } else {
      DateTime purchaseTime =
          DateTime.fromMillisecondsSinceEpoch(Constants.isPurchaseOfAds);

      DateTime dayTimeNow = DateTime(Constants.timeNow.year,
          Constants.timeNow.month, Constants.timeNow.day);
      DateTime yearCheckTime = DateTime(
          purchaseTime.year, purchaseTime.month, purchaseTime.day + 365);
      if (dayTimeNow.millisecond <= yearCheckTime.microsecond) {
        print("dayTimeNowdayTimeNow");
        await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, true);
      } else {
        print("falseFalseFalse");
        await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, false);
        // Future.delayed(const Duration(seconds: 4), () {
        //   isFirstTime();
        // });
      }
    }
    Constants.getAppPurchase =
        await Utility.getBooleanPreference(Constants.checkWidgetPurchaseAds);
    print('myValue->${Constants.getAppPurchase}');
    setState(() {});
    bool myValue =
        await Utility.getBooleanPreference(Constants.checkWidgetPurchaseAds);
    print('myValue->$myValue');
  }

  @override
  void didChangeDependencies() {
    // debugPrint("didChangeDependencies--->");
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _sendData() async {
    debugPrint("_sendData--->");
    try {
      return Future.wait([
        HomeWidget.saveWidgetData<String>('title', "test title"),
        HomeWidget.saveWidgetData<String>('message', "test message"),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Sending Data. $exception');
    }
  }

  _updateWidget() async {
    debugPrint("_updateWidget--->");
    try {
      return HomeWidget.updateWidget(
          name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
    } on PlatformException catch (exception) {
      debugPrint('Error Updating Widget. $exception');
    }
  }

  _loadData() async {
    debugPrint("_loadData--->");
    try {
      return Future.wait([
        HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
            .then((value) => debugPrint("title-->$value")),
        HomeWidget.getWidgetData<String>('message',
                defaultValue: 'Default Message')
            .then((value) => debugPrint("message-->$value")),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Getting Data. $exception');
    }
  }

  Future<void> _sendAndUpdate() async {
    debugPrint("_sendAndUpdate--->");
    await _sendData();
    await _updateWidget();
  }

  void _checkForWidgetLaunch() {
    // debugPrint("_checkForWidgetLaunch--->");
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    // debugPrint("_launchedFromWidget--->$uri");
    if (uri != null) {
      showDialog(
          context: context,
          builder: (buildContext) => AlertDialog(
                title: const Text('App started from HomeScreenWidget'),
                content: Text('Here is the URI: $uri'),
              ));
    }
  }

  void _startBackgroundUpdate() {
    debugPrint("_startBackgroundUpdate--->");
    workmanager.registerPeriodicTask('1', 'widgetBackgroundUpdate',
        frequency: const Duration(minutes: 15));
  }

  void _stopBackgroundUpdate() {
    debugPrint("_stopBackgroundUpdate--->");
    workmanager.cancelByUniqueName('1');
  }

  // Future<bool> isFirstTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? firstTime = prefs.getBool('first_time');
  //   var isFirstTime = prefs.getBool('first_time');
  //   if (isFirstTime != null && !isFirstTime) {
  //     prefs.setBool('first_time', false);
  //     loadAppOpenAd();
  //     return false;
  //   } else {
  //     prefs.setBool('first_time', false);
  //     return true;
  //   }
  // }

  initPlatformState() async {
    await Utility.getBooleanPreference(Constants.REMOVE_AD);
    String advertisingId;
    bool? isLimitAdTrackingEnabled;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      advertisingId = (await AdvertisingId.id(true))!;
    } on PlatformException {
      advertisingId = 'Failed to get platform version.';
    }

    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled;
    } on PlatformException {
      isLimitAdTrackingEnabled = false;
    }
    advertisingIds = advertisingId;
    _isLimitAdTrackingEnabled = isLimitAdTrackingEnabled;
    await Utility.setAdId(Constants.GET_ID, advertisingIds.toString());
  }

  // void getOpenAd() async {
  //   const appOpenAdTestUnitId = 'ca-app-pub-3940256099942544/3419835294';
  //   final AppOpenAd appOpenAd = AppOpenAd();
  //   try {
  //     if (!appOpenAd.isAvailable) {
  //       await appOpenAd.load(unitId: appOpenAdTestUnitId);
  //     }
  //     if (appOpenAd.isAvailable) {
  //       await appOpenAd.show();
  //     }
  //   } catch (e) {
  //     debugPrint("e--$e");
  //   }
  // }

  // AppOpenAd? myAppOpenAd;
  //
  // loadAppOpenAd() {
  //   print("loadAppOpenAd-->");
  //   const appOpenAdTestUnitId = 'ca-app-pub-3096560792937908/2624180523';
  //   AppOpenAd.load(
  //       adUnitId: appOpenAdTestUnitId,
  //       request: const AdRequest(),
  //       adLoadCallback: AppOpenAdLoadCallback(
  //           onAdLoaded: (ad) {
  //             myAppOpenAd = ad;
  //             myAppOpenAd!.show();
  //           },
  //           onAdFailedToLoad: (error) {}),
  //       orientation: AppOpenAd.orientationPortrait);
  // }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    print("didUpdate---");
    super.didUpdateWidget(oldWidget);
  }

  final botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InAppProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: Constants.textScaleFactor),
          child: child,
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.roboto().fontFamily,
        primarySwatch: ColorTools.createPrimarySwatch(MyColors.colorPrimary),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // primaryColor: MyColors.colorPrimary,
        textSelectionTheme: hadls(provider),
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
    if (await Utility.getBooleanPreference(Constants.isDarkMode)) {
      MyColors.isDarkMode = true;
      // MyColors.lightModeCheck = !MyColors.lightModeCheck;
      MyColors.textColor = const Color(0xff333333);
      MyColors.insideTextFieldColor = Colors.white;
      MyColors.calcuColor = const Color(0xff333333);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: MyColors.colorPrimary, // status bar color
      ));
    } else if (grayscale > 200) {
      debugPrint("Hello Dark Mode Colors");
      MyColors.textColor = Colors.grey.shade700;
      MyColors.insideTextFieldColor = Colors.white;
      MyColors.isDarkMode = true;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarIconBrightness: !MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
        statusBarColor: MyColors.colorPrimary, // status bar color
      ));
    } else {
      debugPrint("grayscale > 1 $grayscale");
      MyColors.textColor = Colors.white;
      MyColors.insideTextFieldColor = Colors.black;
      MyColors.isDarkMode = false;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
        statusBarColor: MyColors.colorPrimary, // status bar color
      ));
    }
    setState(() {});
  }

  hadls(InAppProvider provider) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) => {
          setState(() {
            provider.handlesColors();
          })
        });
  }
}

insertColors() async {
  if (await dbHelper.isColorsExist()) {
    for (var color in Constants.unlockColors) {
      String colorCode = color.mainColor.value.toRadixString(16);

      await dbHelper.insertColor(ColorTable(
        previousColor: 0,
        colorCode: colorCode,
        selected: 0,
        isLocked: ColorsConst.unLockedColor,
      ));

      for (var dencityColor in color.densityColors) {
        String code = dencityColor.value.toRadixString(16);
        await dbHelper.insertDensityColor(DensityColor(
          previousColor: "0",
          colorCode: code,
          selected: "0",
          parentColorCode: colorCode,
        ));
      }
    }

    for (var color in Constants.lockedColors) {
      String colorCode = color.lmainColor.value.toRadixString(16);

      await dbHelper.insertColor(ColorTable(
        previousColor: 0,
        colorCode: colorCode,
        selected: 1,
        isLocked: ColorsConst.lockedColor,
      ));

      for (var dencityColor in color.ldensityColors) {
        String code = dencityColor.value.toRadixString(16);
        await dbHelper.insertDensityColor(DensityColor(
          previousColor: "0",
          colorCode: code,
          selected: "0",
          parentColorCode: colorCode,
        ));
      }
    }

    String colorCode =
        Constants.unlockColors.first.mainColor.value.toRadixString(16);
    await dbHelper.selectColor(ColorTable(
      previousColor: 0,
      colorCode: colorCode,
      selected: 1,
      isLocked: ColorsConst.unLockedColor,
    ));
  }

  List<ColorTable> selectedColor = await dbHelper.getSelectedColor();

  if (selectedColor.isNotEmpty) {
    ColorTable colorTable = selectedColor.first;

    if (colorTable.isLocked == ColorsConst.lockedColor) {
      await dbHelper.selectColor(ColorTable(
        previousColor: 0,
        colorCode: colorTable.colorCode,
        selected: 1,
        isLocked: ColorsConst.lockedColor,
      ));
      String colorCode =
          Constants.unlockColors.first.mainColor.value.toRadixString(16);
      await dbHelper.selectColor(ColorTable(
        previousColor: 0,
        colorCode: colorCode,
        selected: 0,
        isLocked: ColorsConst.unLockedColor,
      ));
      MyColors.colorPrimary = Constants.unlockColors.first.mainColor;
    } else {
      int code = int.parse("0x" + colorTable.colorCode);
      Color c = Color(code);
      MyColors.colorPrimary = c;
    }
  }
}

Future<void> insertData() async {
  insertDefaultData();

  Dio _dio = Dio();
  try {
    String url =
        "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";
    Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      Map res = response.data!;
      Map<String, dynamic> quotes = res["quotes"];

      quotes.forEach((key, value) async {
        Map<String, dynamic> map = Constants.countryList
            .singleWhere((element) => element["code"] == key, orElse: () {
          print("database data ->$key");

          return {};
        });

        DataModel currencyData = DataModel(
          value: value.toString(),
          code: key,
          image: map["image"],
          name: map["country_name"],
          fav: (key == "USD" ||
                  key == "EUR" ||
                  key == "GBP" ||
                  key == "CAD" ||
                  key == "INR" ||
                  key == "MXN" ||
                  key == "BTC")
              ? 1
              : 0,
          selected: (key == "USD" ||
                  key == "EUR" ||
                  key == "GBP" ||
                  key == "CAD" ||
                  key == "INR" ||
                  key == "MXN")
              ? 1
              : 0,
          symbol: map["Symbol"],
          itemIndex: (key.length + 1),
        );
        int id = await dbHelper.insert(currencyData.toMap());
      });
    } else {
      print("NOT FOUND DATA");
    }
  } catch (e) {
    print(e);
  }
}

Future insertDefaultData() async {
  bool firstTime = await Utility.getBooleanPreference("firstTime");

  if (!firstTime) {
    DataModel currencyUSD = DataModel(
        value: "0",
        code: "USD",
        image: "assets/pngCountryImages/USD.png",
        name: "United States Dollar",
        fav: 1,
        selected: 1,
        symbol: "\$",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 1);
    await dbHelper.insert(currencyUSD.toMap());

    DataModel currencyEUR = DataModel(
        value: "0",
        code: "EUR",
        image: "assets/pngCountryImages/EUR.png",
        name: "Euro",
        fav: 1,
        selected: 1,
        symbol: "???",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 2);
    await dbHelper.insert(currencyEUR.toMap());

    DataModel currencyGBP = DataModel(
        value: "0",
        code: "GBP",
        image: "assets/pngCountryImages/GBP.png",
        name: "British Pound Sterling",
        fav: 1,
        selected: 1,
        symbol: "??",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 3);
    await dbHelper.insert(currencyGBP.toMap());

    DataModel currencyCAD = DataModel(
        value: "0",
        code: "CAD",
        image: "assets/pngCountryImages/CAD.png",
        name: "Canadian Dollar",
        fav: 1,
        selected: 1,
        symbol: "Can\$",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 4);
    await dbHelper.insert(currencyCAD.toMap());

    DataModel currencyINR = DataModel(
        value: "0",
        code: "INR",
        image: "assets/pngCountryImages/INR.png",
        name: "Indian Rupee",
        fav: 1,
        selected: 1,
        symbol: "???",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 5);
    await dbHelper.insert(currencyINR.toMap());

    DataModel currencyMXN = DataModel(
        value: "0",
        code: "MXN",
        image: "assets/pngCountryImages/MXN.png",
        name: "Mexican Peso",
        fav: 1,
        selected: 1,
        symbol: "Mex\$",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        itemIndex: 5);
    await dbHelper.insert(currencyMXN.toMap());

    await Utility.setBooleanPreference("firstTime", true);
  }
}

insertion() async {
  MyColors.displaycode =
      await Utility.getBoolDisplayCodePreference(Constants.SELECTED_CODE);

  MyColors.muliConverter =
      await Utility.getMulticonverter(Constants.MultiConverter);

  MyColors.displayflag =
      await Utility.getBoolDisplayflagPreference(Constants.SELECTED_FLAG);
  MyColors.displaysymbol =
      await Utility.getBoolDisplaysymbolPreference(Constants.SELECTED_SYMBOL);

  String monetary = await Utility.getStringPreference(Constants.monetaryFormat);
  String decimal = await Utility.getStringPreference(Constants.decimalFormat);
  monetary = monetary == "" ? "1" : monetary;
  decimal = decimal == "" ? "2" : decimal;
  MyColors.monetaryFormat = int.parse(monetary);
  MyColors.decimalFormat = int.parse(decimal);
}
