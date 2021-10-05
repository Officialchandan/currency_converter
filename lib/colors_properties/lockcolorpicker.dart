/// Block Color Picker

library block_colorpicker;



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
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

class LockColorPicker extends StatefulWidget {

  const LockColorPicker({
    required this.pickerColor,
    required this.onColorChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: 400,


      child: GridView.count(
        padding: const EdgeInsets.all(0),
        //physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: orientation == Orientation.portrait ? 5 : 6,

        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      height: 60,
      width: 43,
     // padding: EdgeInsets.all(30),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1.0, 2.0),
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
  State<StatefulWidget> createState() => _LockColorPickerState();
}

class _LockColorPickerState extends State<LockColorPicker> {
  late Color _currentColor;

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

