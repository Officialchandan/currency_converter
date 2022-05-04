import 'package:currency_converter/google_admob/ad_helper.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddScreenWidget extends StatefulWidget {
  const AddScreenWidget({Key? key}) : super(key: key);
  @override
  _AddScreenWidget createState() => _AddScreenWidget();
}

class _AddScreenWidget extends State<AddScreenWidget> {
  late BannerAd _bannerAd;
  bool isBannerAdReady = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (Constants.isPurchase == "[]") {
      addMob();
    }
  }

  void addMob() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
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

    _bannerAd.load();
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
    if (Constants.isPurchase == "[]") {
      _bannerAd.dispose();
    }
    super.dispose();
  }
}
