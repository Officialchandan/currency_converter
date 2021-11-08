import 'dart:ui';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/language/language.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors_properties/customcolorpicker.dart';
import '../colors_properties/densitycolorpicker.dart';
import '../colors_properties/lockcolorpicker.dart';
import '../colors_properties/unlockcolorpicker.dart';
import 'home/home_page.dart';

class SettingScreen extends StatefulWidget {
  final Function onThemeChange;

  const SettingScreen(this.onThemeChange, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockedcolortry = false;
  bool unclockcolorselect = false;
  Color color = Colors.red;
  bool _isContainerVisible = false;
  bool isSwitched = false;
  bool isMultiConverter = true;
  bool customcolorbool = false;
  Color unlockCurrentColor = MyColors.colorPrimary;
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityCurrentColor = MyColors.colorPrimary;
  ScrollController scrollController = ScrollController();
  double _value = 0.0;
  double x = 0.0;

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
                      child: Text("removeAds".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: MyColors.textColor,
                              fontWeight: FontWeight.w600))),
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
                                  text: "removeAdsContent".tr().toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
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
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                            inactiveThumbColor: MyColors.textColor,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                // print(isSwitched);
                              });
                            },
                            activeTrackColor: MyColors.colorPrimary,
                            activeColor: MyColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                      child: Text("selectLanguage".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.w700,
                          ))),
                  InkWell(
                    onTap: () {
                      _isContainerVisible = !_isContainerVisible;

                      if (_isContainerVisible) {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent -
                                (scrollController.position.maxScrollExtent /
                                    1.65),
                            duration: Duration(milliseconds: 500),
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
                                Text("english".tr().toString(),
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
                          child: Image.asset(
                            "assets/images/tooltip.png",
                            color: Colors.white,
                            scale: 9,
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
                          child: Text("colorsSelection".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  InkWell(
                    onTap: () async {
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1,
                                    child: Checkbox(
                                      side:
                                          BorderSide(color: MyColors.textColor),
                                      value: MyColors.lightModeCheck,
                                      onChanged: (value) {
                                        setState(() {
                                          if (MyColors.darkModeCheck) {
                                            MyColors.lightModeCheck =
                                                !MyColors.lightModeCheck;
                                            MyColors.darkModeCheck =
                                                !MyColors.darkModeCheck;
                                            MyColors.textColor = Colors.white;
                                            MyColors.insideTextFieldColor =
                                                Colors.black;
                                            MyColors.calcuColor =
                                                  MyColors.colorPrimary;
                                            SystemChrome.setSystemUIOverlayStyle(
                                                 SystemUiOverlayStyle(
                                                  statusBarColor: MyColors.colorPrimary,
                                                  systemNavigationBarColor: MyColors.colorPrimary,
                                                   statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                                                   systemNavigationBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,

                                                ));

                                            widget.onThemeChange();
                                          }
                                        });
                                      },
                                      activeColor: MyColors.darkModeCheck
                                          ? Colors.black45
                                          : Colors.white,
                                      checkColor: Colors.black,
                                      tristate: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
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
                              _isContainerVisible
                                  ? Container()
                                  : Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1,
                                          child: Checkbox(
                                            side: BorderSide(
                                                color: MyColors.textColor),
                                            value: MyColors.darkModeCheck,
                                            onChanged: (value) {
                                              setState(() {
                                                if (MyColors.lightModeCheck) {
                                                  MyColors.darkModeCheck =
                                                      !MyColors.darkModeCheck;
                                                  MyColors.lightModeCheck =
                                                      !MyColors.lightModeCheck;
                                                  MyColors.textColor =
                                                      Color(0xff333333);
                                                  MyColors.insideTextFieldColor =
                                                      Colors.white;
                                                  MyColors.calcuColor =
                                                      Colors.grey.shade700;
                                                  SystemChrome.setSystemUIOverlayStyle(
                                                      SystemUiOverlayStyle(
                                                        statusBarColor: MyColors.colorPrimary,
                                                        systemNavigationBarColor: MyColors.colorPrimary,
                                                        statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                                                        systemNavigationBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,

                                                      ));




                                                  widget.onThemeChange();
                                                }
                                              });
                                            },
                                            activeColor: MyColors.darkModeCheck
                                                ? Colors.black45
                                                : Colors.white,
                                            checkColor: Colors.black,
                                            tristate: false,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        Text(
                                          "dark".tr().toString(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: MyColors.textColor),
                                        ),
                                      ],
                                    )
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                  right: 15,
                                ),
                                child: Text(
                                  "widgetTransparency".tr().toString(),
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold),
                                )),
                            Image.asset(
                              "assets/images/tab-ic5.png",
                              scale: 9 + Constants.textScaleFactor,
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
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              color: MyColors.textColor
                                                  .withOpacity((x) as double),
                                              child: AnimatedOpacity(
                                                duration:
                                                    Duration(milliseconds: 700),
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
                                                                margin: EdgeInsets
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
                                                                margin: EdgeInsets
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
                                                                EdgeInsets.only(
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
                                                      padding: EdgeInsets.only(
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
                                                    Text("  By: Currency.wiki",
                                                        textScaleFactor:
                                                            Constants
                                                                .textScaleFactor,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: MyColors
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16,
                                                        ))
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
                          margin: EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("visualSize".tr().toString(),
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
                          width: width * .945,
                          padding: EdgeInsets.only(
                              top: 15, left: 0, right: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.1,
                                    child: Checkbox(
                                      side:
                                          BorderSide(color: MyColors.textColor),
                                      value: Constants.selectedFontSize ==
                                          Constants.fontSmall,
                                      onChanged: (value) async {
                                        if (value!) {
                                          Constants.selectedFontSize =
                                              Constants.fontSmall;
                                          Constants.textScaleFactor = 0.95;
                                          await Utility.setStringPreference(
                                              Constants.fontSize,
                                              Constants.fontSmall);
                                        }

                                        setState(() {
                                          // if (MyColors.fontlarge || MyColors.fontmedium) {
                                          //   MyColors.fontsmall = true;
                                          //   MyColors.fontlarge = false;
                                          //   MyColors.fontmedium = false;
                                          // }
                                        });
                                      },
                                      activeColor: Colors.white,
                                      checkColor: Colors.black,
                                      tristate: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Text("A".tr().toString(),
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: MyColors.textColor,
                                      )),
                                ],
                              ),
                              _isContainerVisible
                                  ? Container()
                                  : Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.1,
                                          child: Checkbox(
                                            side: BorderSide(
                                                color: MyColors.textColor),
                                            value: Constants.selectedFontSize ==
                                                Constants.fontMedium,
                                            onChanged: (value) async {
                                              if (value!) {
                                                Constants.selectedFontSize =
                                                    Constants.fontMedium;
                                                await Utility
                                                    .setStringPreference(
                                                        Constants.fontSize,
                                                        Constants.fontMedium);
                                                Constants.textScaleFactor = 1;
                                              }
                                              setState(() {
                                                // if (MyColors.fontsmall || MyColors.fontlarge) {
                                                //   MyColors.fontsmall = false;
                                                //   MyColors.fontlarge = false;
                                                //   MyColors.fontmedium = true;
                                                // }
                                              });
                                            },
                                            activeColor: MyColors.darkModeCheck
                                                ? Colors.black45
                                                : Colors.white,
                                            checkColor: Colors.black,
                                            tristate: false,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        Text(
                                          "A".tr().toString(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: MyColors.textColor),
                                        ),
                                      ],
                                    ),
                              _isContainerVisible
                                  ? Container()
                                  : Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.1,
                                          child: Checkbox(
                                            side: BorderSide(
                                                color: MyColors.textColor),
                                            value: Constants.selectedFontSize ==
                                                Constants.fontLarge,
                                            onChanged: (value) async {
                                              if (value!) {
                                                Constants.selectedFontSize =
                                                    Constants.fontLarge;
                                                await Utility
                                                    .setStringPreference(
                                                        Constants.fontSize,
                                                        Constants.fontLarge);
                                                Constants.textScaleFactor = 1.1;
                                              }
                                              setState(() {
                                                // if (MyColors.fontsmall || MyColors.fontmedium) {
                                                //   MyColors.fontsmall = false;
                                                //   MyColors.fontlarge = true;
                                                //   MyColors.fontmedium = false;
                                                // }
                                              });
                                            },
                                            activeColor: MyColors.darkModeCheck
                                                ? Colors.black45
                                                : Colors.white,
                                            checkColor: Colors.black,
                                            tristate: false,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        Text(
                                          "A".tr().toString(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: MyColors.textColor),
                                        ),
                                      ],
                                    )
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 25),
                          child: Text("appLogoLauncher".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: EdgeInsets.only(
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
                                          "multiConverter".tr().toString(),
                                          textScaleFactor:
                                              Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: MyColors.textColor,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                    width: 30,
                                    height: 10,
                                    margin: EdgeInsets.only(top: 2, left: 0),
                                    child: Switch(
                                      inactiveTrackColor: MyColors.darkModeCheck
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade300,
                                      inactiveThumbColor: MyColors.textColor,
                                      value: isMultiConverter,
                                      onChanged: (value) {
                                        setState(() {
                                          isMultiConverter = value;
                                          // print(isSwitched);
                                        });
                                      },
                                      activeTrackColor: MyColors.colorPrimary,
                                      activeColor: MyColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text("Will open multi-converter by default,Note"),
                              //     Text("NOTE:"),
                              //     Text("This feature only works with app logo")
                              //   ],
                              // )
                              _isContainerVisible
                                  ? Container()
                                  : RichText(
                                      text: TextSpan(
                                          text: "multiConverterContent1"
                                              .tr()
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 11,
                                              color: MyColors.textColor),
                                          children: <TextSpan>[
                                          TextSpan(
                                            text: "multiConverterContent2"
                                                .tr()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: MyColors.textColor),
                                          ),
                                          TextSpan(
                                            text: "multiConverterContent3"
                                                .tr()
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 11,
                                                color: MyColors.textColor),
                                          )
                                        ])),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(left: 0, bottom: 5, top: 25),
                          child: Text("display".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: EdgeInsets.only(
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
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text("display1".tr().toString(),
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: MyColors.textColor,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaycode,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaysymbol) {
                                            MyColors.displaysymbol = false;
                                            MyColors.displaycode = true;
                                          } else
                                            MyColors.displaycode =
                                                !MyColors.displaycode;
                                        } else if (MyColors.displaycode) {
                                        } else {
                                          MyColors.displaycode = true;
                                          MyColors.displaysymbol = false;
                                        }

                                        // print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: MyColors.colorPrimary,
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
                                    padding: EdgeInsets.only(top: 12),
                                    child: AutoSizeText(
                                      "display2".tr().toString(),
                                      style: GoogleFonts.roboto(
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.normal),
                                      maxFontSize: 17,
                                      minFontSize: 15,
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaysymbol,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaycode) {
                                            MyColors.displaysymbol = true;
                                            MyColors.displaycode = false;
                                          } else
                                            MyColors.displaysymbol =
                                                !MyColors.displaysymbol;
                                        } else if (MyColors.displaysymbol) {
                                        } else if (MyColors.displaysymbol &&
                                            !MyColors.displayflag) {
                                        } else {
                                          MyColors.displaysymbol = true;
                                          MyColors.displaycode = false;
                                        }
                                      });
                                    },
                                    activeTrackColor: MyColors.colorPrimary,
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
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text("display3".tr().toString(),
                                        textScaleFactor:
                                            Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: MyColors.textColor,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displayflag,
                                    onChanged: (value) {
                                      setState(() {
                                        if (!MyColors.displaycode &&
                                            !MyColors.displaysymbol) {
                                        } else
                                          MyColors.displayflag =
                                              !MyColors.displayflag;
                                        // print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: MyColors.colorPrimary,
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("dateFormat".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(bottom: 24),
                          height: 55,
                          width: width * .945,
                          padding: EdgeInsets.only(
                              top: 0, left: 15, right: 15, bottom: 0),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.1,
                                    child: Checkbox(
                                      side:
                                          BorderSide(color: MyColors.textColor),
                                      value: Constants.dateFormat ==
                                          Constants.ddMmYyyy,
                                      onChanged: (value) async {
                                        if (value!) {
                                          Constants.dateFormat =
                                              Constants.ddMmYyyy;
                                          await Utility.setStringPreference(
                                              Constants.DATE_FROMAT,
                                              Constants.dateFormat);
                                        }
                                        setState(() {});
                                      },
                                      activeColor: MyColors.darkModeCheck
                                          ? Colors.black45
                                          : Colors.white,
                                      checkColor: Colors.black,
                                      tristate: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
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
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.1,
                                    child: Checkbox(
                                      side:
                                          BorderSide(color: MyColors.textColor),
                                      value: Constants.dateFormat ==
                                          Constants.mmDdYyyy,
                                      onChanged: (value) async {
                                        if (value!) {
                                          Constants.dateFormat =
                                              Constants.mmDdYyyy;
                                          await Utility.setStringPreference(
                                              Constants.DATE_FROMAT,
                                              Constants.dateFormat);
                                        }

                                        setState(() {});
                                      },
                                      activeColor: MyColors.darkModeCheck
                                          ? Colors.black45
                                          : Colors.white,
                                      checkColor: Colors.black,
                                      tristate: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Text(
                                    "mm/dd/yy",
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: MyColors.textColor),
                                  ),
                                ],
                              )
                            ],
                          )),
                ],
              ),
            ),
          )),
    );
  }

  void unlockchangeColor(Color color) {
    var code = (color.value.toRadixString(16));
    MyColors.colorPrimary = Color(int.parse("0x$code"));

    setState(
      () => unlockCurrentColor = color,
    );
    debugPrint(
        "unlock in behja -> ${unlockCurrentColor.value.toRadixString(16)}");
  }

  void lockchangeColor(Color color) {
    widget.onThemeChange;
    setState(() => lockCurrentColor = color);
    debugPrint("selected color -> ${lockCurrentColor.value.toRadixString(16)}");
  }

  void densitychangeColor(Color color) {
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
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

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
                      lockedColor: lockedcolortry,
                      onColorSelect: onColorSelect,
                      densitychangeColor: densitychangeColor,
                      lockchangeColor: lockchangeColor,
                      unlockchangeColor: unlockchangeColor,
                      densityCurrentColor: densityCurrentColor,
                      lockCurrentColor: lockCurrentColor,
                      unlockCurrentColor: unlockCurrentColor,
                      unlockColorSelect: lockedcolortry,
                      onThemeChange: widget.onThemeChange,
                    )),
              ),
            ),
          );
        });
  }

