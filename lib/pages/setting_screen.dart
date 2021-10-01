import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/Themes/sharepref.dart';
import 'package:currency_converter/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors_properties/lockcolorpicker.dart';
import '../colors_properties/densitycolorpicker.dart';
import '../colors_properties/unlockcolorpicker.dart';

class SettingScreen extends StatefulWidget {
  final Function onThemeChange;

  SettingScreen(this.onThemeChange, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Color color = Colors.red;

  bool isSwitched = false;
  bool checkBoxValue1 = true;
  bool checkBoxValue2 = false;
  bool fontsmall = false;
  bool fontmedium = true;
  bool fontlarge = false;
  bool displaycode = false;
  bool displaysymbol = true;
  bool displayflag = true;

  Color unlockCurrentColor = MyColors.firstthemecolorgr;
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityCurrentColor = MyColors.firstthemecolorgr;

  double _value = 1.0;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(top: 5, left: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    MyColors.firstthemecolorgr1,
                    MyColors.firstthemecolorgr,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.001, 1.5])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 13),
                    child: Text("Remove Ads",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                  // margin: EdgeInsets.only(right: 20),
                  width: width * .92,
                  height: height * .078,
                  padding: const EdgeInsets.only(
                      top: 10, left: 7, right: 2, bottom: 0),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Support our project  with a small yearly",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: fontsmall
                                      ? (MyColors.textSize - 15) * (-1)
                                      : fontlarge
                                          ? (MyColors.textSize + 15)
                                          : 15,
                                  color: MyColors.textColor),
                            ),
                            TextSpan(
                              text: "\n subscription",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: fontsmall
                                      ? (MyColors.textSize - 15) * (-1)
                                      : fontlarge
                                          ? (MyColors.textSize + 20)
                                          : 15,
                                  color: MyColors.textColor),
                            )
                          ])),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 30,
                            height: 10,
                            margin: const EdgeInsets.only(top: 10, left: 2),
                            child: Switch(
                              inactiveTrackColor: Colors.grey,
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  // print(isSwitched);
                                });
                              },
                              activeTrackColor: const Color(0xff7986cb),
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                    child: Text("Select Language",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(

                    // margin: EdgeInsets.only(right: 22),
                    height: 55,
                    width: width * .92,
                    padding: const EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("English",
                                style: GoogleFonts.roboto(
                                  fontSize: fontsmall
                                      ? (MyColors.textSize - 18) * (-1)
                                      : fontlarge
                                          ? (MyColors.textSize + 18)
                                          : 18,
                                  color: MyColors.textColor,
                                )),
                            //  SizedBox(width: 245 ,),
                            const Icon(
                              Icons.expand_more_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const Divider(
                          height: 2,
                          color: Colors.white,
                          thickness: 1.2,
                        )
                      ],
                    )),
                Container(
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 13, top: 20),
                    child: Text("Color Selection",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                InkWell(
                  onTap: () {
                    showColorPickerDialog(context);
                  },
                  child: Container(
                      // margin: EdgeInsets.only(right: 22),
                      height: 50,
                      width: width * .92,
                      padding: EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                MyColors.firstthemecolorgr1,
                                MyColors.firstthemecolorgr,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 0.9]),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(width: 1.2, color: Colors.white),
                        ),
                        child: const Text(""),
                      )),
                ),
                Container(
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 13, top: 20),
                    child: Text("Theme",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    height: 55,
                    width: width * .92,
                    padding:
                        EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: Colors.white),
                            value: MyColors.checkBoxValue1,
                            onChanged: (value) {
                              setState(() {
                                if (MyColors.checkBoxValue2) {
                                  MyColors.checkBoxValue1 =
                                      !MyColors.checkBoxValue1;
                                  MyColors.checkBoxValue2 =
                                      !MyColors.checkBoxValue2;
                                  MyColors.textColor = Colors.white;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyTabBarWidget()),
                                      (route) => false);
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text("Light",
                            style: GoogleFonts.roboto(
                              fontSize: fontsmall
                                  ? (MyColors.textSize - 20) * (-1)
                                  : fontlarge
                                      ? (MyColors.textSize + 20)
                                      : 20,
                              color: MyColors.textColor,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: Colors.white),
                            value: MyColors.checkBoxValue2,
                            onChanged: (value) {
                              setState(() {
                                if (MyColors.checkBoxValue1) {
                                  MyColors.checkBoxValue2 =
                                      !MyColors.checkBoxValue2;
                                  MyColors.checkBoxValue1 =
                                      !MyColors.checkBoxValue1;
                                  MyColors.textColor = Colors.black;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyTabBarWidget()),
                                      (route) => false);
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text(
                          "Dark",
                          style: GoogleFonts.roboto(
                              fontSize: fontsmall
                                  ? (MyColors.textSize - 20) * (-1)
                                  : fontlarge
                                      ? (MyColors.textSize + 20)
                                      : 20,
                              color: MyColors.textColor),
                        )
                      ],
                    )),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          "Widget Transparency  ",
                          style: GoogleFonts.roboto(
                              fontSize: fontsmall
                                  ? (MyColors.textSize - 20) * (-1)
                                  : fontlarge
                                      ? (MyColors.textSize + 20)
                                      : 20,
                              color: MyColors.textColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Icon(
                      Icons.info,
                      color: MyColors.textColor,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 0, top: 15),
                  height: height * .183,
                  width: width * .92,
                  padding:
                      EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.31,
                              child: Slider(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  min: 0,
                                  max: 100,
                                  value: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      x = _value.toInt();
                                      _value = value;
                                    });
                                  }),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "${x.toString()}",
                                style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: fontsmall
                                      ? (MyColors.textSize - 15) * (-1)
                                      : fontlarge
                                          ? (MyColors.textSize + 15)
                                          : 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.5,
                        height: height * 1.9,
                        margin: EdgeInsets.only(left: 0.0),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.69),
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  MyColors.firstthemecolorgr,
                                  MyColors.firstthemecolorgr1,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.1, 1.5]),
                            border:
                                Border.all(color: Colors.white, width: 3.9)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 30,
                                ),
                                Text(
                                  "USD",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 20) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 20)
                                              : 20,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "/",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 20) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 20)
                                              : 20,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.flag,
                                  size: 30,
                                ),
                                Text(
                                  "EUR",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 20) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 20)
                                              : 20,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 50, top: 0),
                              child: Text("0.7895",
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: fontsmall
                                        ? (MyColors.textSize - 21) * (-1)
                                        : fontlarge
                                            ? (MyColors.textSize + 20)
                                            : 21,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 80, top: 0),
                              child: Text("-0.0400",
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontSize: fontsmall
                                        ? (MyColors.textSize - 16) * (-1)
                                        : fontlarge
                                            ? (MyColors.textSize + 16)
                                            : 16,
                                  )),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text("  By: Currency.wiki",
                                style: GoogleFonts.roboto(
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontsmall
                                      ? (MyColors.textSize - 18) * (-1)
                                      : fontlarge
                                          ? (MyColors.textSize + 18)
                                          : 18,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                    child: Text("Visual Size",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    //  margin: EdgeInsets.only(right: 22),
                    height: 50,
                    width: width * .92,
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: MyColors.textColor),
                            value: fontsmall,
                            onChanged: (value) {
                              setState(() {
                                if (fontlarge || fontmedium) {
                                  fontsmall = true;
                                  fontlarge = false;
                                  fontmedium = false;
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text("A",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: MyColors.textColor,
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: Colors.white),
                            value: fontmedium,
                            onChanged: (value) {
                              setState(() {
                                if (fontsmall || fontlarge) {
                                  fontsmall = false;
                                  fontlarge = false;
                                  fontmedium = true;
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text(
                          "A",
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: MyColors.textColor),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: MyColors.textColor),
                            value: fontlarge,
                            onChanged: (value) {
                              setState(() {
                                if (fontsmall || fontmedium) {
                                  fontsmall = false;
                                  fontlarge = true;
                                  fontmedium = false;
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text(
                          "A",
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: MyColors.textColor),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                    child: Text("App Logo Launcher",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                    height: 85,
                    width: 380,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 5, left: 2),
                                child: Text("Multi-Convertor",
                                    style: GoogleFonts.roboto(
                                        fontSize: fontsmall
                                            ? (MyColors.textSize - 18) * (-1)
                                            : fontlarge
                                                ? (MyColors.textSize + 18)
                                                : 18,
                                        color: MyColors.textColor,
                                        fontWeight: FontWeight.bold))),
                            Container(
                              width: 30,
                              height: 10,
                              margin: EdgeInsets.only(top: 2, left: 2),
                              child: Switch(
                                inactiveTrackColor: Colors.grey,
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    // print(isSwitched);
                                  });
                                },
                                activeTrackColor: Color(0xff7986cb),
                                activeColor: Colors.white,
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
                        RichText(
                            text: TextSpan(
                                text: "Will open multi-converter by default. ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: MyColors.textColor),
                                children: <TextSpan>[
                              TextSpan(
                                text: "NOTE:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: MyColors.textColor),
                              ),
                              TextSpan(
                                text:
                                    "This feature only works with app logo launcher",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: MyColors.textColor),
                              )
                            ])),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                    child: Text("Display",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
                    height: height * .25,
                    width: width * .92,
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Text("Display Currency Code",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              value: displaycode,
                              onChanged: (value) {
                                setState(() {
                                  if (displayflag) {
                                    if (displaysymbol) {
                                      displaysymbol = false;
                                      displaycode = true;
                                    } else
                                      displaycode = !displaycode;
                                  } else if (displaycode) {
                                  } else {
                                    displaycode = true;
                                    displaysymbol = false;
                                  }

                                  // print(isSwitched);
                                });
                              },
                              activeTrackColor: Color(0xff7986cb),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Text("Display Currency Symbol",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              value: displaysymbol,
                              onChanged: (value) {
                                setState(() {
                                  if (displayflag) {
                                    if (displaycode) {
                                      displaysymbol = true;
                                      displaycode = false;
                                    } else
                                      displaysymbol = !displaysymbol;
                                  } else if (displaysymbol) {
                                  } else if (displaysymbol && !displayflag) {
                                  } else {
                                    displaysymbol = true;
                                    displaycode = false;
                                  }
                                });
                              },
                              activeTrackColor: Color(0xff7986cb),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Text("Display Currency Flag",
                                  style: GoogleFonts.roboto(
                                      fontSize: fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              value: displayflag,
                              onChanged: (value) {
                                setState(() {
                                  if (!displaycode && !displaysymbol) {
                                  } else
                                    displayflag = !displayflag;
                                  // print(isSwitched);
                                });
                              },
                              activeTrackColor: Color(0xff7986cb),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 13, top: 20),
                    child: Text("Data Format",
                        style: GoogleFonts.roboto(
                            fontSize: fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(bottom: 24),
                    height: 55,
                    width: width * .92,
                    padding:
                        EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: const BorderSide(color: Colors.white),
                            value: checkBoxValue1,
                            onChanged: (value) {
                              setState(() {
                                if (checkBoxValue2) {
                                  checkBoxValue1 = !checkBoxValue1;
                                  checkBoxValue2 = !checkBoxValue2;
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text("mm/dd/yy",
                            style: GoogleFonts.roboto(
                              fontSize: fontsmall
                                  ? (MyColors.textSize - 16) * (-1)
                                  : fontlarge
                                      ? (MyColors.textSize + 16)
                                      : 16,
                              color: MyColors.textColor,
                            )),
                        const SizedBox(
                          width: 35,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: Colors.white),
                            value: checkBoxValue2,
                            onChanged: (value) {
                              setState(() {
                                if (checkBoxValue1) {
                                  checkBoxValue2 = !checkBoxValue2;
                                  checkBoxValue1 = !checkBoxValue1;
                                }
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            tristate: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text(
                          "dd/mm/yy",
                          style: GoogleFonts.roboto(
                              fontSize: fontsmall
                                  ? (MyColors.textSize - 16) * (-1)
                                  : fontlarge
                                      ? (MyColors.textSize + 16)
                                      : 16,
                              color: MyColors.textColor),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  void unlockchangeColor(Color color) {
    var code = (color.value.toRadixString(16));
    MyColors.firstthemecolorgr = Color(int.parse("0x$code"));

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

  void showColorPickerDialog(BuildContext context) async {
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
            child: Center(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 15, right: 10, bottom: 0, left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.82,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ColorPickerDialog(
                    onColorSelect: onColorSelect,
                    densitychangeColor: densitychangeColor,
                    lockchangeColor: lockchangeColor,
                    unlockchangeColor: unlockchangeColor,
                    densityCurrentColor: densityCurrentColor,
                    lockCurrentColor: lockCurrentColor,
                    unlockCurrentColor: unlockCurrentColor,
                  )),
            ),
          );
        });
  }
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
  final Function(Color color) unlockchangeColor;
  final Function(Color color) densitychangeColor;
  final Function(Color color) lockchangeColor;
  final Function(Color color, BuildContext context) onColorSelect;
  final Color unlockCurrentColor;
  final Color lockCurrentColor;
  final Color densityCurrentColor;

  const ColorPickerDialog(
      {required this.onColorSelect,
      required this.lockchangeColor,
      required this.densitychangeColor,
      required this.unlockchangeColor,
      required this.densityCurrentColor,
      required this.lockCurrentColor,
      required this.unlockCurrentColor,
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
  ];

  @override
  void initState() {
    unlockCurrentColor = widget.unlockCurrentColor;
    lockCurrentColor = widget.lockCurrentColor;
    densityCurrentColor = widget.densityCurrentColor;
    selectedColor = MColor(
        mainColor: unlockCurrentColor, densityColors: [densityCurrentColor]);
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
          child: const Text(
            "Unlocked ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.height * 0.089,
          child: Container(
            width: 400,
            height: 50,
            child: UnlockColorPicker(
              pickerColor: selectedColor,
              onColorChanged: unlockchangeColor,
              availableColors: colors,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 5),
          child: Text(
            "Locked",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Center(
          child: Container(
            width: width * 0.8,
            height: height * 0.35,
            child: LockColorPicker(
              pickerColor: lockCurrentColor,
              onColorChanged: lockchangeColor,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: width * 0.87,
            height: height * 0.089,
            child: DensityColorPicker(
                pickerColor: densityCurrentColor,
                onColorChanged: densitychangeColor,
                availableColors: selectedColor.densityColors),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  var code = (selectedColor.mainColor.value.toRadixString(16));
                  print(code);
                  MyColors.firstthemecolorgr = Color(int.parse("0x$code"));

                  setState(() {});
                },
                child: Text("Custom"),
              ),
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  var code = (selectedColor.mainColor.value.toRadixString(16));
                  MyColors.firstthemecolorgr = Color(int.parse("0x$code"));
                  // Navigator.pop(context);
                  widget.onColorSelect(selectedColor.mainColor, context);
                },
                child: Text("Add"),
              ),
            ),
          ],
        )
      ],
    );
  }

  void unlockchangeColor(MColor color) {
    selectedColor = color;
    setState(
      () => unlockCurrentColor = color.mainColor,
    );
    // widget.unlockchangeColor(color.mainColor);
  }

  void lockchangeColor(Color color) {
    setState(() => lockCurrentColor = color);
    debugPrint("selected color -> ${lockCurrentColor.value.toRadixString(16)}");
  }

  void densitychangeColor(Color color) {
    var code = (color.value.toRadixString(16));
    MyColors.firstthemecolorgr = Color(int.parse("0x$code"));

    setState(
      () => unlockCurrentColor = color,
    );
    setState(() => densityCurrentColor = color);
    widget.densitychangeColor(color);
    debugPrint(
        "selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }
}

class MColor {
  Color mainColor;
  List<Color> densityColors;

  MColor({required this.mainColor, required this.densityColors});
}
