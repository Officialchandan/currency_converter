import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
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
  List<bool> boolMonetaryFormate = [false, false, false, false];

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
          SizedBox(
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
              Container(margin: EdgeInsets.only(top: 0),
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
                                value: boolMonetaryFormate[index],
                                onChanged: (value) {
                                  int j = 0;
                                  setState(() {
                                    boolMonetaryFormate.forEach((element) {
                                      if (index == j) {
                                        boolMonetaryFormate[j] = true;
                                      } else
                                        boolMonetaryFormate[j] = false;

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
                      style: TextStyle(
                          color: MyColors.textColor, fontSize: 20),
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
                                          {
                                            MyColors.decimalformat = 0;
                                          }
                                        else
                                        {
                                          MyColors.decimalformat = index + 2;
                                          MyColors.boolDecimalFormate[i] = true;
                                        }
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>MyTabBarWidget()), (route) => false);

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
}
