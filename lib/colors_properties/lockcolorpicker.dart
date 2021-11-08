/// Block Color Picker

library block_colorpicker;

import 'package:currency_converter/Themes/colors.dart';
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
];

typedef PickerLayoutBuilder = Widget Function(BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(Color color, bool isCurrentColor, void Function() changeColor);

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

  static Widget defaultLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(

      height: MediaQuery.of(context).size.height * 0.27,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        //physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: orientation == Orientation.portrait ? 5 : 6,

        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      height: 60,
      width: 43,
       padding: EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(

        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            MyColors.lockCheck = true;
            changeColor();
          },

          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: MyColors.lockCheck
                ? Icon(
                    Icons.done,
                    color: useWhiteForeground(color) ? Colors.white : Colors.black,
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
  State<StatefulWidget> createState() => _LockColorPickerState();
}

class _LockColorPickerState extends State<LockColorPicker> {
  late Color _currentColor;

  @override
  void initState() {

    getColorFromPreference();



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
      (Color color, [bool? _, Function? __]) =>
          widget.itemBuilder(color, _currentColor.value == color.value, () => changeColor(color)),
    );
  }

  void getColorFromPreference() async{
    int i=0;

    print("Vivek");
    String colorPreference1=await Utility.getTryColorPreference("Color");
    String colorPreference= colorPreference1;
//MaterialColor(primary value: Color(0xfff44336))
    colorPreference="MaterialColor(primary value: "+colorPreference1+")";
    _defaultColors.forEach((element) {
      i++;
      print("-<<<<<<<<<<$colorPreference");
      print("-========= ${element.toString()}");
      if(colorPreference==element.toString())
        {
          print("->>>>$colorPreference");

        }
    });
    _defaultColors.removeAt(i);

    Color c  = Color(int.parse("0x$colorPreference1"));




    _defaultColors.insert(0,c );
setState(() {

});
  }
}
