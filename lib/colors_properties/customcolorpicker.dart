import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  final Function onThemeChange;
  const CustomColorPicker({required this.onThemeChange, Key? key})
      : super(key: key);

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
      body: IntrinsicHeight(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, bottom: 0, left: 10),
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: false,
                showLabel: true,
                paletteType: PaletteType.hsl,
                portraitOnly: false,
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
                  child: Text(
                    "try_this_color".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                  ),
                  onPressed: () {
                    int red = currentColor.red;
                    int blue = currentColor.blue;
                    int green = currentColor.green;

                    var grayscale =
                        (0.299 * red) + (0.587 * green) + (0.114 * blue);
                    print("************************-> $grayscale");

                    if (grayscale > 170) {
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

                    MyColors.colorPrimary = currentColor;

                    MyColors.calcuColor = currentColor;
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      // statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                      //
                      //
                      systemNavigationBarIconBrightness: MyColors.lightModeCheck
                          ? Brightness.light
                          : Brightness.dark,

                      systemNavigationBarColor:
                          MyColors.colorPrimary, // navigation bar color
                      statusBarColor: MyColors.colorPrimary, // status bar color
                    ));
                    widget.onThemeChange();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MyTabBarWidget()),
                        (route) => false);
                  },
                ),
              ),
              Container(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "unlock".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
                      )))
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
              child: AutoSizeText(
                "cpv_presets".tr().toString(),
                maxLines: 1,
                textScaleFactor: Constants.textScaleFactor,
                style: TextStyle(
                    letterSpacing: 0.8,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
