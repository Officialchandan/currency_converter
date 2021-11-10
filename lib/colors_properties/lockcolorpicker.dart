/// Block Color Picker

library block_colorpicker;



import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/setting_screen.dart';
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

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<LColor> colors, PickerItem child);
typedef PickerItem = Widget Function(LColor color);
typedef PickerItemBuilder = Widget Function(
    LColor color, bool isCurrentColor, void Function() changeColor);

class LockColorPicker extends StatefulWidget {

  const LockColorPicker({
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

  static Widget defaultLayoutBuilder(
      BuildContext context, List<LColor> colors, PickerItem child) {
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

  static Widget defaultItemBuilder(
      LColor color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      height: 60,
      width: 43,
      // padding: EdgeInsets.all(30),
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),

        color: color.lmainColor,

      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(

          onTap: (){changeColor();

          },
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color.lmainColor) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _LockColorPickerState();
}

class _LockColorPickerState extends State<LockColorPicker> {
  late LColor _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
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
          (LColor color, [bool? _, Function? __]) => widget.itemBuilder(
          color, _currentColor.lmainColor == color.lmainColor, () => changeColor(color)),
    );
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
