import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/google_admob/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/constants.dart';

class AddScreenWidget extends StatefulWidget {
  const AddScreenWidget({Key? key}) : super(key: key);
  @override
  _AddScreenWidget createState() => _AddScreenWidget();
}

class _AddScreenWidget extends State<AddScreenWidget> {
  BannerAd? _bannerAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();
  bool isBannerAdReady = false;
  DateTime? dayTimeNow;
  DateTime? yearCheckTime;
  @override
  void initState() {
    log("AddScreenWidget--->");
    init();
    super.initState();
  }

  void init() async {
    if (!Constants.getAppPurchase) {
      addMob();
    }
    setState(() {});
  }

  void addMob() {
    try {
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
            debugPrint('Failed to load a banner ad: ${err.message}');
            isBannerAdReady = false;
            ad.dispose();
          },
        ),
      );
      Future<void>.delayed(const Duration(seconds: 1), () => _bannerAd!.load());
    } catch (e) {
      debugPrint('E=----$e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdReady
        ? SizedBox(
            height: _bannerAd!.size.height.toDouble(),
            width: _bannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : const SizedBox(
            height: 0.0,
            width: 0.0,
          );
  }

  @override
  void dispose() {
    if (!Constants.getAppPurchase) {
      _bannerAd!.dispose();
    }
    super.dispose();
  }
}
