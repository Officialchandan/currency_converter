import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/painting.dart';
import 'package:share/share.dart';

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

  List<String> radiMonetaryFormat = [
    "1234.56",
    "1.234,56",
    "1 234.56",
    "1 234,56",
  ];

  List<String> radiDecimalFormat = [
    ".02",
    ".003",
    ".0004",
    ".00005",
    ".0000006",
    "dontShow".tr().toString()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies -> home tab ");

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DecimalScreens oldWidget) {
    debugPrint("home_tab-> didUpdateWidget");

    super.didUpdateWidget(oldWidget);
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
              textShow(MyColors.text),
              style: TextStyle(
                color: MyColors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: MyColors.fontsmall
                    ? (MyColors.textSize - 26) * (-1)
                    : MyColors.fontlarge
                        ? (MyColors.textSize + 26)
                        : 26,
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
                    children: [
                      Text(
                        "monetary".tr().toString(),
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: num,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            height: 38,
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(color: MyColors.textColor),
                                  value: MyColors.boolMonetaryFormate[index],
                                  onChanged: (value) {
                                    int j = 0;
                                    setState(() {
                                      MyColors.boolMonetaryFormate
                                          .forEach((element) {
                                        if (index == j) {
                                          Utility.setMonetaryValuePreference(
                                              "MonetaryValue", (index + 1));

                                          MyColors.monetaryFormat = index + 1;
                                          format2();
                                          if (MyColors.decimalFormat == 6) {
                                            MyColors.text = MyColors.text +
                                                radiDecimalFormat[4];
                                          }
                                          if (MyColors.decimalFormat == 5) {
                                            MyColors.text = MyColors.text +
                                                radiDecimalFormat[3];
                                          }
                                          if (MyColors.decimalFormat == 4) {
                                            MyColors.text = MyColors.text +
                                                radiDecimalFormat[2];
                                          }
                                          if (MyColors.decimalFormat == 3) {
                                            MyColors.text = MyColors.text +
                                                radiDecimalFormat[1];
                                          }
                                          if (MyColors.decimalFormat == 2) {
                                            MyColors.text = MyColors.text +
                                                radiDecimalFormat[0];
                                          }

                                          MyColors.boolMonetaryFormate[j] =
                                              true;
                                        } else
                                          MyColors.boolMonetaryFormate[j] =
                                              false;

                                        j++;
                                      });
                                    });
                                  },
                                  activeColor: MyColors.checkBoxValue2
                                      ? Colors.black
                                      : Colors.white,
                                  checkColor: MyColors.colorPrimary,
                                  tristate: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Text("${radiMonetaryFormat[index]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 20) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 20)
                                                : 20,
                                        color: MyColors.textColor)),
                              ],
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
                    children: [
                      Text(
                        "decimal".tr().toString(),
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: MyColors.fontsmall
                                ? (MyColors.textSize - 20) * (-1)
                                : MyColors.fontlarge
                                    ? (MyColors.textSize + 20)
                                    : 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            height: 38,
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(color: MyColors.textColor),
                                  value: MyColors.boolDecimalFormate[index],
                                  onChanged: (value) {
                                    int i = 0;
                                    setState(() {
                                      for (var element
                                          in MyColors.boolDecimalFormate) {
                                        if (index == i) {
                                          if (index == 5) {
                                            Utility.setDecimalValuePreference(
                                                "DecimalValue", 0);
                                            MyColors.boolDecimalFormate[i] =
                                                true;
                                            MyColors.decimalFormat = 0;
                                            format2();
                                          } else {
                                            Utility.setDecimalValuePreference(
                                                "DecimalValue", (index + 2));
                                            MyColors.decimalFormat = index + 2;
                                            MyColors.boolDecimalFormate[i] =
                                                true;
                                            //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>MyTabBarWidget()), (route) => false);
                                            format2();
                                            if (MyColors.decimalFormat == 2) {
                                              MyColors.text = MyColors.text +
                                                  radiDecimalFormat[index];
                                            }
                                            if (MyColors.decimalFormat == 3) {
                                              MyColors.text = MyColors.text +
                                                  radiDecimalFormat[index];
                                            }
                                            if (MyColors.decimalFormat == 4) {
                                              MyColors.text = MyColors.text +
                                                  radiDecimalFormat[index];
                                            }
                                            if (MyColors.decimalFormat == 5) {
                                              MyColors.text = MyColors.text +
                                                  radiDecimalFormat[index];
                                            }
                                            if (MyColors.decimalFormat == 6) {
                                              MyColors.text = MyColors.text +
                                                  radiDecimalFormat[index];
                                            }
                                            setState(() {});
                                          }
                                        } else {
                                          MyColors.boolDecimalFormate[i] =
                                              false;
                                        }

                                        i++;
                                      }
                                    });
                                  },
                                  activeColor: MyColors.checkBoxValue2
                                      ? Colors.black
                                      : Colors.white,
                                  checkColor: MyColors.colorPrimary,
                                  tristate: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Text("${radiDecimalFormat[index]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MyColors.fontsmall
                                            ? (MyColors.textSize - 20) * (-1)
                                            : MyColors.fontlarge
                                                ? (MyColors.textSize + 20)
                                                : 20,
                                        color: MyColors.textColor)),
                              ],
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
