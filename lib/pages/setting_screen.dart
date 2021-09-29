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

import '../lockcolorpicker.dart';
import '../densitycolorpicker.dart';
import '../unlockcolorpicker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
  Color unlockPickerColor = const Color(0xff443a49);
  Color unlockCurrentColor = const Color(0xff443a49);
  Color lockPickerColor = const Color(0xff443a49);
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityPickerColor = const Color(0xff443a49);
  Color densityCurrentColor = const Color(0xff443a49);

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
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyColors.firstthemecolorgr1,
                    MyColors.firstthemecolorgr ,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.001, 1.5])
              ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 13),
                    child: Text("Remove Ads",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
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
                              text: const TextSpan(children: [
                            TextSpan(
                              text: "Support our project  with a small yearly",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                            TextSpan(
                              text: "\n subscription",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 15),
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
                            fontSize: 20,
                            color: Colors.white,
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
                                  fontSize: 18,
                                  color: Colors.white,
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
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                InkWell(
                  onTap: () {
                    print("vivek");
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
                          gradient:  LinearGradient(
                              colors: [MyColors.firstthemecolorgr,
                                MyColors.firstthemecolorgr,],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 0.1]),
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
                            fontSize: 20,
                            color: Colors.white,
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
                        Text("Light",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 50,
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
                          "Dark",
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.white),
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
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Icon(
                      Icons.info,
                      color: Colors.white,
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
                                style: const TextStyle(color: Colors.white),
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
                                colors:  [
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
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "/",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.white,
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
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 50, top: 0),
                              child: Text("0.7895",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 80, top: 0),
                              child: Text("-0.0400",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            AutoSizeText(
                              "  By: Currency.wiki",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxFontSize: 18,
                              minFontSize: 16,
                            )
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
                            fontSize: 20,
                            color: Colors.white,
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
                            side: BorderSide(color: Colors.white),
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
                              color: Colors.white,
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
                              fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            side: BorderSide(color: Colors.white),
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
                              fontSize: 20, color: Colors.white),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                    child: Text("App Logo Launcher",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
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
                                        fontSize: 18,
                                        color: Colors.white,
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
                                    fontSize: 11),
                                children: const <TextSpan>[
                              TextSpan(
                                text: "NOTE:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                    "This feature only works with app logo launcher",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11),
                              )
                            ])),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                    child: Text("Display",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
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
                                      fontSize: 18,
                                      color: Colors.white,
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
                                      fontSize: 18,
                                      color: Colors.white,
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
                                      fontSize: 18,
                                      color: Colors.white,
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
                            fontSize: 20,
                            color: Colors.white,
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
                              fontSize: 16,
                              color: Colors.white,
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
                              fontSize: 16, color: Colors.white),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  void unlockchangeColor(Color color) {

    //MyColors.firstthemecolorgr = Color(int.parse("0x$code"));
    setState(
      () => unlockPickerColor = color,
    );

    debugPrint(
        "unlock in behja -> ${unlockPickerColor.value.toRadixString(16)}");
  }

  void lockchangeColor(Color color) {
    setState(() => lockPickerColor = color);
    debugPrint("selected color -> ${lockPickerColor.value.toRadixString(16)}");
  }

  void densitychangeColor(Color color) {
    setState(() => densityPickerColor = color);
    debugPrint(
        "selected color -> ${densityPickerColor.value.toRadixString(16)}");
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25, top: 30, bottom: 0),
                        child: const Text(
                          "Unlocked ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        height: MediaQuery.of(context).size.height * 0.089,
                        child: Container(
                          width: 400,
                          height: 50,
                          child: UnlockColorPicker(
                            pickerColor: unlockCurrentColor,
                            onColorChanged: unlockchangeColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        child: Text(
                          "Locked",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                            pickerColor: unlockPickerColor,
                            onColorChanged: densitychangeColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 60 ,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Container(
                            width: 100,

                            child: ElevatedButton(


                              onPressed: (){
                                var code = (unlockPickerColor.value.toRadixString(16));
                                print(code);
                                MyColors.firstthemecolorgr = Color(int.parse("0x$code"));

                                setState(() {


                                });


                              },
                              child: Text("Custom"),
                            ),
                          ),


                          Container(
                            width: 100,


                            child: ElevatedButton(


                              onPressed: (){
                                var code = (unlockPickerColor.value.toRadixString(16));
                                print(code);
                                MyColors.firstthemecolorgr = Color(int.parse("0x$code"));

                                setState(() {


                                });


                              },
                              child: Text("Add"),
                            ),
                          ),
                        ],
                      )
                    ],
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