//   void showBottomSheetForLanguage(BuildContext context) async {
//     showGeneralDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel:
//             MaterialLocalizations.of(context).modalBarrierDismissLabel,
//         barrierColor: Colors.black45,
//         transitionDuration: const Duration(milliseconds: 200),
//         pageBuilder: (BuildContext buildContext, Animation animation,
//             Animation secondaryAnimation) {
//           double width = MediaQuery.of(context).size.width;
//           double height = MediaQuery.of(context).size.height;

//           return DefaultTextStyle(
//             style: const TextStyle(decoration: TextDecoration.none),
//             child: Center(
//               child: Container(
//                 margin: const EdgeInsets.only(
//                     top: 200, right: 10, bottom: 80, left: 10),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 6.77,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Language(),
//               ),
//             ),
//           );
//         });
//   }
}
// content: SingleChildScrollView(
//child: BlockPicker(
//
//     pickerColor: currentColor,
//     onColorChanged: changeColor,
//
//   ),
// ),

class ColorPickerDialog extends StatefulWidget {
  final Function onThemeChange;

  final Function(Color color) unlockchangeColor;
  final Function(Color color) densitychangeColor;
  final Function(Color color) lockchangeColor;
  final Function(Color color, BuildContext context) onColorSelect;
  final Color unlockCurrentColor;
  final Color lockCurrentColor;
  final Color densityCurrentColor;
  bool lockedColor;
  bool unlockColorSelect;

