import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

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
    "12334.56",
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
    "Don't show "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, color: MyColors.textColor)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                width: 180,
                child: Column(
                  children: [
                    Text(
                      "monetary".tr().toString(),
                      style: TextStyle(color: MyColors.textColor, fontSize: 20),
                    ),
                    SizedBox(
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
                                        MyColors.monetaryformat = index + 1;

                                        MyColors.boolMonetaryFormate[j] = true;
                                      } else
                                        MyColors.boolMonetaryFormate[j] = false;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MyTabBarWidget()),
                                          (route) => false);

                                      j++;
                                    });
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
                              Text("${radiMonetaryFormat[index]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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
                margin: EdgeInsets.only(top: 40),
                width: 180,
                child: Column(
                  children: [
                    Text(
                      "decimal".tr().toString(),
                      style: TextStyle(color: MyColors.textColor, fontSize: 20),
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
                                    MyColors.boolDecimalFormate
                                        .forEach((element) {
                                      if (index == i) {
                                        if (index == 5) {
                                          MyColors.decimalformat = 0;
                                        } else {
                                          MyColors.decimalformat = index + 2;
                                          MyColors.boolDecimalFormate[i] = true;
                                        }
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MyTabBarWidget()),
                                            (route) => false);
                                      } else {
                                        MyColors.boolDecimalFormate[i] = false;
                                      }

                                      i++;
                                    });
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
                              Text("${radiDecimalFormat[index]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController controller = TextEditingController();
  String text = "";
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 5,
    symbol: "",
  );
  int i = 2;
  int afterdecimal = MyColors.decimalformat;
  double amount = 500010354.456;
  @override
  void initState() {
    super.initState();
    CurrencyTextInputFormatter mformat = CurrencyTextInputFormatter(
      decimalDigits: afterdecimal,
      symbol: "",
    );
    if (i == 1) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", ",");
      log(text);
      text = text.replaceAll(".", ".");
      log(text);
    } else if (i == 2) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(".", " ");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(" ", ",");

      //text = text.replaceFirstMapped(".", (match) => "1");
    } else if (i == 3) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      text = text.replaceAll(".", "=");
      log(text);
      text = text.replaceAll(",", ".");
      log(text);
      text = text.replaceAll(".", " ");
      text = text.replaceAll("=", ".");

      log(text);
    } else if (i == 4) {
      text = mformat.format(amount.toString().replaceAll(".", ""));
      log(text);
      text = text.replaceAll(",", " ");
      log(text);
      text = text.replaceAll(".", ",");
      log(text);
    }

    setState(() {});
  }

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter();
  @override
  Widget build(BuildContext context) {
    print(formatter.getFormattedValue()); // $ 2,000
    print(formatter.getUnformattedValue()); // 2000.00
    print(formatter.format('2000'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: Column(children: [
          TextField(
            controller: controller,
            // inputFormatters: [CurrencyTextInputFormatter()],
            keyboardType: TextInputType.number,
            onChanged: (txt) {
              text = _formatter.format(txt);
              print("formated text -->$text");
              setState(() {});
            },
          ),
          Text("$text"),
        ]),
      ),
    );
  }
}
