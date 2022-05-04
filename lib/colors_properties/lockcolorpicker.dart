/// Block Color Picker

library block_colorpicker;

import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/src/utils.dart';

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];
String? colorPreference;

typedef PickerLayoutBuilder = Widget Function(BuildContext context, List<LColor> colors, PickerItem child);
typedef PickerItem = Widget Function(LColor color);
typedef PickerItemBuilder = Widget Function(LColor color, bool isCurrentColor, void Function() changeColor);

class LockColorPicker extends StatefulWidget {
  LockColorPicker({
    required this.pickerColor,
    required this.onColorChanged,
    required this.availableColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final LColor pickerColor;
  final ValueChanged<LColor> onColorChanged;
  final List<LColor> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(BuildContext context, List<LColor> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.37,
      child: GridView.count(
        padding: const EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: orientation == Orientation.portrait ? 5 : 6,
        children: colors.map((LColor color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(LColor color, bool isCurrentColor, void Function() changeColor) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            MyColors.lastTimeCheck = false;
            MyColors.unclockCheck = false;
            MyColors.densitycheck = false;
            MyColors.lockCheck = true;

            MyColors.eyeIconSetup = false;
            changeColor();
          },
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            height: 60,
            width: 43,
            // padding: EdgeInsets.all(30),
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: color.lmainColor,
                border: Border.all(color: Colors.black, width: 0.5)),
            child: colorPreference == color.lmainColor.value.toRadixString(16) && MyColors.eyeIconSetup
                ? Icon(
                    Icons.visibility_outlined,
                    color: useWhiteForeground(color.lmainColor) ? Colors.white : Colors.black,
                  )
                : AnimatedOpacity(
                    duration: const Duration(milliseconds: 210),
                    opacity: isCurrentColor ? 1.0 : 0.0,
                    child: MyColors.lockCheck
                        ? Icon(
                            Icons.done,
                            color: useWhiteForeground(color.lmainColor) ? Colors.white : Colors.black,
                          )
                        : Text(
                            "        ",
                            textScaleFactor: Constants.textScaleFactor,
                          ),
                  ),
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() => _LockColorPickerState();
}

class _LockColorPickerState extends State<LockColorPicker> {
  late LColor _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    getColorFromPreference();
    super.initState();
  }

  void changeColor(LColor color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (LColor color, [bool? _, Function? __]) =>
          widget.itemBuilder(color, _currentColor.lmainColor == color.lmainColor, () => changeColor(color)),
    );
  }

  void getColorFromPreference() async {
    colorPreference = await Utility.getStringPreference("Color");
    Color? c;
    LColor? lockcolor;

    int index = widget.availableColors.indexWhere((element) => element.lmainColor.value.toRadixString(16) == colorPreference);
    print("index------>$index");
    print("colorPreference------>$colorPreference");

    if (colorPreference != null && index != -1) {
      LColor temp = widget.availableColors[0];
      widget.availableColors[0] = widget.availableColors[index];
      widget.availableColors[index] = temp;
    }

    // for (int i = 0; i < widget.availableColors.length; i++) {
    //   if (colorPreference == widget.availableColors[i].lmainColor.value.toRadixString(16)) {
    //     c = Color(int.parse("0x" + "${colorPreference}"));
    //     lockcolor = LColor(lmainColor: c, ldensityColors: []);
    //     LColor temp = widget.availableColors[0];
    //     widget.availableColors[0] = widget.availableColors[i];
    //     widget.availableColors[i] = temp;
    //
    //     break;
    //   }
    // }

    setState(() {});
  }
}

// const List<Color> _defaultColors = [
//   Colors.red,
//   Colors.pink,
//   Colors.purple,
//   Colors.deepPurple,
//   Colors.indigo,
//   Colors.blue,
//   Colors.lightBlue,
//   Colors.cyan,
//   Colors.teal,
//   Colors.green,
//   Colors.lightGreen,
//   Colors.lime,
//   Colors.yellow,
//   Colors.amber,
//   Colors.orange,
//   Colors.deepOrange,
//   Colors.brown,
//   Colors.grey,
//   Colors.blueGrey,
//   Colors.black,
// ];
