import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/google_admob/ad_helper.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({Key? key}) : super(key: key);

  @override
  _BannerAddWidgetState createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  BannerAd? _bannerAd;
  bool isBannerAdReady = false;
  DateTime? dayTimeNow;
  DateTime? yearCheckTime;
  bool getAppPurchase = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    getAppPurchase =
        await Utility.getBooleanPreference(Constants.checkWidgetPurchaseAds);
    if (!Constants.getAppPurchase) {
      addMobMulticonverter();
    }
  }

  Future<void> addMobMulticonverter() async {
    try {
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Failed to load a banner ad: ${err.message}');
            isBannerAdReady = false;
            setState(() {});
            ad.dispose();
          },
        ),
      );

      _bannerAd!.load();
    } catch (e) {
      debugPrint('e----$e');
    }
  }

  @override
  void dispose() {
    if (!Constants.getAppPurchase) {
      _bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdReady
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: _bannerAd!.size.height.toDouble(),
            color: MyColors.colorPrimary,
            child: SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          )
        : const SizedBox(
            width: 0,
            height: 0,
          );
  }
}
