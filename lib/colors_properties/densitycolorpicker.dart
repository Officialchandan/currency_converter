/// Block Color Picker

library block_colorpicker;

import 'package:bot_toast/bot_toast.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/src/utils.dart';

late Color _currentColor;

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

class DensityColorPicker extends StatefulWidget {
  var color1;

  DensityColorPicker(
      {required this.pickerColor,
      required this.onColorChanged,
      required this.availableColors,
      this.layoutBuilder = defaultLayoutBuilder,
      this.itemBuilder = defaultItemBuilder,
      this.color1});

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: colors.map((Color color) => child(color)).toSet().toList(),
    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      height: 60,
      width: 43,
      margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5, left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: color,
          border: Border.all(color: Colors.black, width: 0.5)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            changeColor();
            MyColors.densitycheck = true;
            MyColors.eyeIconSetup = false;
            MyColors.lockCheck = false;
            MyColors.unclockCheck = false;
          },
          onLongPress: () {
            debugPrint("longpresss---->");

            BotToast.showText(
              text: "#${color.value.toRadixString(16)}",
              animationDuration: const Duration(milliseconds: 100),
              align: const Alignment(0.0, 0.74),
              contentColor: Colors.black.withOpacity(0.9),
              contentPadding: const EdgeInsets.all(10.0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 17.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            );
          },
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: MyColors.densitycheck
                ? Icon(
                    Icons.done,
                    color:
                        useWhiteForeground(color) ? Colors.white : Colors.black,
                  )
                : Text(
                    "",
                    textScaleFactor: Constants.textScaleFactor,
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
      widget.availableColors.toSet().toList(),
      (Color color, [bool? _, Function? __]) => widget.itemBuilder(
          color, _currentColor.value == color.value, () => changeColor(color)),
    );
  }
}