  ColorPickerDialog(
      {required this.onColorSelect,
      required this.lockchangeColor,
      required this.densitychangeColor,
      required this.unlockchangeColor,
      required this.densityCurrentColor,
      required this.lockCurrentColor,
      required this.unlockCurrentColor,
      required this.lockedColor,
      required this.unlockColorSelect,
      required this.onThemeChange,
      Key? key})
      : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color unlockCurrentColor = Colors.white;
  Color lockCurrentColor = Colors.white;
  Color densityCurrentColor = Colors.white;

  MColor selectedColor = MColor(mainColor: Colors.white, densityColors: []);

  List<MColor> colors = [
    MColor(mainColor: Colors.deepPurple, densityColors: [
      Colors.deepPurple.shade50,
      Colors.deepPurple.shade100,
      Colors.deepPurple.shade200,
      Colors.deepPurple,
      Colors.deepPurple.shade900
    ]),
    MColor(mainColor: Colors.indigo, densityColors: [
      Colors.indigo.shade50,
      Colors.indigo.shade100,
      Colors.indigo.shade200,
      Colors.indigo,
      Colors.indigo.shade900
    ]),
    MColor(mainColor: Colors.blue, densityColors: [
      Colors.blue.shade50,
      Colors.blue.shade100,
      Colors.blue.shade200,
      Colors.blue,
      Colors.blue.shade900
    ]),
    MColor(mainColor: Colors.lightBlue, densityColors: [
      Colors.lightBlue.shade50,
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue,
      Colors.lightBlue.shade900
    ]),
    MColor(mainColor: Colors.cyan, densityColors: [
      Colors.cyan.shade50,
      Colors.cyan.shade100,
      Colors.cyan.shade200,
      Colors.cyan,
      Colors.cyan.shade900
    ]),
    MColor(mainColor: Colors.red, densityColors: [
      Colors.red.shade50,
      Colors.red.shade100,
      Colors.red.shade200,
      Colors.red,
      Colors.red.shade900
    ]),
    MColor(mainColor: Colors.yellow, densityColors: [
      Colors.yellow.shade50,
      Colors.yellow.shade100,
      Colors.yellow.shade200,
      Colors.yellow,
      Colors.yellow.shade900
    ]),
    MColor(mainColor: Colors.pink, densityColors: [
      Colors.pink.shade50,
      Colors.pink.shade100,
      Colors.pink.shade200,
      Colors.pink,
      Colors.pink.shade900
    ]),
    MColor(mainColor: Colors.black, densityColors: [
      Colors.black12,
      Colors.black26,
      Colors.black45,
      Colors.black54,
      Colors.black87
    ]),
  ];
  Color? lockSelectdColor;
  Color? unlockSelectdColor;
  Color? colorSelection;
  Color densitySelectedColor = Colors.red;
  bool density = false;
  bool lock = false;

