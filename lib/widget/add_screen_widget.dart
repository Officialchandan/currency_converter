import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/google_admob/ad_helper.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddScreenWidget extends StatefulWidget {
  const AddScreenWidget({Key? key}) : super(key: key);
  @override
  _AddScreenWidget createState() => _AddScreenWidget();
}

class _AddScreenWidget extends State<AddScreenWidget> {
  late BannerAd _bannerAd;
  late NativeAd? _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();
  bool isBannerAdReady = false;
  DateTime? dayTimeNow;
  DateTime? yearCheckTime;
  bool getAppPurchase = false;
  @override
  void initState() {
    log("AddScreenWidget--->");
    initAds();
    super.initState();
  }

  void initAds() async {
    Constants.isPurchaseOfAds =
        await Utility.getIntPreference(Constants.yearCheckTimeCons);
    print('isPurchaseOfAds->${Constants.isPurchaseOfAds}');

    if (Constants.isPurchaseOfAds == 0) {
      await Utility.setBooleanPreference(
          Constants.checkWidgetPurchaseAds, false);
    } else {
      DateTime purchaseTime =
          DateTime.fromMillisecondsSinceEpoch(Constants.isPurchaseOfAds);
      DateTime timeNow = DateTime.now();
      DateTime dayTimeNow = DateTime(timeNow.year, timeNow.month, timeNow.day);
      DateTime yearCheckTime = DateTime(
          purchaseTime.year, purchaseTime.month, purchaseTime.day + 365);
      if (dayTimeNow.microsecond <= yearCheckTime.microsecond) {
        print("dayTimeNowdayTimeNow");
        getAppPurchase = await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, true);
      } else {
        print("falseFalseFalse");
        getAppPurchase = await Utility.setBooleanPreference(
            Constants.checkWidgetPurchaseAds, false);
        addMob();
      }
    }
  }

  void addMob() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          log("onAdLoaded--->");
          setState(() {
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    Future<void>.delayed(const Duration(seconds: 1), () => _bannerAd.load());
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdReady
        ? SizedBox(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : const SizedBox(
            height: 0.0,
            width: 0.0,
          );
  }

  @override
  void dispose() {
    if (!getAppPurchase) {
      _bannerAd.dispose();
    }
    super.dispose();
  }
}
