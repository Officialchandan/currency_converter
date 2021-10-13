import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/home/home_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({Key? key}) : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color currentColor = Colors.amber;
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
        height: MediaQuery.of(context).size.height * 0.79,
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
                  child: const Text("Try this Color"),
                  onPressed: () {
                    MyColors.colorPrimary = currentColor;
                    MyColors.calcuColor = currentColor;
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
                      ElevatedButton(onPressed: () {}, child: Text("Unlock")))
            ],
          )
        ]),
      ),
    );
  }
}