  @override
  void initState() {
    unlockCurrentColor = widget.unlockCurrentColor;
    lockCurrentColor = widget.lockCurrentColor;
    densityCurrentColor = widget.densityCurrentColor;
    selectedColor = MColor(mainColor: Colors.white, densityColors: [
      Colors.lightBlue.shade50,
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade500,
      Colors.lightBlue.shade600,
      Colors.lightBlue.shade900
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25, top: 30, bottom: 0),
          child: Text(
            "unlocked".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.height * 0.089,
          child: Container(
            width: 400,
            child: UnlockColorPicker(
              pickerColor: selectedColor,
              onColorChanged: unlockchangeColor,
              availableColors: colors,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25, top: 5),
          child: Text(
            "locked".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 5),
          width: width * 0.8,
          height: height * 0.29,
          child: LockColorPicker(
            pickerColor: lockCurrentColor,
            onColorChanged: lockchangeColor,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: width * 0.87,
            height: height * 0.077,
            child: DensityColorPicker(
                pickerColor: densityCurrentColor,
                onColorChanged: densitychangeColor,
                availableColors: selectedColor.densityColors),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        widget.lockedColor
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      width: width * 0.45,
                      height: height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigoAccent),
                        onPressed: () {
                          MyColors.colorPrimary = colorSelection!;

                          int red = MyColors.colorPrimary.red;
                          int blue = MyColors.colorPrimary.blue;
                          int green = MyColors.colorPrimary.green;

                          var grayscale =
                              (0.299 * red) + (0.587 * green) + (0.114 * blue);
                          print("************************-> $grayscale");

                          if (grayscale > 200) {
                            MyColors.textColor = Colors.grey.shade700;
                            MyColors.insideTextFieldColor = Colors.white;
                            MyColors.darkModeCheck = true;
                            MyColors.lightModeCheck = false;
                          } else {
                            MyColors.textColor = Colors.white;
                            MyColors.insideTextFieldColor = Colors.black;
                            MyColors.lightModeCheck = true;
                            MyColors.darkModeCheck = false;
                          }
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                                statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                                systemNavigationBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                            systemNavigationBarColor:
                                MyColors.colorPrimary, // navigation bar color
                            statusBarColor:
                                MyColors.colorPrimary, // status bar color
                          ));

                          widget.onThemeChange();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "try".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      width: width * 0.45,
                      height: height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigoAccent),
                        onPressed: () {},
                        child: Text(
                          "unlock".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              )
            : Text(
                "",
                textScaleFactor: Constants.textScaleFactor,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 25,
                top: 10,
              ),
              width: width * 0.31,
              height: height * 0.05,
              child: GestureDetector(
                onTap: () {
                  showCustomColorPickerDialog(context);
                },
                child: Text(
                  "custom".tr().toString(),
                  textScaleFactor: Constants.textScaleFactor,
                  style: TextStyle(
                      letterSpacing: 0.8,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            widget.unlockColorSelect
                ? Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    width: width * 0.25,
                    height: height * 0.05,
                    child: GestureDetector(
                      onTap: () {
                        MyColors.colorPrimary = unlockSelectdColor!;
                        int red = MyColors.colorPrimary.red;
                        int blue = MyColors.colorPrimary.blue;
                        int green = MyColors.colorPrimary.green;

                        var grayscale =
                            (0.299 * red) + (0.587 * green) + (0.114 * blue);
                        print("************************-> $grayscale");

                        if (grayscale > 200) {
                          MyColors.textColor = Colors.grey.shade700;
                          MyColors.insideTextFieldColor = Colors.white;
                          MyColors.darkModeCheck = true;
                          MyColors.lightModeCheck = false;
                        } else {
                          MyColors.textColor = Colors.white;
                          MyColors.insideTextFieldColor = Colors.black;
                          MyColors.lightModeCheck = true;
                          MyColors.darkModeCheck = false;
                        }
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                              statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                              systemNavigationBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                          systemNavigationBarColor:
                              MyColors.colorPrimary, // navigation bar color
                          statusBarColor:
                              MyColors.colorPrimary, // status bar color
                        ));
                        Utility.setStringPreference(Constants.themeColor,
                            unlockSelectdColor!.value.toString());
                        themepicker(unlockSelectdColor!.value.toString());

                        widget.onThemeChange();
                        Navigator.pop(context);

                        setState(() {});
                      },
                      child: Text(
                        "select".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Text(
                    "",
                    textScaleFactor: Constants.textScaleFactor,
                  ),
          ],
        )
      ],
    );
  }

