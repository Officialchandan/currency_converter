import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/color_picker/color_picker_dialog.dart';
import 'package:currency_converter/in_app_parchase/consumable_store.dart';
import 'package:currency_converter/language/language.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'home/home_page.dart';

const bool _kAutoConsume = true;

const String _kUpgradeId = 'currency.app_unlock_color';
const String _kSilverSubscriptionId = 'currency.app_no_ads';
const List<String> _kProductIds = <String>[
  _kUpgradeId,
  _kSilverSubscriptionId,
];

class SettingScreen extends StatefulWidget {
  final Function onThemeChange;

  const SettingScreen(this.onThemeChange, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockedcolortry = false;
  bool _isContainerVisible = false;
  Color unlockCurrentColor = MyColors.colorPrimary;
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityCurrentColor = MyColors.colorPrimary;
  ScrollController scrollController = ScrollController();
  double _value = 0.0;
  double x = 0.0;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ListTile> productList = <ListTile>[];

  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (_isContainerVisible) {
          Future.value(_isContainerVisible = false);
          setState(() {});
        } else {
          SystemNavigator.pop();
          return true;
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: width,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 13),
                      child: Text("remove_ads".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: MyColors.textColor,
                              fontWeight: FontWeight.bold))),
                  Container(
                    // margin: EdgeInsets.only(right: 20),

                    padding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RichText(
                              textScaleFactor: Constants.textScaleFactor,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "sub_remove_ads".tr().toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.roboto().fontFamily,
                                      fontSize: 15,
                                      color: MyColors.textColor),
                                ),
                              ])),
                        ),
                        Container(
                          width: 30,
                          height: 10,
                          margin: const EdgeInsets.all(5),
                          child: Switch(
                            inactiveTrackColor: MyColors.darkModeCheck
                                ? MyColors.colorPrimary
                                : Colors.grey.shade300,
                            inactiveThumbColor: MyColors.textColor,
                            value: MyColors.removeAd,
                            onChanged: (value) async {
                              setState(() {
                                MyColors.removeAd = value;

                                Utility.setMulticonverter(
                                    Constants.REMOVE_AD, MyColors.removeAd);
                              });
                              if (MyColors.removeAd == true) {
                                Map<String, PurchaseDetails> purchases =
                                    Map.fromEntries(_purchases
                                        .map((PurchaseDetails purchase) {
                                  if (purchase.pendingCompletePurchase) {
                                    _inAppPurchase.completePurchase(purchase);
                                  }
                                  return MapEntry<String, PurchaseDetails>(
                                      purchase.productID, purchase);
                                }));

                                productList.addAll(_products
                                    .map((ProductDetails productDetails) {
                                  PurchaseDetails? previousPurchase =
                                      purchases[productDetails.id];

                                  Utility.setMulticonverter(
                                      Constants.REMOVE_AD, MyColors.removeAd);

                                  if (previousPurchase != null) {
                                    MyColors.removeAd = value;
                                    confirmPriceChange(context);
                                  } else {
                                    late PurchaseParam purchaseParam;

                                    if (Platform.isAndroid) {
                                      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                                      // verify the latest status of you your subscription by using server side receipt validation
                                      // and update the UI accordingly. The subscription purchase status shown
                                      // inside the app may not be accurate.
                                      final oldSubscription =
                                          _getOldSubscription(
                                              productDetails, purchases);

                                      purchaseParam = GooglePlayPurchaseParam(
                                          productDetails: productDetails,
                                          applicationUserName: null,
                                          changeSubscriptionParam:
                                              (oldSubscription != null)
                                                  ? ChangeSubscriptionParam(
                                                      oldPurchaseDetails:
                                                          oldSubscription,
                                                      prorationMode: ProrationMode
                                                          .immediateWithTimeProration,
                                                    )
                                                  : null);
                                    } else {
                                      purchaseParam = PurchaseParam(
                                        productDetails: productDetails,
                                        applicationUserName: null,
                                      );
                                    }

                                    if (productDetails.id == _kUpgradeId) {
                                      _inAppPurchase.buyConsumable(
                                          purchaseParam: purchaseParam,
                                          autoConsume:
                                              _kAutoConsume || Platform.isIOS);
                                    } else {
                                      _inAppPurchase.buyNonConsumable(
                                          purchaseParam: purchaseParam);
                                    }
                                  }
                                  return const ListTile();
                                }));
                              }
                            },
                            activeTrackColor: MyColors.lightModeCheck
                                ? MyColors.colorPrimary
                                : const Color(0xff333333).withOpacity(0.507),
                            activeColor: MyColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                      child: Text(
                          "cpv_select".tr().toString() + " " + "language".tr(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold,
                          ))),
                  InkWell(
                    onTap: () {
                      _isContainerVisible = !_isContainerVisible;

                      if (_isContainerVisible) {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent -
                                (scrollController.position.maxScrollExtent /
                                    1.65),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      }

                      setState(() {});
                    },
                    child: Container(

                        // margin: EdgeInsets.only(right: 22),

                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 14),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("iso".tr().toString(),
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: MyColors.textColor,
                                        fontWeight: FontWeight.w500)),

                                //  SizedBox(width: 245 ,),
                                Icon(
                                  Icons.expand_more_outlined,
                                  color: MyColors.textColor,
                                ),
                              ],
                            ),
                            Divider(
                              height: 2,
                              color: MyColors.textColor,
                              thickness: 1.5,
                            )
                          ],
                        )),
                  ),
                  _isContainerVisible
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 13,
                          constraints: const BoxConstraints(),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.8),
                          child: SvgPicture.asset(
                            "assets/images/arrow-top.svg",
                          ),
                        )
                      : Container(),
                  _isContainerVisible
                      ? Language(
                          isContainerVisible: _isContainerVisible,
                        )
                      : Container(),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 0, bottom: 13, top: 20),
                          child: Text("color_selection".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  InkWell(
                    onTap: () async {
                      MyColors.eyeIconSetup = true;
                      await showColorPickerDialog(context);
                    },
                    child: _isContainerVisible
                        ? Container()
                        : Container(
                            // margin: EdgeInsets.only(right: 22),
                            height: 50,
                            width: width * .95,
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.white60,
                                      MyColors.colorPrimary,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: const [0.0, 0.5]),
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    width: 1.2, color: MyColors.textColor),
                              ),
                              child: Text(
                                "",
                                textScaleFactor: Constants.textScaleFactor,
                              ),
                            )),
                  ),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 0, bottom: 13, top: 20),
                          child: Text("theme".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          height: 45,
                          padding: const EdgeInsets.only(
                              top: 0, left: 0, right: 15, bottom: 0),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (!MyColors.lightModeCheck) {
                                        MyColors.lightModeCheck = true;
                                        MyColors.darkModeCheck = false;

                                        // MyColors.darkModeCheck = !MyColors.darkModeCheck;
                                        MyColors.textColor = Colors.white;
                                        MyColors.insideTextFieldColor =
                                            const Color(0xff333333);
                                        MyColors.calcuColor =
                                            MyColors.colorPrimary;
                                        SystemChrome.setSystemUIOverlayStyle(
                                            SystemUiOverlayStyle(
                                          systemNavigationBarColor: MyColors
                                              .colorPrimary, // navigation bar color
                                          systemNavigationBarIconBrightness:
                                              Brightness.light,
                                          statusBarColor: MyColors
                                              .colorPrimary, // status bar color
                                        ));
                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: MyColors.lightModeCheck
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("light".tr().toString(),
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: MyColors.textColor,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (!MyColors.darkModeCheck) {
                                        MyColors.darkModeCheck = true;
                                        MyColors.lightModeCheck = false;

                                        // MyColors.lightModeCheck = !MyColors.lightModeCheck;
                                        MyColors.textColor =
                                            const Color(0xff333333);
                                        MyColors.insideTextFieldColor =
                                            Colors.white;
                                        MyColors.calcuColor =
                                            const Color(0xff333333);

                                        SystemChrome.setSystemUIOverlayStyle(
                                            SystemUiOverlayStyle(
                                          systemNavigationBarColor: MyColors
                                              .colorPrimary, // navigation bar color
                                          systemNavigationBarIconBrightness:
                                              Brightness.dark,
                                          statusBarColor: MyColors
                                              .colorPrimary, // status bar color
                                        ));

                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: MyColors.darkModeCheck
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "dark".tr().toString(),
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: MyColors.textColor),
                                  )
                                ],
                              ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                  right: 5.6,
                                ),
                                child: Text(
                                  "wedget_transparency".tr().toString(),
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold),
                                )),
                            SvgPicture.asset(
                              "assets/images/about-light.svg",
                              height: 21.0,
                              color: MyColors.textColor,
                            ),
                          ],
                        ),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(right: 0, top: 15),
                          width: width * .94,
                          padding: const EdgeInsets.only(
                              top: 10, left: 0, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                width: width * 0.30,
                                child: SliderTheme(
                                  data: const SliderThemeData(
                                    trackHeight: 1.5,
                                    trackShape: RectangularSliderTrackShape(),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 6.0),
                                  ),
                                  child: Slider(
                                      activeColor: MyColors.textColor,
                                      inactiveColor:
                                          MyColors.textColor.withOpacity(0.7),
                                      min: 0,
                                      max: 1,
                                      value: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          x = _value.toDouble();
                                          _value = value;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 28,
                                child: Text(
                                  (x * 100).toStringAsFixed(0),
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              _isContainerVisible
                                  ? Container()
                                  : Container(
                                      width: (width - (width * 0.30)) - 62,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.69),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white60,
                                              MyColors.colorPrimary,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            //stops: const [0.0, 0.0]
                                          ),
                                          border: Border.all(
                                              color: MyColors.textColor,
                                              width: 3.9)),
                                      child: _isContainerVisible
                                          ? Container()
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              color: MyColors.textColor
                                                  .withOpacity((x) as double),
                                              child: AnimatedOpacity(
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                opacity: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                width: 30,
                                                                height: 30,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/pngCountryImages/USD.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ))),
                                                            Text(
                                                              "USD",
                                                              textScaleFactor:
                                                                  Constants
                                                                      .textScaleFactor,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 16,
                                                                  color: MyColors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "/",
                                                          textScaleFactor:
                                                              Constants
                                                                  .textScaleFactor,
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 16,
                                                                  color: MyColors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                width: 30,
                                                                height: 30,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/pngCountryImages/EUR.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ))),
                                                            Text(
                                                              "EUR",
                                                              textScaleFactor:
                                                                  Constants
                                                                      .textScaleFactor,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 16,
                                                                  color: MyColors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    _isContainerVisible
                                                        ? Container()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 50,
                                                                    top: 0),
                                                            child: Text(
                                                                "0.7895",
                                                                textScaleFactor:
                                                                    Constants
                                                                        .textScaleFactor,
                                                                style:
                                                                    TextStyle(
                                                                  color: MyColors
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19,
                                                                )),
                                                          ),
                                                    const SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 80, top: 0),
                                                      child: Text("-0.0400",
                                                          textScaleFactor:
                                                              Constants
                                                                  .textScaleFactor,
                                                          style: TextStyle(
                                                            color: MyColors
                                                                .textColor,
                                                            fontSize: 15,
                                                          )),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                          "by_currency_wiki"
                                                              .tr()
                                                              .toString(),
                                                          textScaleFactor:
                                                              Constants
                                                                  .textScaleFactor,
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: MyColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                            ],
                          ),
                        ),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 0, bottom: 13, top: 20),
                          child: Text("visual_size".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          //  margin: EdgeInsets.only(right: 22),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (Constants.selectedFontSize !=
                                      Constants.fontSmall) {
                                    Constants.selectedFontSize =
                                        Constants.fontSmall;
                                    Constants.textScaleFactor = 0.9;
                                    await Utility.setStringPreference(
                                        Constants.fontSize,
                                        Constants.fontSmall);
                                  }
                                  setState(() {});
                                },
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize ==
                                            Constants.fontSmall
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("A",
                                        textScaleFactor: 0.85,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: MyColors.textColor,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (Constants.selectedFontSize !=
                                      Constants.fontMedium) {
                                    Constants.selectedFontSize =
                                        Constants.fontMedium;
                                    await Utility.setStringPreference(
                                        Constants.fontSize,
                                        Constants.fontMedium);
                                    Constants.textScaleFactor = .95;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize ==
                                            Constants.fontMedium
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 18.5,
                                            height: 18.5,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 18.5,
                                            height: 18.5,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "A",
                                      textScaleFactor: 0.9,
                                      style: GoogleFonts.roboto(
                                          fontSize: 18.5,
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  if (Constants.selectedFontSize !=
                                      Constants.fontLarge) {
                                    Constants.selectedFontSize =
                                        Constants.fontLarge;
                                    await Utility.setStringPreference(
                                        Constants.fontSize,
                                        Constants.fontLarge);
                                    Constants.textScaleFactor = 1;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize ==
                                            Constants.fontLarge
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "A",
                                      textScaleFactor: 1,
                                      style: GoogleFonts.roboto(
                                          fontSize: 19.7,
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 25),
                          child: Text("when_opening_app".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 20, bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(bottom: 5, left: 2),
                                      child: Text(
                                          "display_multi_converter"
                                              .tr()
                                              .toString(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: MyColors.textColor,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                    width: 30,
                                    height: 10,
                                    margin:
                                        const EdgeInsets.only(top: 2, left: 0),
                                    child: Switch(
                                      inactiveThumbColor: MyColors.textColor,
                                      value: MyColors.muliConverter,
                                      onChanged: (value) async {
                                        setState(() {
                                          MyColors.muliConverter = value;
                                          Utility.setMulticonverter(
                                              Constants.MultiConverter,
                                              MyColors.muliConverter);
                                        });
                                      },
                                      activeTrackColor: MyColors.lightModeCheck
                                          ? MyColors.colorPrimary
                                          : const Color(0xff333333)
                                              .withOpacity(0.507),
                                      inactiveTrackColor: MyColors.darkModeCheck
                                          ? MyColors.colorPrimary
                                          : Colors.grey.shade300,
                                      activeColor: MyColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              _isContainerVisible
                                  ? Container()
                                  : AutoSizeText(
                                      "sub_multi_converter".tr().toString(),
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      maxFontSize: 15,
                                      minFontSize: 9,
                                      wrapWords: true,
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 9,
                                          color: MyColors.textColor),
                                    ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 0, bottom: 5, top: 25),
                          child: Text("dislay".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                        "display_currency_code".tr().toString(),
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: MyColors.textColor,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? MyColors.colorPrimary
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaycode,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaysymbol) {
                                            MyColors.displaysymbol = false;
                                            MyColors.displaycode = true;
                                          } else {
                                            MyColors.displaycode =
                                                !MyColors.displaycode;
                                          }
                                        } else if (MyColors.displaycode) {
                                        } else {
                                          MyColors.displaycode = true;
                                          MyColors.displaysymbol = false;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(
                                          Constants.SELECTED_CODE,
                                          MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(
                                          Constants.SELECTED_FLAG,
                                          MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(
                                          Constants.SELECTED_SYMBOL,
                                          MyColors.displaysymbol);
                                    },
                                    activeTrackColor: MyColors.lightModeCheck
                                        ? MyColors.colorPrimary
                                        : const Color(0xff333333)
                                            .withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      "display_currency_symbol".tr().toString(),
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? MyColors.colorPrimary
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaysymbol,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaycode) {
                                            MyColors.displaysymbol = true;
                                            MyColors.displaycode = false;
                                          } else {
                                            MyColors.displaysymbol =
                                                !MyColors.displaysymbol;
                                          }
                                        } else if (MyColors.displaysymbol) {
                                        } else if (MyColors.displaysymbol &&
                                            !MyColors.displayflag) {
                                        } else {
                                          MyColors.displaysymbol = true;
                                          MyColors.displaycode = false;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(
                                          Constants.SELECTED_CODE,
                                          MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(
                                          Constants.SELECTED_FLAG,
                                          MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(
                                          Constants.SELECTED_SYMBOL,
                                          MyColors.displaysymbol);
                                    },
                                    activeTrackColor: MyColors.lightModeCheck
                                        ? MyColors.colorPrimary
                                        : const Color(0xff333333)
                                            .withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                        "display_currency_flag".tr().toString(),
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: MyColors.textColor,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? MyColors.colorPrimary
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displayflag,
                                    onChanged: (value) {
                                      setState(() {
                                        if (!MyColors.displaycode &&
                                            !MyColors.displaysymbol) {
                                        } else {
                                          MyColors.displayflag =
                                              !MyColors.displayflag;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(
                                          Constants.SELECTED_CODE,
                                          MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(
                                          Constants.SELECTED_FLAG,
                                          MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(
                                          Constants.SELECTED_SYMBOL,
                                          MyColors.displaysymbol);
                                    },
                                    activeTrackColor: MyColors.lightModeCheck
                                        ? MyColors.colorPrimary
                                        : const Color(0xff333333)
                                            .withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 0, bottom: 13, top: 20),
                          child: Text("date_format".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          height: 55,
                          width: width * .945,
                          padding: const EdgeInsets.only(
                              top: 0, left: 15, right: 15, bottom: 0),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (Constants.dateFormat !=
                                      Constants.mmDdYyyy) {
                                    Constants.dateFormat = Constants.mmDdYyyy;
                                    await Utility.setStringPreference(
                                        Constants.DATE_FROMAT,
                                        Constants.dateFormat);
                                  }
                                  setState(() {});
                                },
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    Constants.dateFormat == Constants.mmDdYyyy
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "mm/dd/yy",
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: MyColors.textColor),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (Constants.dateFormat !=
                                      Constants.ddMmYyyy) {
                                    Constants.dateFormat = Constants.ddMmYyyy;
                                    await Utility.setStringPreference(
                                        Constants.DATE_FROMAT,
                                        Constants.dateFormat);
                                  }
                                  setState(() {});
                                },
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    Constants.dateFormat == Constants.ddMmYyyy
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.darkModeCheck
                                                ? const Color(0xff333333)
                                                : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("dd/mm/yy",
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: MyColors.textColor,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kUpgradeId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kUpgradeId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      var priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      var iapStoreKitPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
          purchases[_kSilverSubscriptionId] as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
          purchases[_kSilverSubscriptionId] as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  void unlockChangeColor(Color color) {
    var code = (color.value.toRadixString(16));
    MyColors.colorPrimary = Color(int.parse("0x$code"));

    setState(
      () => unlockCurrentColor = color,
    );
    debugPrint(
        "unlock in behja -> ${unlockCurrentColor.value.toRadixString(16)}");
  }

  void lockChangeColor(Color color) {
    widget.onThemeChange;
    setState(() => lockCurrentColor = color);
    debugPrint("selected color -> ${lockCurrentColor.value.toRadixString(16)}");
  }

  void densityChangeColor(Color color) {
    widget.onThemeChange;
    setState(() => densityCurrentColor = color);

    debugPrint(
        "selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  void onColorSelect(Color themeColor, BuildContext context) {
    print("OnColorSelect-->");
    widget.onThemeChange;

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => MyTabBarWidget()), (route) => false);
  }

  showColorPickerDialog(BuildContext context) async {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Center(
              child: IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 15, right: 10, bottom: 0, left: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ColorPickerDialog(
                    isLockedColor: lockedcolortry,
                    onColorSelect: onColorSelect,
                    densitychangeColor: densityChangeColor,
                    lockchangeColor: lockChangeColor,
                    unlockchangeColor: unlockChangeColor,
                    densityCurrentColor: densityCurrentColor,
                    lockCurrentColor: lockCurrentColor,
                    unlockCurrentColor: unlockCurrentColor,
                    isUnlockColorSelect: lockedcolortry,
                    onThemeChange: widget.onThemeChange,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class MColor {
  Color mainColor;
  List<Color> densityColors;

  MColor({required this.mainColor, required this.densityColors});
}

class LColor {
  Color lmainColor;
  List<Color> ldensityColors;

  LColor({required this.lmainColor, required this.ldensityColors});
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
