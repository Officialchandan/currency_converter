import 'dart:developer';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:share/share.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecimalScreens extends StatefulWidget {
  const DecimalScreens({Key? key}) : super(key: key);

  @override
  _DecimalScreensState createState() => _DecimalScreensState();
}

class _DecimalScreensState extends State<DecimalScreens> {
  int value = -1;
  int value1 = -1;
  int num = 4;
  int num1 = 6;

  String monetary = "1";
  String decimal = "2";

  int demoIndex = 0;
  String demoText = "";

  List<Map<String, dynamic>> monetaryFormat = [
    {"format": "1234.56", "id": "1", "check": false},
    {"format": "1.234,56", "id": "2", "check": false},
    {"format": "1 234.56", "id": "3", "check": false},
    {"format": "1 234,56", "id": "4", "check": false},
  ];

  List<Map<String, dynamic>> decimalFormat = [
    {"format": ".02", "id": "2", "check": false},
    {"format": ".003", "id": "3", "check": false},
    {"format": ".0004", "id": "4", "check": false},
    {"format": ".00005", "id": "5", "check": false},
    {"format": ".000006", "id": "6", "check": false},
    {"format": "don_t_show".tr().toString(), "id": "0", "check": false},
  ];

  List<Map<String, dynamic>> demoString = [
    {"1_0": "123,456"},
    {"1_2": "123,456.02"},
    {"1_3": "123,456.003"},
    {"1_4": "123,456.0004"},
    {"1_5": "123,456.00005"},
    {"1_6": "123,456.000006"},
    {"2_0": "123.456"},
    {"2_2": "123.456,02"},
    {"2_3": "123.456,003"},
    {"2_4": "123.456,0004"},
    {"2_5": "123.456,00005"},
    {"2_6": "123.456,000006"},
    {"3_0": "123 456"},
    {"3_2": "123 456.02"},
    {"3_3": "123 456.003"},
    {"3_4": "123 456.0004"},
    {"3_5": "123 456.00005"},
    {"3_6": "123 456.000006"},
    {"4_0": "123 456"},
    {"4_2": "123 456,02"},
    {"4_3": "123 456,003"},
    {"4_4": "123 456,0004"},
    {"4_5": "123 456,00005"},
    {"4_6": "123 456,000006"},
  ];

  @override
  void initState() {
    super.initState();
    getFormat();
  }

