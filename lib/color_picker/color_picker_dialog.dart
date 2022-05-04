import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/colors_properties/customcolorpicker.dart';
import 'package:currency_converter/colors_properties/densitycolorpicker.dart';
import 'package:currency_converter/colors_properties/lockcolorpicker.dart';
import 'package:currency_converter/colors_properties/unlockcolorpicker.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorPickerDialog extends StatefulWidget {
  final Function onThemeChange;

  final Function(Color color) unlockchangeColor;
  final Function(Color color) densitychangeColor;
  final Function(Color color) lockchangeColor;
  final Function(Color color, BuildContext context) onColorSelect;
  final Color unlockCurrentColor;
  final Color lockCurrentColor;
  final Color densityCurrentColor;
  bool isLockedColor;
  bool isUnlockColorSelect;

  ColorPickerDialog(
      {required this.onColorSelect,
      required this.lockchangeColor,
      required this.densitychangeColor,
      required this.unlockchangeColor,
      required this.densityCurrentColor,
      required this.lockCurrentColor,
      required this.unlockCurrentColor,
      required this.isLockedColor,
      required this.isUnlockColorSelect,
      required this.onThemeChange,
      Key? key})
      : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color unlockCurrentColor = Colors.blue;
  LColor lockCurrentColor = LColor(lmainColor: Colors.white, ldensityColors: []);
  Color densityCurrentColor = Colors.blue;

  MColor selectedColor = MColor(mainColor: MyColors.colorPrimary, densityColors: []);
  LColor lselectedColor = LColor(lmainColor: Colors.white, ldensityColors: []);

  List<MColor> unlockColorList = Constants.unlockColors;
  List<LColor> mList = [];
  Color selectedDensityColor = const Color(0xff4e7dcb);

  StreamController<List<Color>> densityColorStream = StreamController();
  StreamController<List<MColor>> unlockColorStream = StreamController();
  StreamController<List<LColor>> lockColorStream = StreamController();
  StreamController<bool> unlockColorController = StreamController();
  StreamController<bool> lockColorController = StreamController();

  List<LColor> lockedColorList = [
    LColor(lmainColor: Colors.red, ldensityColors: [
      Colors.red.shade50,
      Colors.red.shade100,
      Colors.red.shade200,
      Colors.red.shade300,
      Colors.red.shade400,
      Colors.red.shade500,
      Colors.red.shade600,
      Colors.red.shade700,
      Colors.red.shade800,
      Colors.red.shade900,
    ]),
    LColor(lmainColor: Colors.pink, ldensityColors: [
      Colors.pink.shade50,
      Colors.pink.shade100,
      Colors.pink.shade200,
      Colors.pink.shade300,
      Colors.pink.shade400,
      Colors.pink.shade500,
      Colors.pink.shade600,
      Colors.pink.shade700,
      Colors.pink.shade800,
      Colors.pink.shade900,
    ]),
    LColor(lmainColor: Colors.purple, ldensityColors: [
      Colors.purple.shade50,
      Colors.purple.shade100,
      Colors.purple.shade200,
      Colors.purple.shade300,
      Colors.purple.shade400,
      Colors.purple.shade500,
      Colors.purple.shade600,
      Colors.purple.shade700,
      Colors.purple.shade800,
      Colors.purple.shade900,
    ]),
    LColor(lmainColor: Colors.deepPurple, ldensityColors: [
      Colors.deepPurple.shade50,
      Colors.deepPurple.shade100,
      Colors.deepPurple.shade200,
      Colors.deepPurple.shade300,
      Colors.deepPurple.shade400,
      Colors.deepPurple.shade500,
      Colors.deepPurple.shade600,
      Colors.deepPurple.shade700,
      Colors.deepPurple.shade800,
      Colors.deepPurple.shade900,
    ]),
    LColor(lmainColor: Colors.indigo, ldensityColors: [
      Colors.indigo.shade50,
      Colors.indigo.shade100,
      Colors.indigo.shade200,
      Colors.indigo.shade300,
      Colors.indigo.shade400,
      Colors.indigo.shade500,
      Colors.indigo.shade600,
      Colors.indigo.shade700,
      Colors.indigo.shade800,
      Colors.indigo.shade900,
    ]),
    LColor(lmainColor: Colors.blue, ldensityColors: [
      Colors.blue.shade50,
      Colors.blue.shade100,
      Colors.blue.shade200,
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade500,
      Colors.blue.shade600,
      Colors.blue.shade700,
      Colors.blue.shade800,
      Colors.blue.shade900,
    ]),
    LColor(lmainColor: Colors.lightBlue, ldensityColors: [
      Colors.lightBlue.shade50,
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade500,
      Colors.lightBlue.shade600,
      Colors.lightBlue.shade700,
      Colors.lightBlue.shade800,
      Colors.lightBlue.shade900,
    ]),
    LColor(lmainColor: Colors.cyan, ldensityColors: [
      Colors.cyan.shade50,
      Colors.cyan.shade100,
      Colors.cyan.shade200,
      Colors.cyan.shade300,
      Colors.cyan.shade400,
      Colors.cyan.shade500,
      Colors.cyan.shade600,
      Colors.cyan.shade700,
      Colors.cyan.shade800,
      Colors.cyan.shade900,
    ]),
    LColor(lmainColor: Colors.teal, ldensityColors: [
      Colors.teal.shade50,
      Colors.teal.shade100,
      Colors.teal.shade200,
      Colors.teal.shade300,
      Colors.teal.shade400,
      Colors.teal.shade500,
      Colors.teal.shade600,
      Colors.teal.shade700,
      Colors.teal.shade800,
      Colors.teal.shade900,
    ]),
    LColor(lmainColor: Colors.green, ldensityColors: [
      Colors.green.shade50,
      Colors.green.shade100,
      Colors.green.shade200,
      Colors.green.shade300,
      Colors.green.shade400,
      Colors.green.shade500,
      Colors.green.shade600,
      Colors.green.shade700,
      Colors.green.shade800,
      Colors.green.shade900,
    ]),
    LColor(lmainColor: Colors.lightGreen, ldensityColors: [
      Colors.lightGreen.shade50,
      Colors.lightGreen.shade100,
      Colors.lightGreen.shade200,
      Colors.lightGreen.shade300,
      Colors.lightGreen.shade400,
      Colors.lightGreen.shade500,
      Colors.lightGreen.shade600,
      Colors.lightGreen.shade700,
      Colors.lightGreen.shade800,
      Colors.lightGreen.shade900,
    ]),
    LColor(lmainColor: Colors.lime, ldensityColors: [
      Colors.lime.shade50,
      Colors.lime.shade100,
      Colors.lime.shade200,
      Colors.lime.shade300,
      Colors.lime.shade400,
      Colors.lime.shade500,
      Colors.lime.shade600,
      Colors.lime.shade700,
      Colors.lime.shade800,
      Colors.lime.shade900,
    ]),
    LColor(lmainColor: Colors.yellow, ldensityColors: [
      Colors.yellow.shade50,
      Colors.yellow.shade100,
      Colors.yellow.shade200,
      Colors.yellow.shade300,
      Colors.yellow.shade400,
      Colors.yellow.shade500,
      Colors.yellow.shade600,
      Colors.yellow.shade700,
      Colors.yellow.shade800,
      Colors.yellow.shade900,
    ]),
    LColor(lmainColor: Colors.amber, ldensityColors: [
      Colors.amber.shade50,
      Colors.amber.shade100,
      Colors.amber.shade200,
      Colors.amber.shade300,
      Colors.amber.shade400,
      Colors.amber.shade500,
      Colors.amber.shade600,
      Colors.amber.shade700,
      Colors.amber.shade800,
      Colors.amber.shade900,
    ]),
    LColor(lmainColor: Colors.orange, ldensityColors: [
      Colors.orange.shade50,
      Colors.orange.shade100,
      Colors.orange.shade200,
      Colors.orange.shade300,
      Colors.orange.shade400,
      Colors.orange.shade500,
      Colors.orange.shade600,
      Colors.orange.shade700,
      Colors.orange.shade800,
      Colors.orange.shade900,
    ]),
    LColor(lmainColor: Colors.deepOrange, ldensityColors: [
      Colors.deepOrange.shade50,
      Colors.deepOrange.shade100,
      Colors.deepOrange.shade200,
      Colors.deepOrange.shade300,
      Colors.deepOrange.shade400,
      Colors.deepOrange.shade500,
      Colors.deepOrange.shade600,
      Colors.deepOrange.shade700,
      Colors.deepOrange.shade800,
      Colors.deepOrange.shade900,
    ]),
    LColor(lmainColor: Colors.brown, ldensityColors: [
      Colors.brown.shade50,
      Colors.brown.shade100,
      Colors.brown.shade200,
      Colors.brown.shade300,
      Colors.brown.shade400,
      Colors.brown.shade500,
      Colors.brown.shade600,
      Colors.brown.shade700,
      Colors.brown.shade800,
      Colors.brown.shade900,
    ]),
    LColor(lmainColor: Colors.grey, ldensityColors: [
      Colors.grey.shade50,
      Colors.grey.shade100,
      Colors.grey.shade200,
      Colors.grey.shade300,
      Colors.grey.shade400,
      Colors.grey.shade500,
      Colors.grey.shade600,
      Colors.grey.shade700,
      Colors.grey.shade800,
      Colors.grey.shade900,
    ]),
    LColor(lmainColor: Colors.blueGrey, ldensityColors: [
      Colors.blueGrey.shade50,
      Colors.blueGrey.shade100,
      Colors.blueGrey.shade200,
      Colors.blueGrey.shade300,
      Colors.blueGrey.shade400,
      Colors.blueGrey.shade500,
      Colors.blueGrey.shade600,
      Colors.blueGrey.shade700,
      Colors.blueGrey.shade800,
      Colors.blueGrey.shade900,
    ]),
  ];

  Color lockSelectdColor = Colors.blue;
  Color? unlockSelectdColor;
  Color? colorSelection;
  Color densitySelectedColor = Colors.red;

  @override
  void initState() {
    debugPrint("lockedColorList--->${Constants.lockedColors.length}");
    Color c = MyColors.colorPrimary;
    getSelectedColor();
    // getLockedColor();
    unlockColorController.add(widget.isUnlockColorSelect);
    lockColorController.add(widget.isLockedColor);

    unlockCurrentColor = widget.unlockCurrentColor;
    lockCurrentColor = LColor(lmainColor: Colors.white, ldensityColors: []);
    densityCurrentColor = widget.densityCurrentColor;

    int selectedLockColorIndex = lockedColorList.indexWhere((element) => element.lmainColor.hex == c.hex);
    int selectedUnlockColorIndex = unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    debugPrint("selectedLockColorIndex---->$selectedLockColorIndex");
    debugPrint("selectedUnlockColorIndex---->$selectedUnlockColorIndex");

    // if (selectedLockColorIndex == -1 && selectedUnlockColorIndex == -1) {
    //   LColor newLockColor = LColor(lmainColor: MyColors.colorPrimary, ldensityColors: [
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade50,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade100,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade200,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade300,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade400,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade500,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade600,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade700,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade800,
    //     ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade900,
    //   ]);
    //
    //   // lockedColorList.add(newLockColor);
    //
    // }

    // if (selectedLockColorIndex != -1 && selectedUnlockColorIndex == -1) {
    //   lockCurrentColor = lockedColorList[selectedLockColorIndex];
    //   // lockedColorList.add(newLockColor);
    //
    // }

    if (selectedUnlockColorIndex != -1) {
      selectedColor = unlockColorList[selectedUnlockColorIndex];
    }

    debugPrint("selectedColor---->$selectedColor");

    // List<LColor> result = LinkedHashSet<LColor>.from(lockedColorList).toList();
    // lockedColorList = result;

    int i = lockedColorList.indexWhere((element) {
      return element.lmainColor.hex == c.hex;
      // print("${element.lmainColor}=========$c");
      // Color d = Color(int.parse("0x" + "${element.lmainColor.value.toRadixString(16)}"));
      // print("$d=========$c");
      //
      // if (d == MyColors.lockColorfordefault) {
      //   return true;
      // } else {
      //   return false;
      // }
    });

    debugPrint("selectedNewLockColorIndex---->$i");

    if (i != -1) {
      lselectedColor = lockedColorList[i];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25, top: 30, bottom: 0),
          child: Text(
            "unlocked".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 0.87,
          //height: MediaQuery.of(context).size.height * 0.4,
          child: IntrinsicHeight(
              child: StreamBuilder<List<MColor>>(
            stream: unlockColorStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MColor> colors = snapshot.data!;

                int index = colors.indexWhere((element) => element.mainColor.hex == MyColors.colorPrimary.hex);
                MColor selected = selectedColor;

                if (index != -1) {
                  selected = colors[index];
                }

                return UnlockColorPicker(
                  pickerColor: selected,
                  onColorChanged: onUnlockColorChange,
                  availableColors: colors,
                );
              }

              return UnlockColorPicker(
                pickerColor: selectedColor,
                onColorChanged: onUnlockColorChange,
                availableColors: unlockColorList,
              );
            },
          )),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, top: 5),
          child: Text(
            "locked".tr().toString(),
            textScaleFactor: Constants.textScaleFactor,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 5),
          width: MediaQuery.of(context).size.width * 0.87,
          child: IntrinsicHeight(
            child: StreamBuilder<List<LColor>>(
              stream: lockColorStream.stream,
              builder: (context, snapshot) {
                debugPrint("snapshot--->$snapshot");
                if (snapshot.hasData) {
                  List<LColor> lockedColors = snapshot.data!;
                  debugPrint("lockedColors--->${lockedColors.length}");
                  int selectedLockedColorIndex =
                      lockedColors.indexWhere((element) => element.lmainColor.hex == MyColors.colorPrimary.hex);
                  LColor? selectedLockedColor;
                  debugPrint("selected--->$selectedLockedColorIndex");
                  if (selectedLockedColorIndex != -1) {
                    if (selectedLockedColorIndex > 0) {
                      selectedLockedColor = lockedColors[selectedLockedColorIndex];
                      LColor mColor = lockedColors[0];

                      lockedColors[0] = selectedLockedColor;
                      lockedColors[selectedLockedColorIndex] = mColor;
                    } else {
                      selectedLockedColor = lockedColors[selectedLockedColorIndex];
                    }
                  }

                  return LockColorPicker(
                    pickerColor: selectedLockedColor ?? LColor(lmainColor: Colors.white, ldensityColors: []),
                    onColorChanged: onLockColorChange,
                    availableColors: lockedColors,
                  );
                }

                // return Container();
                return LockColorPicker(
                  pickerColor: lockCurrentColor,
                  onColorChanged: onLockColorChange,
                  availableColors: lockedColorList,
                );
              },
            ),
          ),
        ),
        Center(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: width * 0.87,
              height: height * 0.077,
              child: StreamBuilder<List<Color>>(
                stream: densityColorStream.stream,
                builder: (context, snapshot) {
                  List<Color> colors = snapshot.data!;

                  if (snapshot.hasData) {
                    return DensityColorPicker(
                        pickerColor: selectedDensityColor, onColorChanged: onDensityColorChange, availableColors: colors);
                  }

                  return DensityColorPicker(
                      pickerColor: selectedDensityColor,
                      onColorChanged: onDensityColorChange,
                      availableColors: MyColors.lastTimeCheck ? selectedColor.densityColors : lselectedColor.ldensityColors);
                },
              )),
        ),
        const SizedBox(
          height: 5,
        ),
        StreamBuilder<bool>(
            stream: lockColorController.stream,
            builder: (context, snap) {
              if (snap.hasData && snap.data!) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: width * 0.45,
                        height: height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
                          onPressed: () {
                            MyColors.lockColorfordefault = lockSelectdColor;
                            MyColors.colorPrimary = colorSelection!;

                            int red = MyColors.colorPrimary.red;
                            int blue = MyColors.colorPrimary.blue;
                            int green = MyColors.colorPrimary.green;

                            var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
                            print("************************-> $grayscale");

                            if (grayscale > 200) {
                              MyColors.textColor = Colors.grey.shade700;
                              MyColors.insideTextFieldColor = Colors.white;
                              MyColors.darkModeCheck = true;
                              MyColors.lightModeCheck = false;
                            } else {
                              MyColors.textColor = Colors.white;
                              MyColors.insideTextFieldColor = Colors.black;
                              MyColors.lightModeCheck = true;
                              MyColors.darkModeCheck = false;
                            }

                            Utility.setStringPreference("Color", lockSelectdColor.value.toRadixString(16));

                            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                              // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                              systemNavigationBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                              systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                              statusBarColor: MyColors.colorPrimary, // status bar color
                            ));

                            widget.onThemeChange();
                            Navigator.pop(context);
                          },
                          child: AutoSizeText(
                            "try_this_color".tr().toString(),
                            textScaleFactor: Constants.textScaleFactor,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: width * 0.45,
                        height: height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
                          onPressed: () {
                            //***** */
                          },
                          child: Text(
                            "unlock".tr().toString(),
                            textScaleFactor: Constants.textScaleFactor,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )),
                  ],
                );
              }

              return Text(
                "",
                textScaleFactor: Constants.textScaleFactor,
              );
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                top: 20,
              ),
              width: width * 0.55,
              height: height * 0.05,
              child: GestureDetector(
                onTap: () {
                  showCustomColorPickerDialog(context);
                },
                child: AutoSizeText(
                  "cpv_custom".tr().toString(),
                  textScaleFactor: Constants.textScaleFactor,
                  style: const TextStyle(letterSpacing: 0.8, color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
              ),
            ),
            StreamBuilder<bool>(
                stream: unlockColorController.stream,
                builder: (context, snap) {
                  if (snap.hasData && snap.data!) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      width: width * 0.25,
                      height: height * 0.05,
                      child: GestureDetector(
                        onTap: () {
                          MyColors.colorPrimary = unlockSelectdColor!;
                          int red = MyColors.colorPrimary.red;
                          int blue = MyColors.colorPrimary.blue;
                          int green = MyColors.colorPrimary.green;

                          var grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
                          print("************************-> $grayscale");

                          if (grayscale > 200) {
                            MyColors.textColor = Colors.grey.shade700;
                            MyColors.insideTextFieldColor = Colors.white;
                            MyColors.darkModeCheck = true;
                            MyColors.lightModeCheck = false;
                          } else {
                            MyColors.textColor = Colors.white;
                            MyColors.insideTextFieldColor = Colors.black;
                            MyColors.lightModeCheck = true;
                            MyColors.darkModeCheck = false;
                          }
                          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                            // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                            systemNavigationBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                            systemNavigationBarColor: MyColors.colorPrimary, // navigation bar color
                            statusBarColor: MyColors.colorPrimary, // status bar color
                          ));
                          Utility.setStringPreference(Constants.themeColor, unlockSelectdColor!.value.toString());
                          Utility.setStringPreference(Constants.primaryColorCode, unlockSelectdColor!.value.toRadixString(16));

                          themepicker(unlockSelectdColor!.value.toString());

                          widget.onThemeChange();
                          Navigator.pop(context);

                          // setState(() {});
                        },
                        child: Text(
                          "cpv_select".tr().toString(),
                          textScaleFactor: Constants.textScaleFactor,
                          style: const TextStyle(letterSpacing: 1.0, color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }

                  return Text(
                    "",
                    textScaleFactor: Constants.textScaleFactor,
                  );
                })
          ],
        )
      ],
    );
  }

  void showCustomColorPickerDialog(BuildContext context) async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return DefaultTextStyle(
            style: const TextStyle(decoration: TextDecoration.none),
            child: Stack(children: [
              Container(
                height: height * 0.695,
                margin: const EdgeInsets.only(top: 100, right: 10, left: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomColorPicker(onThemeChange: widget.onThemeChange),
              ),
            ]),
          );
        });
  }

  void onUnlockColorChange(MColor color) {
    MyColors.lockCheck = false;
    MyColors.densitycheck = false;
    lockColorController.add(false);
    unlockColorController.add(true);
    var code = (color.mainColor.value.toRadixString(16));
    unlockSelectdColor = Color(int.parse("0x$code"));
    densityColorStream.add(color.densityColors);
    selectedColor = color;
    lockColorStream.add(mList);
    // setState(
    //   () => unlockCurrentColor = color.mainColor,
    // );
    // widget.unlockchangeColor(color.mainColor);
  }

  void onLockColorChange(LColor color) {
    MyColors.unclockCheck = false;
    MyColors.densitycheck = false;

    unlockColorController.add(false);
    lockColorController.add(true);
    var code = (color.lmainColor.value.toRadixString(16));
    lockSelectdColor = Color(int.parse("0x$code"));
    colorSelection = lockSelectdColor;
    lselectedColor = color;
    densityColorStream.add(color.ldensityColors);
    unlockColorStream.add(unlockColorList);

    // setState(
    //   () => lockCurrentColor = color,
    // );
  }

  void onDensityColorChange(Color color) {
    Utility.setStringPreference("DensityColor", color.value.toString());
    selectedDensityColor = color;
    MyColors.unclockCheck = false;
    MyColors.lockCheck = false;

    // widget.isLockedColor = true;

    lockColorController.add(true);
    var code = (color.value.toRadixString(16));
    densitySelectedColor = Color(int.parse("0x$code"));
    colorSelection = densitySelectedColor;
    lockColorStream.add(mList);
    lockSelectdColor = Color(int.parse("0x$code"));
    unlockColorStream.add(unlockColorList);

    // setState(
    //   () => unlockCurrentColor = color,
    // );
    // setState(() => densityCurrentColor = color);
    widget.densitychangeColor(color);
    debugPrint("selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  static void themepicker(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.themeColor, code);
  }

  void getSelectedColor() async {
    Color c = MyColors.colorPrimary;
    mList.clear();

    int selectedLockColorIndex = lockedColorList.indexWhere((element) => element.lmainColor.hex == c.hex);
    int selectedUnlockColorIndex = unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    if (selectedLockColorIndex == -1 && selectedUnlockColorIndex == -1) {
      LColor newLockColor = LColor(lmainColor: MyColors.colorPrimary, ldensityColors: [
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade50,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade100,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade200,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade300,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade400,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade500,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade600,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade700,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade800,
        ColorTools.createPrimarySwatch(MyColors.colorPrimary).shade900,
      ]);
      mList.add(newLockColor);
      mList.addAll(lockedColorList);
    } else {
      mList.addAll(lockedColorList);
    }

    selectedLockColorIndex = mList.indexWhere((element) => element.lmainColor.hex == c.hex);
    selectedUnlockColorIndex = unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    if (selectedLockColorIndex != -1) {
      lockCurrentColor = mList[selectedLockColorIndex];
      densityColorStream.add(mList[selectedLockColorIndex].ldensityColors);
    }

    if (selectedUnlockColorIndex != -1) {
      densityColorStream.add(unlockColorList[selectedUnlockColorIndex].densityColors);
    }
    unlockColorStream.add(unlockColorList);

    String colorPreference = await Utility.getStringPreference("Color");
    int index = mList.indexWhere((element) => element.lmainColor.value.toRadixString(16) == colorPreference);
    print("index------>$index");
    print("colorPreference------>$colorPreference");

    if (colorPreference != "" && index != -1) {
      LColor temp = mList[0];
      mList[0] = mList[index];
      mList[index] = temp;
    } else {
      Color mcolor = Color(int.parse("0x$colorPreference"));
      LColor newLockColor = LColor(lmainColor: mcolor, ldensityColors: [
        ColorTools.createPrimarySwatch(mcolor).shade50,
        ColorTools.createPrimarySwatch(mcolor).shade100,
        ColorTools.createPrimarySwatch(mcolor).shade200,
        ColorTools.createPrimarySwatch(mcolor).shade300,
        ColorTools.createPrimarySwatch(mcolor).shade400,
        ColorTools.createPrimarySwatch(mcolor).shade500,
        ColorTools.createPrimarySwatch(mcolor).shade600,
        ColorTools.createPrimarySwatch(mcolor).shade700,
        ColorTools.createPrimarySwatch(mcolor).shade800,
        ColorTools.createPrimarySwatch(mcolor).shade900,
      ]);

      mList.add(newLockColor);
      LColor temp = mList[0];
      mList[0] = mList.last;
      mList.last = temp;
    }

    lockColorStream.add(mList);
  }
}
