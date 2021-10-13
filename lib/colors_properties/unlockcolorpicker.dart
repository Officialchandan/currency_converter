/// Block Color Picker

library block_colorpicker;

import 'package:currency_converter/pages/setting_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/utils.dart';

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<MColor> colors, PickerItem child);
typedef PickerItem = Widget Function(MColor color);
typedef PickerItemBuilder = Widget Function(
    MColor color, bool isCurrentColor, void Function() changeColor);

class UnlockColorPicker extends StatefulWidget {
  const UnlockColorPicker({
    required this.pickerColor,
    required this.onColorChanged,
    required this.availableColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final MColor pickerColor;
  final ValueChanged<MColor> onColorChanged;
  final List<MColor> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<MColor> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      padding: EdgeInsets.all(7),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: colors.map((MColor color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(
      MColor color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: color.mainColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(0.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color.mainColor)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _UnlockColorPickerState();
}

class _UnlockColorPickerState extends State<UnlockColorPicker> {
  late MColor _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(MColor color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (MColor color, [bool? _, Function? __]) => widget.itemBuilder(color,
          _currentColor.mainColor == color.mainColor, () => changeColor(color)),
    );
  }
}
