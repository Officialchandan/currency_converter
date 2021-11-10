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
  bool isMultiConverter = false ;
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
                          style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  Container(
                    // margin: EdgeInsets.only(right: 20),

                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 20),
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
                                  text: "removeAdsContent".tr().toString(),
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
                            inactiveTrackColor: MyColors.darkModeCheck ? MyColors.colorPrimary : Colors.grey.shade300,
                            inactiveThumbColor: MyColors.textColor,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                // print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.grey.shade800,
                            activeColor: MyColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                      child: Text("selectLanguage".tr().toString(),
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

                        // margin: EdgeInsets.only(right: 22),

                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 14),
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("english".tr().toString(),
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
                          margin: const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                          child: Text("colorsSelection".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  // Transform.scale(
                                  //   scale: 1,
                                  //   child: Checkbox(
                                  //     side: BorderSide(color: MyColors.textColor),
                                  //     value: MyColors.lightModeCheck,
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         if (MyColors.darkModeCheck) {
                                  //           MyColors.lightModeCheck = !MyColors.lightModeCheck;
                                  //           MyColors.darkModeCheck = !MyColors.darkModeCheck;
                                  //           MyColors.textColor = Colors.white;
                                  //           MyColors.insideTextFieldColor = Colors.black;
                                  //           MyColors.calcuColor = MyColors.colorPrimary;
                                  //
                                  //           widget.onThemeChange();
                                  //         }
                                  //       });
                                  //     },
                                  //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                  //     checkColor: Colors.black,
                                  //     tristate: false,
                                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      if (!MyColors.lightModeCheck) {
                                        MyColors.lightModeCheck = true;
                                        MyColors.darkModeCheck = false;

                                        // MyColors.darkModeCheck = !MyColors.darkModeCheck;
                                        MyColors.textColor = Colors.white;
                                        MyColors.insideTextFieldColor = Colors.black;
                                        MyColors.calcuColor = MyColors.colorPrimary;
                                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                          systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                                          systemNavigationBarIconBrightness: Brightness.light,
                                          statusBarColor: MyColors.colorPrimary, // status bar color
                                        ));
                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: MyColors.lightModeCheck
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                                  // Transform.scale(
                                  //   scale: 1,
                                  //   child: Checkbox(
                                  //     side: BorderSide(color: MyColors.textColor),
                                  //     value: MyColors.darkModeCheck,
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         if (MyColors.lightModeCheck) {
                                  //           MyColors.darkModeCheck = !MyColors.darkModeCheck;
                                  //           MyColors.lightModeCheck = !MyColors.lightModeCheck;
                                  //           MyColors.textColor = Colors.grey.shade800;
                                  //           MyColors.insideTextFieldColor = Colors.white;
                                  //           MyColors.calcuColor = Colors.grey.shade700;
                                  //
                                  //           widget.onThemeChange();
                                  //         }
                                  //       });
                                  //     },
                                  //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                  //     checkColor: Colors.black,
                                  //     tristate: false,
                                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      if (!MyColors.darkModeCheck) {
                                        MyColors.darkModeCheck = true;
                                        MyColors.lightModeCheck = false;

                                        // MyColors.lightModeCheck = !MyColors.lightModeCheck;
                                        MyColors.textColor = Colors.grey.shade800;
                                        MyColors.insideTextFieldColor = Colors.white;
                                        MyColors.calcuColor = Colors.grey.shade700;

                                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                          systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                                          systemNavigationBarIconBrightness: Brightness.dark,
                                          statusBarColor: MyColors.colorPrimary, // status bar color
                                        ));

                                        widget.onThemeChange();
                                      }
                                      setState(() {});
                                    },
                                    child: MyColors.darkModeCheck
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "dark".tr().toString(),
                                    textScaleFactor: Constants.textScaleFactor,
                                    style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor),
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
                                  style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(top: 10, left: 0, right: 10, bottom: 10),
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
                                              padding: EdgeInsets.only(bottom: 5),
                                              color: MyColors.textColor.withOpacity((x) as double),
                                              child: AnimatedOpacity(
                                                duration: Duration(milliseconds: 700),
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
                                                                margin: EdgeInsets.only(right: 10),
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
                                                                margin: EdgeInsets.only(right: 10),
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
                                                            padding: EdgeInsets.only(left: 50, top: 0),
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
                                                      padding: EdgeInsets.only(left: 80, top: 0),
                                                      child: Text("-0.0400",
                                                          textScaleFactor: Constants.textScaleFactor,
                                                          style: TextStyle(
                                                            color: MyColors.textColor,
                                                            fontSize: 15,
                                                          )),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text("wiki".tr().toString(),
                                                        textScaleFactor: Constants.textScaleFactor,
                                                        style: GoogleFonts.roboto(
                                                          color: MyColors.textColor,
                                                          fontWeight: FontWeight.normal,
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
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          //  margin: EdgeInsets.only(right: 22),
                          height: 50,
                          width: width * .945,
                          padding: EdgeInsets.only(top: 15, left: 0, right: 15, bottom: 15),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                    color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Text("A".tr().toString(),
                                        textScaleFactor: 0.9,
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
                                    // Transform.scale(
                                    //   scale: 1,
                                    //   child: Checkbox(
                                    //     side: BorderSide(color: MyColors.textColor),
                                    //     value: Constants.selectedFontSize == Constants.fontMedium,
                                    //     onChanged: (value) async {
                                    //       if (value!) {
                                    //         Constants.selectedFontSize = Constants.fontMedium;
                                    //         await Utility.setStringPreference(Constants.fontSize, Constants.fontMedium);
                                    //         Constants.textScaleFactor = 1;
                                    //       }
                                    //       setState(() {});
                                    //     },
                                    //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                    //     checkColor: Colors.black,
                                    //     tristate: false,
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    //   ),
                                    // ),
                                    Constants.selectedFontSize == Constants.fontMedium
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.95,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "A".tr().toString(),
                                      textScaleFactor: 0.95,
                                      style: GoogleFonts.roboto(fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.w500),
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
                                    // Transform.scale(
                                    //   scale: 1,
                                    //   child: Checkbox(
                                    //     side: BorderSide(color: MyColors.textColor),
                                    //     value: Constants.selectedFontSize == Constants.fontLarge,
                                    //     onChanged: (value) async {
                                    //       if (value!) {
                                    //         Constants.selectedFontSize = Constants.fontLarge;
                                    //         await Utility.setStringPreference(Constants.fontSize, Constants.fontLarge);
                                    //         Constants.textScaleFactor = 1.1;
                                    //       }
                                    //       setState(() {                                        });
                                    //     },
                                    //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                    //     checkColor: Colors.black,
                                    //     tristate: false,
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    //   ),
                                    // ),
                                    Constants.selectedFontSize == Constants.fontLarge
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "A".tr().toString(),
                                      textScaleFactor: 1,
                                      style: GoogleFonts.roboto(fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 5, top: 25),
                          child: Text("appLogoLauncher".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: EdgeInsets.only(top: 15, left: 10, right: 20, bottom: 15),
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
                                      margin: EdgeInsets.only(bottom: 5, left: 2),
                                      child: Text("multiConverter".tr().toString(),
                                          textScaleFactor: Constants.textScaleFactor,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                                  Container(
                                    width: 30,
                                    height: 10,
                                    margin: EdgeInsets.only(top: 2, left: 0),
                                    child: Switch(
                                      inactiveTrackColor: MyColors.darkModeCheck ? MyColors.colorPrimary : Colors.grey.shade300,
                                      inactiveThumbColor: MyColors.textColor,
                                      value: isMultiConverter,
                                      onChanged: (value) {
                                        setState(() {
                                          isMultiConverter = value;
                                          // print(isSwitched);
                                        });
                                      },
                                      activeTrackColor: Colors.grey.shade800,
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
                                  : AutoSizeText(
                                      "multiConverterContent1".tr().toString() +
                                          " " +
                                          "multiConverterContent2".tr().toString() +
                                          " " +
                                          "multiConverterContent3".tr().toString(),
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
                          margin: EdgeInsets.only(left: 0, bottom: 5, top: 25),
                          child: Text("display".tr().toString(),
                              textScaleFactor: Constants.textScaleFactor,
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                          width: width * .945,
                          padding: EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text("display1".tr().toString(),
                                        textScaleFactor: Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaycode,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaysymbol) {
                                            MyColors.displaysymbol = false;
                                            MyColors.displaycode = true;
                                          } else
                                            MyColors.displaycode = !MyColors.displaycode;
                                        } else if (MyColors.displaycode) {
                                        } else {
                                          MyColors.displaycode = true;
                                          MyColors.displaysymbol = false;
                                        }

                                        // print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: Colors.grey.shade800,
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: AutoSizeText(
                                      "display2".tr().toString(),
                                      style: GoogleFonts.roboto(color: MyColors.textColor, fontWeight: FontWeight.normal),
                                      maxFontSize: 17,
                                      minFontSize: 15,
                                    ),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displaysymbol,
                                    onChanged: (value) {
                                      setState(() {
                                        if (MyColors.displayflag) {
                                          if (MyColors.displaycode) {
                                            MyColors.displaysymbol = true;
                                            MyColors.displaycode = false;
                                          } else
                                            MyColors.displaysymbol = !MyColors.displaysymbol;
                                        } else if (MyColors.displaysymbol) {
                                        } else if (MyColors.displaysymbol && !MyColors.displayflag) {
                                        } else {
                                          MyColors.displaysymbol = true;
                                          MyColors.displaycode = false;
                                        }
                                      });
                                    },
                                    activeTrackColor: Colors.grey.shade800,
                                    activeColor: MyColors.textColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text("display3".tr().toString(),
                                        textScaleFactor: Constants.textScaleFactor,
                                        style: GoogleFonts.roboto(
                                            fontSize: 17, color: MyColors.textColor, fontWeight: FontWeight.normal)),
                                  ),
                                  Switch(
                                    inactiveTrackColor: MyColors.darkModeCheck ? MyColors.colorPrimary : Colors.grey.shade300,
                                    inactiveThumbColor: MyColors.textColor,
                                    value: MyColors.displayflag,
                                    onChanged: (value) {
                                      setState(() {
                                        if (!MyColors.displaycode && !MyColors.displaysymbol) {
                                        } else
                                          MyColors.displayflag = !MyColors.displayflag;
                                        // print(isSwitched);
                                      });
                                    },
                                    activeTrackColor: Colors.grey.shade800,
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
                              style: GoogleFonts.roboto(fontSize: 18, color: MyColors.textColor, fontWeight: FontWeight.bold))),
                  _isContainerVisible
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(bottom: 24),
                          height: 55,
                          width: width * .945,
                          padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
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
                                    // Transform.scale(
                                    //   scale: 1.1,
                                    //   child: Checkbox(
                                    //     side: BorderSide(color: MyColors.textColor),
                                    //     value: Constants.dateFormat == Constants.ddMmYyyy,
                                    //     onChanged: (value) async {
                                    //       if (value!) {
                                    //         Constants.dateFormat = Constants.ddMmYyyy;
                                    //         await Utility.setStringPreference(Constants.DATE_FROMAT, Constants.dateFormat);
                                    //       }
                                    //       setState(() {});
                                    //     },
                                    //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                    //     checkColor: Colors.black,
                                    //     tristate: false,
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    //   ),
                                    // ),
                                    Constants.dateFormat == Constants.ddMmYyyy
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
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
                                    // Transform.scale(
                                    //   scale: 1.1,
                                    //   child: Checkbox(
                                    //     side: BorderSide(color: MyColors.textColor),
                                    //     value: Constants.dateFormat == Constants.mmDdYyyy,
                                    //     onChanged: (value) async {
                                    //       if (value!) {
                                    //         Constants.dateFormat = Constants.mmDdYyyy;
                                    //         await Utility.setStringPreference(Constants.DATE_FROMAT, Constants.dateFormat);
                                    //       }
                                    //
                                    //       setState(() {});
                                    //     },
                                    //     activeColor: MyColors.darkModeCheck ? Colors.black45 : Colors.white,
                                    //     checkColor: Colors.black,
                                    //     tristate: false,
                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    //   ),
                                    // ),
                                    Constants.dateFormat == Constants.mmDdYyyy
                                        ? Image(
                                            image: const AssetImage("assets/images/check.png"),
                                            width: 17,
                                            height: 17,
                                            fit: BoxFit.cover,
                                            color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                          )
                                        : Container(
                                            width: 17,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                // color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  width: 0.8,
                                                  color: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                                )),
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
    debugPrint("unlock in behja -> ${unlockCurrentColor.value.toRadixString(16)}");
  }

  void lockchangeColor(Color color) {
    widget.onThemeChange;
    setState(() => lockCurrentColor = color);
    debugPrint("selected color -> ${lockCurrentColor.value.toRadixString(16)}");
  }

  void densitychangeColor(Color color) {
    widget.onThemeChange;
    setState(() => densityCurrentColor = color);

    debugPrint("selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  void onColorSelect(Color themeColor, BuildContext context) {
    print("OnColorSelect-->");
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
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

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
  LColor lockCurrentColor = LColor(lmainColor: Colors.white, ldensityColors: []);
  Color densityCurrentColor = Colors.white;

  MColor selectedColor = MColor(mainColor: Colors.white, densityColors: []);
   LColor lselectedColor = LColor(lmainColor: Colors.white, ldensityColors: []);

  List<MColor> colors = [
    MColor(mainColor: Color(0xff4e7dcb), densityColors: [
     Color(0xffc9d8ef),
      Color(0xffb8cbea),
      Color(0xffa6bee5),
      Color(0xff94b1df),
      Color(0xff83a4da),
      Color(0xff7197d5),
      Color(0xff5f8ad0),
      Color(0xff4e7dcb),
      Color(0xff4e7dcb),
      Color(0xff4670b6),
      Color(0xff3e64a2),
      Color(0xff36578e),
      Color(0xff2e4b79),
      Color(0xff273e65),
      Color(0xff1f3251),
      Color(0xff17253c),
      Color(0xff0f1928),
      Color(0xff070c14),
      Color(0xff000000),
    ]),
    MColor(mainColor: Color(0xff54a925), densityColors: [
      Color(0xffcbe5bd),
      Color(0xffbadca7),
      Color(0xffa9d492),
      Color(0xff98CB7C),
      Color(0xff87C266),
      Color(0xff76BA50),
      Color(0xff65B13A),
      Color(0xff54a925),
      Color(0xff43871D ),
      Color(0xff3A7619 ),
      Color(0xff326516),
      Color(0xff295412),
      Color(0xff21430E),
      Color(0xff19320B),
      Color(0xff102107),
      Color(0xff081003),
      Color(0xff000000),

    ]),
    MColor(
        mainColor: Color(0xffc95856),
        densityColors: [


          Color(0xfff4dddd),
          Color(0xffeecccc),
          Color(0xffe9bcbb),
          Color(0xffe4abaa),
          Color(0xffde9a99),
          Color(0xffd98a88),
          Color(0xffd37977),
          Color(0xffce6866),
          Color(0xffc95856),
          Color(0xffc95856),
          Color(0xffb44f4d),
          Color(0xffa04644),
          Color(0xff8c3d3c),
          Color(0xff783433),
          Color(0xff642c2b),
          Color(0xff502322),
          Color(0xff3c1a19),
          Color(0xff281111),
          Color(0xff140808),
          Color(0xff000000),


        ]),
    MColor(
        mainColor: Color(0xffffa415),
        densityColors: [

          Color(0xffffdaa1),
          Color(0xffffd18a),
          Color(0xffffc872),
          Color(0xffffbf5b),
          Color(0xffffb643),
          Color(0xffffad2c),
          Color(0xffffa415),
          Color(0xffffa415),
          Color(0xffe59312),
          Color(0xffcc8310),
          Color(0xffb2720e),
          Color(0xff99620c),
          Color(0xff7f520a),
          Color(0xff664108),
          Color(0xff4c3106),
          Color(0xff332004),
          Color(0xff191002),
          Color(0xff000000
          ),

    ]),

  ];List<LColor> lcolors = [
    LColor(lmainColor: Color(0xff4e7dcb), ldensityColors: [
     Color(0xffc9d8ef),
      Color(0xffb8cbea),
      Color(0xffa6bee5),
      Color(0xff94b1df),
      Color(0xff83a4da),
      Color(0xff7197d5),
      Color(0xff5f8ad0),
      Color(0xff4e7dcb),
      Color(0xff4e7dcb),
      Color(0xff4670b6),
      Color(0xff3e64a2),
      Color(0xff36578e),
      Color(0xff2e4b79),
      Color(0xff273e65),
      Color(0xff1f3251),
      Color(0xff17253c),
      Color(0xff0f1928),
      Color(0xff070c14),
      Color(0xff000000),
    ]),
    LColor(lmainColor: Color(0xff54a925), ldensityColors: [
      Color(0xffcbe5bd),
      Color(0xffbadca7),
      Color(0xffa9d492),
      Color(0xff98CB7C),
      Color(0xff87C266),
      Color(0xff76BA50),
      Color(0xff65B13A),
      Color(0xff54a925),
      Color(0xff43871D),
      Color(0xff3A7619),
      Color(0xff326516),
      Color(0xff295412),
      Color(0xff21430E),
      Color(0xff19320B),
      Color(0xff102107),
      Color(0xff081003),
      Color(0xff000000),

    ]),
    LColor(
        lmainColor: Color(0xffc95856),
        ldensityColors: [


          Color(0xfff4dddd),
          Color(0xffeecccc),
          Color(0xffe9bcbb),
          Color(0xffe4abaa),
          Color(0xffde9a99),
          Color(0xffd98a88),
          Color(0xffd37977),
          Color(0xffce6866),
          Color(0xffc95856),
          Color(0xffc95856),
          Color(0xffb44f4d),
          Color(0xffa04644),
          Color(0xff8c3d3c),
          Color(0xff783433),
          Color(0xff642c2b),
          Color(0xff502322),
          Color(0xff3c1a19),
          Color(0xff281111),
          Color(0xff140808),
          Color(0xff000000),


        ]),
    LColor(
        lmainColor: Color(0xffffa415),
        ldensityColors: [

          Color(0xffffdaa1),
          Color(0xffffd18a),
          Color(0xffffc872),
          Color(0xffffbf5b),
          Color(0xffffb643),
          Color(0xffffad2c),
          Color(0xffffa415),
          Color(0xffffa415),
          Color(0xffe59312),
          Color(0xffcc8310),
          Color(0xffb2720e),
          Color(0xff99620c),
          Color(0xff7f520a),
          Color(0xff664108),
          Color(0xff4c3106),
          Color(0xff332004),
          Color(0xff191002),
          Color(0xff000000
          ),

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
    lockCurrentColor = LColor(lmainColor: widget.lockCurrentColor,ldensityColors: []);
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
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 0.87,
          //height: MediaQuery.of(context).size.height * 0.4,
          child: IntrinsicHeight(
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 5),
          width: MediaQuery.of(context).size.width * 0.87,
          child: IntrinsicHeight(
            child: LockColorPicker(
              pickerColor: lockCurrentColor,
              onColorChanged: lockchangeColor,
              availableColors: lcolors,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: width * 0.87,
            height: height * 0.077,
            child: DensityColorPicker(
                pickerColor: densityCurrentColor, onColorChanged: densitychangeColor, availableColors: selectedColor.densityColors),
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
                        style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
                        onPressed: () {
                          MyColors.colorPrimary = colorSelection!;

                          int red = MyColors.colorPrimary.red;
                          int blue = MyColors.colorPrimary.blue;
                          int green = MyColors.colorPrimary.green;

                          var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
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

                          Utility.setTryColorPreference("Color", MyColors.colorPrimary.value.toRadixString(16));

                          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                            // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                            systemNavigationBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                            systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                            statusBarColor: MyColors.colorPrimary, // status bar color
                          ));

                          widget.onThemeChange();
                          Navigator.pop(context);
                        },
                        child: AutoSizeText(
                          "try".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: TextStyle(fontSize: 16),
                          maxLines: 1,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      width: width * 0.45,
                      height: height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
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
                top: 20,
              ),
              width: width * 0.55,
              height: height * 0.05,
              child: GestureDetector(
                onTap: () {
                  showCustomColorPickerDialog(context);
                },
                child: AutoSizeText(
                  "custom".tr().toString(),
                  textScaleFactor: Constants.textScaleFactor,
                  style: TextStyle(letterSpacing: 0.8, color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  maxLines: 1,
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

                        var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
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
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                          // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                          systemNavigationBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                          systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                          statusBarColor: MyColors.colorPrimary, // status bar color
                        ));
                        Utility.setStringPreference(Constants.themeColor, unlockSelectdColor!.value.toString());
                        themepicker(unlockSelectdColor!.value.toString());

                        widget.onThemeChange();
                        Navigator.pop(context);

                        setState(() {});
                      },
                      child: Text(
                        "select".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
                        style: TextStyle(letterSpacing: 1.0, color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
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

    // widget.unlockchangeColor(color.mainColor);
  }

  void lockchangeColor(LColor color) {
    MyColors.unclockCheck = false;
    MyColors.densitycheck = false;

    widget.unlockColorSelect = false;
    widget.lockedColor = true;
    var code = (color.lmainColor.value.toRadixString(16));
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
    debugPrint("selected color -> ${densityCurrentColor.value.toRadixString(16)}");
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
class LColor {
  Color lmainColor;
  List<Color> ldensityColors;

  LColor({required this.lmainColor, required this.ldensityColors});
}