  void showCustomColorPickerDialog(BuildContext context) async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Stack(children: [
              Container(
                height: height * 0.71,
                margin: const EdgeInsets.only(top: 100, right: 10, left: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomColorPicker(onThemeChange: widget.onThemeChange),
              ),
            ]),
          );
        });
  }

  void unlockchangeColor(MColor color) {
    MyColors.lockCheck = false;
    MyColors.densitycheck = false;
    widget.lockedColor = false;

    widget.unlockColorSelect = true;
    var code = (color.mainColor.value.toRadixString(16));
    unlockSelectdColor = Color(int.parse("0x$code"));

    selectedColor = color;
    setState(
      () => unlockCurrentColor = color.mainColor,
    );
    // widget.unlockchangeColor(color.mainColor);
  }

  void lockchangeColor(Color color) {
    MyColors.unclockCheck = false;
    MyColors.densitycheck = false;

    widget.unlockColorSelect = false;
    widget.lockedColor = true;
    var code = (color.value.toRadixString(16));
    lockSelectdColor = Color(int.parse("0x$code"));
    colorSelection = lockSelectdColor;

    setState(
      () => lockCurrentColor = color,
    );
  }

  void densitychangeColor(Color color) {
    MyColors.unclockCheck = false;
    MyColors.lockCheck = false;

    widget.lockedColor = true;
    density = true;
    var code = (color.value.toRadixString(16));
    densitySelectedColor = Color(int.parse("0x$code"));
    colorSelection = densitySelectedColor;

    setState(
      () => unlockCurrentColor = color,
    );
    setState(() => densityCurrentColor = color);
    widget.densitychangeColor(color);
    debugPrint(
        "selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  static void themepicker(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.themeColor, code);
  }
}

class MColor {
  Color mainColor;
  List<Color> densityColors;

  MColor({required this.mainColor, required this.densityColors});
}
