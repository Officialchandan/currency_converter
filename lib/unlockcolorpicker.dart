/// Block Color Picker

library block_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/utils.dart';

const List<Color> _defaultColors = [
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
];

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

class UnlockColorPicker extends StatefulWidget {
  const UnlockColorPicker({
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

    return Container(
      width: 400,
      height: 60,
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
          borderRadius: BorderRadius.circular(0.0),
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
  State<StatefulWidget> createState() => _UnlockColorPickerState();
}

class _UnlockColorPickerState extends State<UnlockColorPicker> {
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

class MultipleChoiceBlockPicker extends StatefulWidget {
  const MultipleChoiceBlockPicker({
    required this.pickerColors,
    required this.onColorsChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = UnlockColorPicker.defaultLayoutBuilder,
    this.itemBuilder = UnlockColorPicker.defaultItemBuilder,
  });

  final List<Color> pickerColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _MultipleChoiceBlockPickerState();
}

class _MultipleChoiceBlockPickerState extends State<MultipleChoiceBlockPicker> {
  late List<Color> _currentColors;

  @override
  void initState() {
    _currentColors = widget.pickerColors;
    super.initState();
  }

  void toggleColor(Color color) {
    setState(() {
      _currentColors.contains(color)
          ? _currentColors.remove(color)
          : _currentColors.add(color);
    });
    widget.onColorsChanged(_currentColors);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (Color color, [bool? _, Function? __]) => widget.itemBuilder(
        color,
        _currentColors.contains(color),
        () => toggleColor(color),
      ),
    );
  }
}
