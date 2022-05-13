import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/color_picker/color_picker_dialog.dart';
import 'package:currency_converter/in_app_parchase/product_provider.dart';
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
import 'package:provider/provider.dart';

import 'home/home_page.dart';

class SettingScreen extends StatefulWidget {
  final Function onThemeChange;

  const SettingScreen(this.onThemeChange, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with WidgetsBindingObserver {
  bool lockedcolortry = false;
  bool _isContainerVisible = false;
  Color unlockCurrentColor = MyColors.colorPrimary;
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityCurrentColor = MyColors.colorPrimary;
  ScrollController scrollController = ScrollController();
  List<ListTile> productList = <ListTile>[];
  double _value = 0.0;
  bool removeAd = false;
  late InAppProvider _appProvider;

  @override
  void initState() {
    final provider = Provider.of<InAppProvider>(context, listen: false);
    _appProvider = provider;
    _appProvider.initPlatformState();
    if (Constants.isPurchase == "[]") {
      Constants.removeAd = false;
    } else {
      Constants.removeAd = true;
    }
    getSetting();
    super.initState();
  }

  getSetting() async {
    String value = await Utility.getStringPreference(Constants.widgetTransparent);
    if (value.isEmpty) {
      value = "0";
    }
    _value = int.parse(value) / 100;
    setState(() {});
  }

  @override
  void dispose() {
    _appProvider.conectionSubscription.cancel();
    _appProvider.purchaseUpdatedSubscription.cancel();
    _appProvider.purchaseErrorSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InAppProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (_isContainerVisible) {
          Future.value(_isContainerVisible = false);
          if (mounted) setState(() {});
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
                          style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  Container(
                    // margin: EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 20),
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
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
                                      fontFamily: GoogleFonts.roboto().fontFamily,
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
                            inactiveTrackColor: !MyColors.isDarkMode ? Colors.grey.shade300 : MyColors.colorPrimary,
                            inactiveThumbColor: MyColors.textColor,
                            value: Constants.removeAd,
                            onChanged: (value) async {
                              if (Constants.isPurchase == "[]") {
                                Constants.removeAd = value;
                                if (Constants.removeAd) {
                                  await provider.getSubscriptions(provider.productLists);
                                  String getSubscription = provider.getSubscriptionItems
                                      .map((subItem) async => await provider.requestSubscription(subItem.productId!))
                                      .toString();
                                }
                              }
                              setState(() {});
                            },
                            activeTrackColor:
                                !MyColors.isDarkMode ? MyColors.colorPrimary : const Color(0xff333333).withOpacity(0.507),
                            activeColor: MyColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                      child: Text("cpv_select".tr().toString() + " " + "language".tr(),
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
                            scrollController.position.maxScrollExtent - (scrollController.position.maxScrollExtent / 1.65),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      }

                      setState(() {});
                    },
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 10, bottom: 14),
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("iso".tr().toString(),
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(fontSize: 16, color: MyColors.textColor, fontWeight: FontWeight.w500)),

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
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.8),
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
                          margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("color_selection".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  InkWell(
                    onTap: () async {
                      MyColors.eyeIconSetup = true;
                      setState(() {});
                      await showColorPickerDialog(context);
                    },
                    child: _isContainerVisible
                        ? Container()
                        : MediaQuery(
                            data: MediaQuery.of(context).copyWith(textScaleFactor: Constants.textScaleFactor),
                            child: Container(
                                // margin: EdgeInsets.only(right: 22),
                                height: 50,
                                width: width * .95,
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
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
                                    border: Border.all(width: 1.2, color: MyColors.textColor),
                                  ),
                                  child: Text(
                                    "",
                                    textScaleFactor: Constants.textScaleFactor,
                                  ),
                                )),
                          ),
                  ),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("theme".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          height: 45,
                          padding: const EdgeInsets.only(top: 0, left: 0, right: 15, bottom: 0),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (MyColors.isDarkMode) {
                                        MyColors.isDarkMode = false;

                                        // MyColors.darkModeCheck = !MyColors.darkModeCheck;
                                        MyColors.textColor = Colors.white;
                                        MyColors.insideTextFieldColor = const Color(0xff333333);
                                        MyColors.calcuColor = MyColors.colorPrimary;
                                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                          systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                                          systemNavigationBarIconBrightness: Brightness.light,
                                          statusBarColor: MyColors.colorPrimary, // status bar color
                                        ));

                                        await Utility.setBooleanPreference(
                                          Constants.isDarkMode,
                                          false,
                                        );
                                        Utility.notifyThemeChange();
                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: !MyColors.isDarkMode
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("light".tr().toString(),
                                      textScaleFactor: Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: MyColors.textColor,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (!MyColors.isDarkMode) {
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

                                        await Utility.setBooleanPreference(
                                          Constants.isDarkMode,
                                          true,
                                        );
                                        Utility.notifyThemeChange();
                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: MyColors.isDarkMode
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "dark".tr().toString(),
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor),
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
                                  style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(top: 10, left: 0, right: 8, bottom: 10),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
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
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                  ),
                                  child: Slider(
                                      activeColor: MyColors.textColor,
                                      inactiveColor: MyColors.textColor.withOpacity(0.7),
                                      min: 0,
                                      max: 1,
                                      value: _value,
                                      onChanged: (value) async {
                                        setState(() {
                                          _value = value;
                                        });

                                        String t = (_value * 100).toInt().toString();

                                        debugPrint("widgetTransparent-->$t");
                                        await Utility.setStringPreference(Constants.widgetTransparent, t);
                                        Utility.notifyThemeChange();
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 28,
                                child: Text(
                                  (_value * 100).toStringAsFixed(0),
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
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white60,
                                              MyColors.colorPrimary,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            //stops: const [0.0, 0.0]
                                          ),
                                          border: Border.all(color: MyColors.textColor, width: 3.9)),
                                      child: _isContainerVisible
                                          ? Container()
                                          : Container(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              color: MyColors.textColor.withOpacity(_value),
                                              child: AnimatedOpacity(
                                                duration: const Duration(milliseconds: 700),
                                                opacity: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(right: 10),
                                                                width: 30,
                                                                height: 30,
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    child: Image.asset(
                                                                      "assets/pngCountryImages/USD.png",
                                                                      fit: BoxFit.cover,
                                                                    ))),
                                                            Text(
                                                              "USD",
                                                              textScaleFactor: Constants.textScaleFactor,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 16,
                                                                  color: MyColors.textColor,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "/",
                                                          textScaleFactor: Constants.textScaleFactor,
                                                          style: GoogleFonts.roboto(
                                                              fontSize: 16, color: MyColors.textColor, fontWeight: FontWeight.w600),
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(right: 10),
                                                                width: 30,
                                                                height: 30,
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    child: Image.asset(
                                                                      "assets/pngCountryImages/EUR.png",
                                                                      fit: BoxFit.cover,
                                                                    ))),
                                                            Text(
                                                              "EUR",
                                                              textScaleFactor: Constants.textScaleFactor,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 16,
                                                                  color: MyColors.textColor,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    _isContainerVisible
                                                        ? Container()
                                                        : Padding(
                                                            padding: const EdgeInsets.only(left: 50, top: 0),
                                                            child: Text("0.7895",
                                                                textScaleFactor: Constants.textScaleFactor,
                                                                style: TextStyle(
                                                                  color: MyColors.textColor,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 19,
                                                                )),
                                                          ),
                                                    const SizedBox(height: 5),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 80, top: 0),
                                                      child: Text("-0.0400",
                                                          textScaleFactor: Constants.textScaleFactor,
                                                          style: TextStyle(
                                                            color: MyColors.textColor,
                                                            fontSize: 15,
                                                          )),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      margin: const EdgeInsets.only(left: 5),
                                                      child: Text("by_currency_wiki".tr().toString(),
                                                          textScaleFactor: Constants.textScaleFactor,
                                                          style: GoogleFonts.roboto(
                                                            color: MyColors.textColor,
                                                            fontWeight: FontWeight.normal,
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
                          margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("visual_size".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          //  margin: EdgeInsets.only(right: 22),
                          height: 50,
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (Constants.selectedFontSize != Constants.fontSmall) {
                                    Constants.selectedFontSize = Constants.fontSmall;
                                    Constants.textScaleFactor = 0.9;
                                    await Utility.setStringPreference(Constants.fontSize, Constants.fontSmall);
                                  }
                                  setState(() {});
                                },
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize == Constants.fontSmall
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("A",
                                        textScaleFactor: 0.85,
                                        style:
                                            GoogleFonts.roboto(fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (Constants.selectedFontSize != Constants.fontMedium) {
                                    Constants.selectedFontSize = Constants.fontMedium;
                                    await Utility.setStringPreference(Constants.fontSize, Constants.fontMedium);
                                    Constants.textScaleFactor = .95;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize == Constants.fontMedium
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 18.5,
                                            height: 18.5,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 18.5,
                                            height: 18.5,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "A",
                                      textScaleFactor: 0.9,
                                      style:
                                          GoogleFonts.roboto(fontSize: 18.5, color: MyColors.textColor, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  if (Constants.selectedFontSize != Constants.fontLarge) {
                                    Constants.selectedFontSize = Constants.fontLarge;
                                    await Utility.setStringPreference(Constants.fontSize, Constants.fontLarge);
                                    Constants.textScaleFactor = 1;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Constants.selectedFontSize == Constants.fontLarge
                                        ? SvgPicture.asset(
                                            "assets/images/check-round.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "A",
                                      textScaleFactor: 1,
                                      style:
                                          GoogleFonts.roboto(fontSize: 19.7, color: MyColors.textColor, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(left: 0, bottom: 5, top: 25),
                          child: Text("when_opening_app".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: const EdgeInsets.only(top: 15, left: 15, right: 20, bottom: 15),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 5, left: 2),
                                      child: Text("display_multi_converter".tr().toString(),
                                          textScaleFactor: Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    margin: const EdgeInsets.only(top: 2, left: 0),
                                    child: Switch(
                                      inactiveThumbColor: MyColors.textColor,
                                      activeTrackColor:
                                          !MyColors.isDarkMode ? MyColors.colorPrimary : const Color(0xff333333).withOpacity(0.507),
                                      inactiveTrackColor: MyColors.isDarkMode ? MyColors.colorPrimary : Colors.grey.shade300,
                                      activeColor: MyColors.textColor,
                                      value: MyColors.muliConverter,
                                      onChanged: (value) {
                                        setState(() {
                                          MyColors.muliConverter = value;
                                          Utility.setMulticonverter(Constants.MultiConverter, MyColors.muliConverter);
                                        });
                                      },
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
                                      textScaleFactor: Constants.textScaleFactor,
                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 9, color: MyColors.textColor),
                                    ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(left: 0, bottom: 5, top: 25),
                          child: Text("dislay".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: EdgeInsets.only(top: 0, left: 15, right: 5, bottom: 5),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(

                                  //   padding: EdgeInsets.only(top: 12),
                                  //   child: Expanded(
                                  //     child: AutoSizeText(
                                  //         "display_currency_code"
                                  //             .tr()
                                  //             .toString(),
                                  //         textScaleFactor:
                                  //             Constants.textScaleFactor,
                                  //         maxLines: 2,
                                  //         softWrap: true,
                                  //         style: GoogleFonts.roboto(
                                  //             fontSize: 17,
                                  //             color: MyColors.textColor,
                                  //             fontWeight: FontWeight.normal)),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: RichText(
                                          textScaleFactor: Constants.textScaleFactor,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "display_currency_code".tr().toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.normal)),
                                          ])),
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.isDarkMode ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaycode,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaysymbol) {
                                            MyColors.displaysymbol = false;
                                            MyColors.displaycode = true;
                                          } else {
                                            MyColors.displaycode = !MyColors.displaycode;
                                          }
                                        } else if (MyColors.displaycode) {
                                        } else {
                                          MyColors.displaycode = true;
                                          MyColors.displaysymbol = false;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(Constants.SELECTED_CODE, MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(Constants.SELECTED_FLAG, MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(Constants.SELECTED_SYMBOL, MyColors.displaysymbol);
                                    },
                                    activeTrackColor:
                                        !MyColors.isDarkMode ? MyColors.colorPrimary : const Color(0xff333333).withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.only(top: 12),
                                  //   child: AutoSizeText(
                                  //     "display_currency_symbol".tr().toString(),
                                  //     textScaleFactor:
                                  //         Constants.textScaleFactor,
                                  //     maxLines: 2,
                                  //     softWrap: true,
                                  //     style: GoogleFonts.roboto(
                                  //         color: MyColors.textColor,
                                  //         fontWeight: FontWeight.normal,
                                  //         fontSize: 17),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: RichText(
                                          textScaleFactor: Constants.textScaleFactor,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "display_currency_symbol".tr().toString(),
                                                style: GoogleFonts.roboto(
                                                    color: MyColors.textColor, fontWeight: FontWeight.normal, fontSize: 17)),
                                          ])),
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.isDarkMode ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaysymbol,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaycode) {
                                            MyColors.displaysymbol = true;
                                            MyColors.displaycode = false;
                                          } else {
                                            MyColors.displaysymbol = !MyColors.displaysymbol;
                                          }
                                        } else if (MyColors.displaysymbol) {
                                        } else if (MyColors.displaysymbol && !MyColors.displayflag) {
                                        } else {
                                          MyColors.displaysymbol = true;
                                          MyColors.displaycode = false;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(Constants.SELECTED_CODE, MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(Constants.SELECTED_FLAG, MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(Constants.SELECTED_SYMBOL, MyColors.displaysymbol);
                                    },
                                    activeTrackColor:
                                        !MyColors.isDarkMode ? MyColors.colorPrimary : const Color(0xff333333).withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   padding: const EdgeInsets.only(top: 12),
                                  //   child: AutoSizeText(
                                  //       "display_currency_flag".tr().toString(),
                                  //       maxLines: 2,
                                  //       softWrap: true,
                                  //       textScaleFactor:
                                  //           Constants.textScaleFactor,
                                  //       style: GoogleFonts.roboto(
                                  //           fontSize: 17,
                                  //           color: MyColors.textColor,
                                  //           fontWeight: FontWeight.normal)),
                                  // ),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: RichText(
                                          textScaleFactor: Constants.textScaleFactor,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "display_currency_flag".tr().toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.normal)),
                                          ])),
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.isDarkMode ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displayflag,
                                    onChanged: (value) {
                                      setState(() {
                                        if (!MyColors.displaycode && !MyColors.displaysymbol) {
                                        } else {
                                          MyColors.displayflag = !MyColors.displayflag;
                                        }
                                      });
                                      Utility.setBoolDisplayCodePreference(Constants.SELECTED_CODE, MyColors.displaycode);
                                      Utility.setBoolDisplayflagPreference(Constants.SELECTED_FLAG, MyColors.displayflag);
                                      Utility.setBoolDisplaysymbolPreference(Constants.SELECTED_SYMBOL, MyColors.displaysymbol);
                                    },
                                    activeTrackColor:
                                        !MyColors.isDarkMode ? MyColors.colorPrimary : const Color(0xff333333).withOpacity(0.507),
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("date_format".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          height: 55,
                          width: width * .945,
                          padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (Constants.dateFormat != Constants.mmDdYyyy) {
                                    Constants.dateFormat = Constants.mmDdYyyy;
                                    await Utility.setStringPreference(Constants.DATE_FROMAT, Constants.dateFormat);
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
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "mm/dd/yy",
                                      textScaleFactor: Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(fontSize: 16, color: MyColors.textColor),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (Constants.dateFormat != Constants.ddMmYyyy) {
                                    Constants.dateFormat = Constants.ddMmYyyy;
                                    await Utility.setStringPreference(Constants.DATE_FROMAT, Constants.dateFormat);
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
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/check-blank.svg",
                                            width: 19.7,
                                            height: 19.7,
                                            fit: BoxFit.fill,
                                            color: MyColors.isDarkMode ? const Color(0xff333333) : Colors.white,
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("dd/mm/yy",
                                        textScaleFactor: Constants.textScaleFactor,
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

  void unlockChangeColor(Color color) {
    var code = (color.value.toRadixString(16));
    MyColors.colorPrimary = Color(int.parse("0x$code"));

    setState(
      () => unlockCurrentColor = color,
    );
    debugPrint("unlock in behja -> ${unlockCurrentColor.value.toRadixString(16)}");
  }

  void lockChangeColor(Color color) {
    widget.onThemeChange;
    setState(() => lockCurrentColor = color);
    debugPrint("selected color c -> ${lockCurrentColor.value.toRadixString(16)}");
  }

  void densityChangeColor(Color color) {
    widget.onThemeChange;
    setState(() => densityCurrentColor = color);

    debugPrint("selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  void onColorSelect(Color themeColor, BuildContext context) {
    debugPrint("OnColorSelect-->");
    widget.onThemeChange;

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MyTabBarWidget()), (route) => false);
  }

  showColorPickerDialog(BuildContext context) async {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Center(
              child: IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, bottom: 0, left: 10),
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
