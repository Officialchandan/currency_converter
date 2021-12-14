import 'dart:io';

import 'package:flutter_admob_app_open/ad_request_app_open.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3096560792937908/8528078048';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static getOpenAdd() async {
    const appAppOpenAdUnitId = "ca-app-pub-3096560792937908/2624180523";
    AdRequestAppOpen targetingInfo = const AdRequestAppOpen(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      nonPersonalizedAds: false,
    );
    print("hello Addhelper");

    await FlutterAdmobAppOpen.instance.initialize(
      appAppOpenAdUnitId: appAppOpenAdUnitId,
      targetingInfo: targetingInfo,
    );
  }
}
