/// Block Color Picker

library block_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/utils.dart';
late Color _currentColor;

const List<Color> _defaultColors = [



  Color(0xffe8f5e9),
  Color(0xffc8e6c9),
  Color(0xffa5d6a7),
  Color(0xff81c784),
  Color(0xff66bb6a),
  Color(0xff4caf50),
  Color(0xff43a047),
  Color(0xff388e3c),
  Color(0xff2e7d32),
  Color(0xff1b5e20),

];

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

class DensityColorPicker extends StatefulWidget {
  var color1;

   DensityColorPicker({
    required this.pickerColor,
    required this.onColorChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
    this.color1
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    print("unlock se aaya -> ${_currentColor.value.toRadixString(16)}");
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(




        child: ListView(

          scrollDirection: Axis.horizontal,

          children: colors.map((Color color) => child(color)).toList(),
        ),

    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            offset: Offset(1.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _DensityColorPickerState();
}

class _DensityColorPickerState extends State<DensityColorPicker> {


  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
          (Color color, [bool? _, Function? __]) => widget.itemBuilder(
          color, _currentColor.value == color.value, () => changeColor(color)),
    );
  }
}