  getFormat() async {
    monetary = await Utility.getStringPreference(Constants.monetaryFormat);
    decimal = await Utility.getStringPreference(Constants.decimalFormat);

    monetary = monetary == "" ? "1" : monetary;
    decimal = decimal == "" ? "2" : decimal;

    monetaryFormat
        .singleWhere((element) => element["id"] == monetary)["check"] = true;
    decimalFormat.singleWhere((element) => element["id"] == decimal)["check"] =
        true;

    Map<String, dynamic> f = demoString.singleWhere(
        (element) => element.containsKey("$monetary" "_" + "$decimal"));

    demoText = f["$monetary" + "_" + "$decimal"];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      onShareWithEmptyOrigin(context);
                    },
                    icon: Icon(Icons.share, color: MyColors.textColor)),
              ],
            ),
            Text(
              textShow("${demoText}"),
              textScaleFactor: Constants.textScaleFactor,
              style: TextStyle(
                color: MyColors.textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
                fontSize: 23,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 180,
                  height: 255,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "monetary_format".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: monetaryFormat.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (!monetaryFormat[index]["check"]) {
                                monetaryFormat[index]["check"] = true;
                                monetary = monetaryFormat[index]["id"];

                                for (var element in monetaryFormat) {
                                  element["check"] = false;
                                }

                                monetaryFormat.singleWhere((element) =>
                                    element["id"] == monetary)["check"] = true;

                                Utility.setStringPreference(
                                    Constants.monetaryFormat, monetary);

                                MyColors.monetaryFormat = int.parse(monetary);

                                Map<String, dynamic> f = demoString.singleWhere(
                                    (element) => element.containsKey(
                                        "$monetary" "_" + "$decimal"));

                                demoText = f["$monetary" + "_" + "$decimal"];

                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              width: 150,
                              height: 38,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  monetaryFormat[index]["check"]
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
                                    width: 10,
                                  ),

                                  // Checkbox(
                                  //   side: BorderSide(color: MyColors.textColor),
                                  //   value: monetaryFormat[index]["check"],
                                  //   onChanged: (value) {
                                  //     if (value!) {
                                  //       monetary = monetaryFormat[index]["id"];
                                  //
                                  //       for (var element in monetaryFormat) {
                                  //         element["check"] = false;
                                  //       }
                                  //
                                  //       monetaryFormat.singleWhere((element) => element["id"] == monetary)["check"] = true;
                                  //
                                  //       Utility.setStringPreference(Constants.monetaryFormat, monetary);
                                  //
                                  //       MyColors.monetaryFormat = int.parse(monetary);
                                  //
                                  //       Map<String, dynamic> f =
                                  //           demoString.singleWhere((element) => element.containsKey("$monetary" "_" + "$decimal"));
                                  //
                                  //       demoText = f["$monetary" + "_" + "$decimal"];
                                  //
                                  //       setState(() {});
                                  //     }
                                  //   },
                                  //   fillColor: MaterialStateProperty.all(
                                  //     MyColors.darkModeCheck ? Colors.black : Colors.white,
                                  //   ),
                                  //   activeColor: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                  //   checkColor: MyColors.colorPrimary.withOpacity(0.50),
                                  //   tristate: false,
                                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  // ),
                                  SizedBox(
                                    width: 84,
                                    child: AutoSizeText(
                                      "${monetaryFormat[index]["format"]}",
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: MyColors.textColor),
                                      maxFontSize: 20,
                                      minFontSize: 16,
                                    ),
                                  ),
                                  // Text("${monetaryFormat[index]["format"]}",
                                  //     textScaleFactor: Constants.textScaleFactor,
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold, fontSize: 17, letterSpacing: 0.6, color: MyColors.textColor)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "decimal_format".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: decimalFormat.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (!decimalFormat[index]["check"]) {
                                decimalFormat[index]["check"] = true;
                                decimal = decimalFormat[index]["id"];

                                for (var element in decimalFormat) {
                                  element["check"] = false;
                                }

                                decimalFormat.singleWhere((element) =>
                                    element["id"] == decimal)["check"] = true;

                                Utility.setStringPreference(
                                    Constants.decimalFormat, decimal);

                                MyColors.decimalFormat = int.parse(decimal);

                                Map<String, dynamic> f = demoString.singleWhere(
                                    (element) => element.containsKey(
                                        "$monetary" "_" + "$decimal"));

                                demoText = f["$monetary" + "_" + "$decimal"];

                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              width: 150,
                              height: 38,
                              child: Row(
                                children: [
                                  decimalFormat[index]["check"]
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
                                    width: 10,
                                  ),
                                  // Checkbox(
                                  //   side: BorderSide(color: MyColors.textColor),
                                  //   value: decimalFormat[index]["check"],
                                  //   onChanged: (value) {
                                  //     if (value!) {
                                  //       decimal = decimalFormat[index]["id"];
                                  //
                                  //       for (var element in decimalFormat) {
                                  //         element["check"] = false;
                                  //       }
                                  //
                                  //       decimalFormat.singleWhere((element) => element["id"] == decimal)["check"] = true;
                                  //
                                  //       Utility.setStringPreference(Constants.decimalFormat, decimal);
                                  //
                                  //       MyColors.decimalFormat = int.parse(decimal);
                                  //
                                  //       Map<String, dynamic> f =
                                  //           demoString.singleWhere((element) => element.containsKey("$monetary" "_" + "$decimal"));
                                  //
                                  //       demoText = f["$monetary" + "_" + "$decimal"];
                                  //
                                  //       setState(() {});
                                  //     }
                                  //   },
                                  //   activeColor: MyColors.darkModeCheck ? Colors.black : Colors.white,
                                  //   checkColor: MyColors.colorPrimary.withOpacity(0.50),
                                  //   tristate: false,
                                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  // ),
                                  Container(
                                    width: 130,
                                    child: AutoSizeText(
                                      "${decimalFormat[index]["format"]}",
                                      textScaleFactor:
                                          Constants.textScaleFactor,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          letterSpacing: 0.6,
                                          color: MyColors.textColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  format2() {
    int i = MyColors.monetaryFormat;
    int afterdecimal = 0;
    int amount = MyColors.formatDemo;
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      MyColors.text = mformat.format(amount.toString().replaceAll(".", ""));
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(",", ",");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(".", ".");
      log(MyColors.text);
    } else if (i == 2) {
      MyColors.text = mformat.format(amount.toString().replaceAll(".", ""));
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(".", " ");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(",", ".");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(" ", ",");

      //MyColors.text = MyColors.text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      MyColors.text = mformat.format(amount.toString().replaceAll(".", ""));
      MyColors.text = MyColors.text.replaceAll(".", "=");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(",", ".");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(".", " ");
      MyColors.text = MyColors.text.replaceAll("=", ".");

      log(MyColors.text);
    } else if (i == 4) {
      MyColors.text = mformat.format(amount.toString().replaceAll(".", ""));
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(",", " ");
      log(MyColors.text);
      MyColors.text = MyColors.text.replaceAll(".", ",");
      log(MyColors.text);
    }

    setState(() {});
  }

  onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share(
        "https://play.google.com/store/apps/details?id=com.tencent.ig");
  }

  String textShow(String text) {
    Utility.setFormatExmaplePreference("FormatExmaple", text);
    return text;
  }
}
