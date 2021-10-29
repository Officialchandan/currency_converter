import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({Key? key}) : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color currentColor = MyColors.colorPrimary;
  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.70,
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, bottom: 0, left: 10),
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: true,
                displayThumbColor: true,
                showLabel: true,
                paletteType: PaletteType.hsl,
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(2.0),
                  topRight: const Radius.circular(2.0),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 150,
                child: ElevatedButton(
                  child:  Text("try".tr().toString()),
                  onPressed: () {
                   MyColors.checkBoxValue2= useWhiteForeground(currentColor)
                        ? false
                        : true;
                   if( MyColors.checkBoxValue2){
                     MyColors.textColor=Colors.grey.shade700;
                     MyColors.insideTextFieldColor=Colors.white;
                     MyColors.checkBoxValue2=true;
                     MyColors.checkBoxValue1=false;
                   }
                   else{
                     MyColors.textColor=Colors.white;
                     MyColors.insideTextFieldColor=Colors.black;
                     MyColors.checkBoxValue1=true;
                     MyColors.checkBoxValue2=false;

                   }


                    MyColors.colorPrimary = currentColor;
                    MyColors.calcuColor = currentColor;
                   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                     systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                     statusBarColor: MyColors.colorPrimary, // status bar color
                   ));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyTabBarWidget()),
                        (route) => false);
                  },
                ),
              ),
              Container(
                  width: 150,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("unlock".tr().toString())))
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              right: 250,
              top: 30,
            ),


            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);

                setState(() {});
              },
              child:  Text(
                "PRESETS",
                style: TextStyle(letterSpacing: 0.8, color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ]
        ),
      ),
    );
  }
}
