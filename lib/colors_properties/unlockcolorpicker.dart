/// Block Color Picker

library block_colorpicker;

import 'package:bot_toast/bot_toast.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/utils/constants.dart';
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

    double heightFactor = 1;

    heightFactor = (colors.length / 5);

    int r = colors.length % 5;

    if (r != 0) {
      heightFactor = heightFactor.toInt() + 1;
    } else {
      heightFactor = heightFactor.floorToDouble();
    }

    return IntrinsicHeight(
      child: SizedBox(
        height: (MediaQuery.of(context).size.height * 0.09) * heightFactor,

        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          //physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: orientation == Orientation.portrait ? 5 : 6,

          children: colors.map((MColor color) => child(color)).toList(),
        ),
        // child: ListView(
        //   scrollDirection: Axis.horizontal,
        //   children: colors.map((MColor color) => child(color)).toList(),
        // ),
      ),
    );
  }

  static Widget defaultItemBuilder(
      MColor color, bool isCurrentColor, void Function() changeColor) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          MyColors.lastTimeCheck = true;
          MyColors.unclockCheck = true;
          MyColors.lockCheck = false;
          MyColors.densitycheck = false;

          changeColor();
        },
        onLongPress: () {
          debugPrint("longpresss---->");
          BotToast.showText(
            text: "#${color.mainColor.value.toRadixString(16)}",
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
        child: Container(
          height: 60,
          width: 43,
          // padding: EdgeInsets.all(30),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            color: color.mainColor,
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: MyColors.unclockCheck
                ? Icon(
                    Icons.done,
                    color: useWhiteForeground(color.mainColor)
                        ? Colors.white
                        : Colors.black,
                  )
                : Text(
                    "        ",
                    textScaleFactor: Constants.textScaleFactor,
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

    if (widget.availableColors.contains(widget.pickerColor)) {
      MyColors.unclockCheck = true;
    }

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
