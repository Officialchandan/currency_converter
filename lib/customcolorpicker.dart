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
    setState((){
      currentColor = color;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.69,
        child: Column(

          children:[Container( margin: const EdgeInsets.only(
              top: 15, right: 10, bottom: 0, left: 10),


            child: ColorPicker(

              pickerColor: currentColor,
              onColorChanged: changeColor,
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true ,
              displayThumbColor: true,
              showLabel: true,

              paletteType: PaletteType.hsl,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ), )
          ),

            Row(
              children: [
                Container(
                  margin:EdgeInsets.all(10),
            width: 180,
                  child:

                    ElevatedButton(child: Text("Select"),onPressed: (){

                      MyColors.firstthemecolorgr=currentColor;
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const MyTabBarWidget()), (route) => false);

                    },),
    ),

                    Container(width:180,child: ElevatedButton(onPressed: (){}, child: Text("Unlock")))




              ],
            )

        ]

        ),
      ),
    );
  }
}
