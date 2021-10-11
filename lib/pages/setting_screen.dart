import 'dart:ui';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/language/language.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors_properties/lockcolorpicker.dart';
import '../colors_properties/densitycolorpicker.dart';
import '../colors_properties/unlockcolorpicker.dart';
import '../colors_properties/customcolorpicker.dart';
import 'home/home_page.dart';

class SettingScreen extends StatefulWidget {
  final Function onThemeChange;

  const SettingScreen(this.onThemeChange, {Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}



class _SettingScreenState extends State<SettingScreen> {
  bool lockedcolortry=false;
  bool unclockcolorselect =false;
  Color color = Colors.red;

  bool isSwitched = false;
  bool isMultiConverter=true;

  bool displaycode = false;
  bool displaysymbol = true;
  bool displayflag = true;

  bool customcolorbool = false;

  Color unlockCurrentColor = MyColors.colorPrimary;
  Color lockCurrentColor = const Color(0xff443a49);
  Color densityCurrentColor = MyColors.colorPrimary;

  double _value = 0.0;
  double x = 0.0;

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
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only( bottom: 13),
                    child: Text("removeAds".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                  // margin: EdgeInsets.only(right: 20),
                  width: width * .92,

                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "removeAdsContent".tr().toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 15) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 15)
                                        : 15,
                                color: MyColors.textColor),
                          ),

                        ])),
                      ),
                      Container(
                        width: 30,
                        height: 10,
                        margin: const EdgeInsets.all(5),
                        child: Switch(
                          inactiveTrackColor: Colors.grey,
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
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
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
                        GestureDetector(
                          onTap:(){
                            showBottomSheetForLanguage(context);
                        }
                          ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("english".tr().toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: MyColors.fontsmall
                                        ? (MyColors.textSize - 18) * (-1)
                                        : MyColors.fontlarge
                                            ? (MyColors.textSize + 18)
                                            : 18,
                                    color: MyColors.textColor,
                                  )),
                              //  SizedBox(width: 245 ,),
                              Icon(
                                Icons.expand_more_outlined,
                                color: MyColors.textColor,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: MyColors.textColor,
                          thickness: 1.2,
                        )
                      ],
                    )),
                Container(
                    margin:
                        const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                    child: Text("colorsSelection".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                InkWell(
                  onTap: () async {
                    int x = await showColorPickerDialog(context);
                    print(x);
                    if (x == 1) showCustomColorPickerDialog(context);
                  },
                  child: Container(
                      // margin: EdgeInsets.only(right: 22),
                      height: 50,
                      width: width * .92,
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
                          border:
                              Border.all(width: 1.2, color: MyColors.textColor),
                        ),
                        child: const Text(""),
                      )),
                ),
                Container(
                    margin:
                        const EdgeInsets.only(left: 0, bottom: 13, top: 20),
                    child: Text("theme".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    height: 55,
                    width: width * .92,
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
                              scale: 1.1,
                              child: Checkbox(
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.checkBoxValue1,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.checkBoxValue2) {
                                      MyColors.checkBoxValue1 =
                                          !MyColors.checkBoxValue1;
                                      MyColors.checkBoxValue2 =
                                          !MyColors.checkBoxValue2;
                                      MyColors.textColor = Colors.white;
                                      MyColors.insideTextFieldColor =
                                          Colors.black54;
                                      MyColors.calcuColor =
                                          MyColors.colorPrimary;

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyTabBarWidget()),
                                          (route) => false);
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text("light".tr().toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 20) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 20)
                                          : 20,
                                  color: MyColors.textColor,
                                )),
                          ],
                        ),

                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.checkBoxValue2,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.checkBoxValue1) {
                                      MyColors.checkBoxValue2 =
                                          !MyColors.checkBoxValue2;
                                      MyColors.checkBoxValue1 =
                                          !MyColors.checkBoxValue1;
                                      MyColors.textColor = Colors.black54;
                                      MyColors.insideTextFieldColor = Colors.white;
                                      MyColors.calcuColor = Colors.black87;

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyTabBarWidget()),
                                          (route) => false);
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text(
                              "dark".tr().toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 20) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 20)
                                          : 20,
                                  color: MyColors.textColor),
                            ),
                          ],
                        )
                      ],
                    )),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                          left: 0,
                        ),
                        child: Text(
                          "widgetTransparency".tr().toString(),
                          style: GoogleFonts.roboto(
                              fontSize: MyColors.fontsmall
                                  ? (MyColors.textSize - 20) * (-1)
                                  : MyColors.fontlarge
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
                  margin: const EdgeInsets.only(right: 0, top: 15),

                  width: width * .92,
                  padding: const EdgeInsets.only(
                      top: 5, left: 0, right: 0, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(

                        children: [
                          Container(
                            width: width * 0.31,
                            child: Slider(
                                activeColor: MyColors.textColor,
                                inactiveColor: MyColors.textColor,
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
                          SizedBox(
                            width: 30,
                            child: Text(
                              x.toStringAsFixed(1),
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontSize: MyColors.fontsmall
                                    ? (MyColors.textSize - 15) * (-1)
                                    : MyColors.fontlarge
                                        ? (MyColors.textSize + 15)
                                        : 15,
                              ),
                            ),
                          ),

                       Container(
                          width: width * 0.5,


                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.69),
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    MyColors.colorPrimary,
                                    MyColors.firstthemecolorgr1,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.1, 1.5]),
                              border: Border.all(
                                  color: MyColors.textColor, width: 3.9)),
                          child: Container(
                            color: Colors.white.withOpacity(x as double),
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 700),
                              opacity:1,


                              child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.flag,
                                      size: 30,
                                    ),
                                    Text(
                                      "USD",
                                      style: GoogleFonts.roboto(
                                          fontSize: MyColors.fontsmall
                                              ? (MyColors.textSize - 20) * (-1)
                                              : MyColors.fontlarge
                                                  ? (MyColors.textSize + 20)
                                                  : 20,
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "/",
                                      style: GoogleFonts.roboto(
                                          fontSize: MyColors.fontsmall
                                              ? (MyColors.textSize - 18) * (-1)
                                              : MyColors.fontlarge
                                                  ? (MyColors.textSize + 18)
                                                  : 18,
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.flag,
                                      size: 30,
                                    ),
                                    Text(
                                      "EUR",
                                      style: GoogleFonts.roboto(
                                          fontSize: MyColors.fontsmall
                                              ? (MyColors.textSize - 20) * (-1)
                                              : MyColors.fontlarge
                                                  ? (MyColors.textSize + 20)
                                                  : 20,
                                          color: MyColors.textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 50, top: 0),
                                  child: Text("0.7895",
                                      style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 20) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 20)
                                                : 20,
                                      )),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 80, top: 0),
                                  child: Text("-0.0400",
                                      style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 16) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 16)
                                                : 16,
                                      )),
                                ),
                                const SizedBox(height: 5),

                                Text("  By: Currency.wiki",
                                    style: GoogleFonts.roboto(
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MyColors.fontsmall
                                          ? (MyColors.textSize - 16) * (-1)
                                          : MyColors.fontlarge
                                              ? (MyColors.textSize + 16)
                                              : 16,
                                    ))
                              ],
                            ),),
                          )
                        ),

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 0, bottom: 13, top: 20),
                    child: Text("visualSize".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    //  margin: EdgeInsets.only(right: 22),
                    height: 50,
                    width: width * .92,
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
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.fontsmall,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.fontlarge || MyColors.fontmedium) {
                                      MyColors.fontsmall = true;
                                      MyColors.fontlarge = false;
                                      MyColors.fontmedium = false;
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
                            Text("A".tr().toString(),
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
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.fontmedium,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.fontsmall || MyColors.fontlarge) {
                                      MyColors.fontsmall = false;
                                      MyColors.fontlarge = false;
                                      MyColors.fontmedium = true;
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text(
                              "A".tr().toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 18, color: MyColors.textColor),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.fontlarge,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.fontsmall || MyColors.fontmedium) {
                                      MyColors.fontsmall = false;
                                      MyColors.fontlarge = true;
                                      MyColors.fontmedium = false;
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text(
                              "A".tr().toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: MyColors.textColor),
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5, top: 25),
                    child: Text("appLogoLauncher".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(right: 15, top: 8, bottom: 5),
                    height: 90,
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
                                child: Text("multiConverter".tr().toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 18) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 18)
                                                : 18,
                                        color: MyColors.textColor,
                                        fontWeight: FontWeight.bold))),
                            Container(
                              width: 30,
                              height: 10,
                              margin: EdgeInsets.only(top: 2, left: 0),
                              child: Switch(
                                inactiveTrackColor: Colors.grey,
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
                        RichText(
                            text: TextSpan(
                                text: "multiConverterContent1".tr().toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: MyColors.textColor),
                                children: <TextSpan>[
                              TextSpan(
                                text: "multiConverterContent2".tr().toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: MyColors.textColor),
                              ),
                              TextSpan(
                                text:
                                    "multiConverterContent3".tr().toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: MyColors.textColor),
                              )
                            ])),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 0, bottom: 5, top: 25),
                    child: Text("display".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: MyColors.textColor,
                            fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(right: 0, top: 8, bottom: 5),
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
                              child: Text("display1".tr().toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: MyColors.fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : MyColors.fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: MyColors.textColor,
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
                              activeTrackColor: MyColors.colorPrimary,
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
                              child: Text("display2".tr().toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: MyColors.fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : MyColors.fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: MyColors.textColor,
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
                              activeTrackColor: MyColors.colorPrimary,
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
                                  style: GoogleFonts.roboto(
                                      fontSize: MyColors.fontsmall
                                          ? (MyColors.textSize - 18) * (-1)
                                          : MyColors.fontlarge
                                              ? (MyColors.textSize + 18)
                                              : 18,
                                      color: MyColors.textColor,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Switch(
                              inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: MyColors.textColor,
                              value: displayflag,
                              onChanged: (value) {
                                setState(() {
                                  if (!displaycode && !displaysymbol) {
                                  } else
                                    displayflag = !displayflag;
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
                Container(
                    margin: EdgeInsets.only(left: 0, bottom: 13, top: 20),
                    child: Text("dateFormat".tr().toString(),
                        style: GoogleFonts.roboto(
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.datedd,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.datemm) {
                                      MyColors.datemm = !MyColors.datemm;
                                      MyColors.datedd = !MyColors.datedd;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyTabBarWidget()),
                                          (route) => false);
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text("mm/dd/yy",
                                style: GoogleFonts.roboto(
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 16) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 16)
                                          : 16,
                                  color: MyColors.textColor,
                                )),
                          ],
                        ),

                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                side: BorderSide(color: MyColors.textColor),
                                value: MyColors.datemm,
                                onChanged: (value) {
                                  setState(() {
                                    if (MyColors.datedd) {
                                      MyColors.datedd = !MyColors.datedd;
                                      MyColors.datemm = !MyColors.datemm;

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyTabBarWidget()),
                                          (route) => false);
                                    }
                                  });
                                },
                                activeColor: MyColors.checkBoxValue2
                                    ? Colors.black45
                                    : Colors.white,
                                checkColor: Colors.black,
                                tristate: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Text(
                              "dd/mm/yy",
                              style: GoogleFonts.roboto(
                                  fontSize: MyColors.fontsmall
                                      ? (MyColors.textSize - 16) * (-1)
                                      : MyColors.fontlarge
                                          ? (MyColors.textSize + 16)
                                          : 16,
                                  color: MyColors.textColor),
                            ),
                          ],
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
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 15, right: 10, bottom: 0, left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
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
                    unlockCurrentColor: unlockCurrentColor, unlockColorSelect: lockedcolortry,
                  )),
            ),
          );
        });
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
            child: Center(
              child: Container(

                margin: const EdgeInsets.only(
                    top: 60, right: 10, bottom: 80, left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 6.77,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomColorPicker(),
              ),
            ),
          );
        });
  }

  void showBottomSheetForLanguage(BuildContext context)async {
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
                    top: 60, right: 10, bottom: 80, left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 6.77,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:Language(),
              ),
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
  Color densitySelectedColor=Colors.red;
  bool density=false;
  bool lock=false;
  @override
  void initState() {
    unlockCurrentColor = widget.unlockCurrentColor;
    lockCurrentColor = widget.lockCurrentColor;
    densityCurrentColor = widget.densityCurrentColor;
    selectedColor = MColor(
        mainColor: Colors.white, densityColors: [ Colors.lightBlue.shade50,
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade500,
      Colors.lightBlue.shade600,
      Colors.lightBlue.shade900]);
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
          margin: const EdgeInsets.only(left: 25),
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
          margin: EdgeInsets.only(left: 20, top: 5),
          child: const Text(
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
                          if(lock) {
                            MyColors.colorPrimary=lockSelectdColor!;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyTabBarWidget()),
                                    (route) => false);
                          }
                          else if (density)
                            {


                              MyColors.colorPrimary=densitySelectedColor;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MyTabBarWidget()),
                                      (route) => false);
                            }

                        },
                        child: Text(
                          "Try this color",
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
                          "Unlock",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              )
            : Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10,top: 10, ),

              width: width * 0.31,
              height: height * 0.05,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 1);
                  setState(() {});
                },
                child: const Text(
                  "CUSTOM",
                  style: TextStyle(
                      letterSpacing: 1.9,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            widget.unlockColorSelect? Container(
              margin: EdgeInsets.only(top: 10, ),
              width: width * 0.25,
              height: height * 0.05,
              child: GestureDetector(
                onTap: () { 
                MyColors.colorPrimary=unlockSelectdColor!;
                Utility.setStringPreference(Constants.themeColor , unlockSelectdColor!.value.toString());
                themepicker(unlockSelectdColor!.value.toString());

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MyTabBarWidget()),
                        (route) => false);

                  setState(() {});
                },
                child: const Text(
                  "SELECT",
                  style: TextStyle(
                      letterSpacing: 1.9,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ):Text(""),
          ],
        )
      ],
    );
  }

  void unlockchangeColor(MColor color) {
    widget.lockedColor=false;
    widget.unlockColorSelect=true;
    var code = (color.mainColor.value.toRadixString(16));
    unlockSelectdColor=Color(int.parse("0x$code"));
    selectedColor = color;
    setState(
      () => unlockCurrentColor = color.mainColor,
    );
    // widget.unlockchangeColor(color.mainColor);
  }

  void lockchangeColor(Color color) {
    lock=true;
    widget.unlockColorSelect=false;
   widget.lockedColor=true;
   var code = (color.value.toRadixString(16));
lockSelectdColor = Color(int.parse("0x$code"));

   setState(
         () => lockCurrentColor = color,
   );



  }

  void densitychangeColor(Color color) {
    widget.lockedColor=true ;
    density=true;
    var code = (color.value.toRadixString(16));
densitySelectedColor = Color(int.parse("0x$code"));

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