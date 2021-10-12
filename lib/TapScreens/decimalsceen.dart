import 'dart:developer';

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/painting.dart';

class DecimalScreens extends StatefulWidget {
  const DecimalScreens({Key? key}) : super(key: key);

  @override
  _DecimalScreensState createState() => _DecimalScreensState();
}

class _DecimalScreensState extends State<DecimalScreens> {
  String text="41354564561.223";
  int value = -1;
  int value1 = -1;
  int num = 4;
  int num1 = 6;
  int x=41354561351;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, color: MyColors.textColor)),
            ],
          ),
          Text("$text",style:TextStyle(color: MyColors.textColor,fontWeight: FontWeight.bold,fontSize: 22 ) ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(margin: const EdgeInsets.only(top: 20),
                width: 180,
                height: 255,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      "monetary".tr().toString(),
                      style: TextStyle(color: MyColors.textColor, fontSize: 20,fontWeight: FontWeight.bold),
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
                                    MyColors.boolMonetaryFormate.forEach((element) {
                                       if (index == j) {
                                        MyColors.monetaryformat=index+1;
                                        format();

                                        MyColors.boolMonetaryFormate[j] = true;
                                      } else
                                        MyColors.boolMonetaryFormate[j] = false;


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
                margin: EdgeInsets.only(top: 22  ),
                width: 180,
                child: Column(
                  children: [

                    Text(
                      "decimal".tr().toString(),
                      style: TextStyle(
                          color: MyColors.textColor, fontSize: 20,fontWeight: FontWeight.bold),
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
                                        if(index==5)
                                          {  MyColors.boolDecimalFormate[i] = true;
                                            MyColors.decimalformat = 0;
                                            format();
                                          }
                                        else
                                        {
                                          MyColors.decimalformat = index + 2;
                                          MyColors.boolDecimalFormate[i] = true;
                                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>MyTabBarWidget()), (route) => false);
                                          format();
                                        }


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
                                    borderRadius:
                                        BorderRadius.circular(10)),
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
  format(){


    int i = MyColors.monetaryformat;
    int afterdecimal =MyColors.decimalformat;
    int amount = x;
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

}

