import 'dart:async';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/colors_properties/customcolorpicker.dart';
import 'package:currency_converter/colors_properties/densitycolorpicker.dart';
import 'package:currency_converter/colors_properties/lockcolorpicker.dart';
import 'package:currency_converter/colors_properties/unlockcolorpicker.dart';
import 'package:currency_converter/database/color_data.dart';
import 'package:currency_converter/main.dart';
import 'package:currency_converter/pages/setting_screen.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../in_app_parchase/product_provider.dart';
import '../pages/home/home_page.dart';

enum _TypeInApp { inapp, subs }
// String describeEnum(Object enumEntry) {
//   if (enumEntry is Enum) return enumEntry.index;
//   final String description = enumEntry.toString();
//   final int indexOfDot = description.indexOf('.');
//   assert(
//     indexOfDot != -1 && indexOfDot < description.length - 1,
//     'The provided object "$enumEntry" is not an enum.',
//   );
//   return description.substring(indexOfDot + 1);
// }

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
  LColor lockCurrentColor =
      LColor(lmainColor: Colors.white, ldensityColors: []);
  Color densityCurrentColor = Colors.blue;
  String _platformVersion = 'Unknown';
  MColor selectedColor =
      MColor(mainColor: MyColors.colorPrimary, densityColors: []);
  LColor lselectedColor = LColor(lmainColor: Colors.white, ldensityColors: []);

  List<MColor> unlockColorList = [];
  List productList = [];
  Color selectedDensityColor = const Color(0xff4e7dcb);
  StreamController<List<Color>> densityColorStream = StreamController();
  StreamController<List<MColor>> unlockColorStream = StreamController();
  StreamController<List<LColor>> lockColorStream = StreamController();
  StreamController<bool> unlockColorController = StreamController();
  StreamController<bool> lockColorController = StreamController();
  final MethodChannel _channel = const MethodChannel('flutter_inapp');
  late StreamSubscription _conectionSubscription;
  late StreamSubscription _purchaseUpdatedSubscription;
  late StreamSubscription _purchaseErrorSubscription;
  final List<String> _productLists = [
    "currency.app_unlock_color",
    "currency.app_no_ads"
  ];
  late InAppProvider _inAppProvider;

  List<LColor> lockedColorList = [];

  Color lockSelectdColor = Colors.blue;
  Color? unlockSelectdColor;
  Color? colorSelection;
  Color? densitySelectedColor;

  @override
  void initState() {
    final inAppProvider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = inAppProvider;

    _inAppProvider.initPlatformState();
    getColorList();
    super.initState();
  }

  @override
  void dispose() {
    _inAppProvider.conectionSubscription.cancel();
    _inAppProvider.purchaseErrorSubscription.cancel();
    _inAppProvider.purchaseUpdatedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final provider = Provider.of<InAppProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25, top: 30, bottom: 0),
            child: Text(
              "unlocked".tr().toString(),
              textScaleFactor: Constants.textScaleFactor,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width * 0.87,
            //height: MediaQuery.of(context).size.height * 0.4,
            child: StreamBuilder<List<MColor>>(
              stream: unlockColorStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MColor> colors = snapshot.data!;

                  MColor selected = selectedColor;

                  return UnlockColorPicker(
                    pickerColor: selected,
                    onColorChanged: onUnlockColorChange,
                    availableColors: colors,
                  );
                }

                return UnlockColorPicker(
                    pickerColor: selectedColor,
                    onColorChanged: onUnlockColorChange,
                    availableColors: unlockColorList
                    // ..add(selectedColor),
                    );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 5),
            child: Text(
              "locked".tr().toString(),
              textScaleFactor: Constants.textScaleFactor,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 5),
            width: MediaQuery.of(context).size.width * 0.87,
            child: StreamBuilder<List<LColor>>(
              stream: lockColorStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<LColor> lockedColors = snapshot.data!;

                  int selectedLockedColorIndex =
                      lockedColors.indexWhere((element) {
                    return element.lmainColor.hex ==
                        lockCurrentColor.lmainColor.hex;
                  });
                  LColor? selectedLockedColor;
                  if (selectedLockedColorIndex != -1) {
                    if (selectedLockedColorIndex > 0) {
                      selectedLockedColor =
                          lockedColors[selectedLockedColorIndex];
                      LColor mColor = lockedColors[0];

                      lockedColors[0] = selectedLockedColor;
                      lockedColors[selectedLockedColorIndex] = mColor;
                    } else {
                      selectedLockedColor =
                          lockedColors[selectedLockedColorIndex];
                    }
                  }
                  return LockColorPicker(
                    pickerColor: selectedLockedColor ??
                        LColor(lmainColor: Colors.white, ldensityColors: []),
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
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: width * 0.87,
                height: height * 0.077,
                child: StreamBuilder<List<Color>>(
                  stream: densityColorStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Color> colors = snapshot.data!;
                      return DensityColorPicker(
                          pickerColor: selectedDensityColor,
                          onColorChanged: onDensityColorChange,
                          availableColors: colors);
                    }

                    return DensityColorPicker(
                        pickerColor: selectedDensityColor,
                        onColorChanged: onDensityColorChange,
                        availableColors: MyColors.lastTimeCheck
                            ? selectedColor.densityColors
                            : lselectedColor.ldensityColors);
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
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent),
                            onPressed: () async {
                              MyColors.lockColorfordefault = lockSelectdColor;
                              MyColors.colorPrimary = colorSelection!;
                              Utility.setStringPreference(
                                  Constants.selectedLockedColor,
                                  lockSelectdColor.value.toRadixString(16));

                              int red = MyColors.colorPrimary.red;
                              int blue = MyColors.colorPrimary.blue;
                              int green = MyColors.colorPrimary.green;

                              var grayscale = (0.299 * red) +
                                  (0.587 * green) +
                                  (0.114 * blue);
                              debugPrint("grayscale----> $grayscale");

                              if (grayscale > 200) {
                                MyColors.textColor = Colors.grey.shade700;
                                MyColors.insideTextFieldColor = Colors.white;

                                MyColors.isDarkMode = true;
                              } else {
                                MyColors.textColor = Colors.white;
                                MyColors.insideTextFieldColor = Colors.black;
                                MyColors.isDarkMode = false;
                              }
                              SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                                systemNavigationBarIconBrightness:
                                    !MyColors.isDarkMode
                                        ? Brightness.light
                                        : Brightness.dark,
                                systemNavigationBarColor: MyColors
                                    .colorPrimary, // navigation bar color
                                statusBarColor:
                                    MyColors.colorPrimary, // status bar color
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
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent),
                            onPressed: () async {
                              await provider.getProduct();
                              provider.items
                                  .map((item) => provider.requestPurchase(item))
                                  .toList();
                              provider.purchaseUpdatedSubscription =
                                  FlutterInappPurchase.purchaseUpdated
                                      .listen((productItem) async {
                                if (productItem!.productId!.isNotEmpty) {
                                  debugPrint("colorEvent");
                                  final Map eventValues = {
                                    "af_content_id": uuid.v1(),
                                    "af_currency":
                                        provider.getProductCurrencyCode,
                                    "af_revenue": provider.getProductPrice
                                  };
                                  provider.logEvent(
                                      eventName: "colorEvent",
                                      eventValues: eventValues);

                                  if (colorSelection != null) {
                                    MyColors.lockColorfordefault =
                                        lockSelectdColor;
                                    MyColors.colorPrimary = colorSelection!;
                                    String code = lockSelectdColor.value
                                        .toRadixString(16);
                                    await dbHelper.deSelectColor();
                                    await dbHelper.insertColor(ColorTable(
                                      previousColor: 0,
                                      colorCode: code,
                                      selected: 1,
                                      isLocked: ColorsConst.unLockedColor,
                                    ));

                                    await dbHelper.removeColor(ColorTable(
                                        colorCode: code,
                                        selected: 1,
                                        previousColor: 0,
                                        isLocked: ColorsConst.lockedColor));

                                    if (densitySelectedColor != null) {
                                      Set<Color> densityColorList = {
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade50,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade100,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade200,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade300,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade400,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade500,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade600,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade700,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade800,
                                        ColorTools.createPrimarySwatch(
                                                densitySelectedColor!)
                                            .shade900,
                                      };

                                      for (var dencityColor
                                          in densityColorList) {
                                        String code1 = dencityColor.value
                                            .toRadixString(16);
                                        await dbHelper
                                            .insertDensityColor(DensityColor(
                                          previousColor: "0",
                                          colorCode: code1,
                                          selected: "0",
                                          parentColorCode: code,
                                        ));
                                      }
                                    }
                                  } else if (lockSelectdColor != null) {
                                    await dbHelper.deSelectColor();
                                    String colorCode = lockSelectdColor.value
                                        .toRadixString(16);
                                    await dbHelper.selectColor(ColorTable(
                                      previousColor: 0,
                                      colorCode: colorCode,
                                      selected: 1,
                                      isLocked: ColorsConst.lockedColor,
                                    ));

                                    MyColors.colorPrimary = lockSelectdColor;
                                  }

                                  int red = MyColors.colorPrimary.red;
                                  int blue = MyColors.colorPrimary.blue;
                                  int green = MyColors.colorPrimary.green;
                                  var grayscale = (0.299 * red) +
                                      (0.587 * green) +
                                      (0.114 * blue);

                                  if (grayscale > 200) {
                                    MyColors.textColor = Colors.grey.shade700;
                                    MyColors.insideTextFieldColor =
                                        Colors.white;
                                    MyColors.isDarkMode = true;
                                  } else {
                                    MyColors.textColor = Colors.white;
                                    MyColors.insideTextFieldColor =
                                        Colors.black;
                                    MyColors.isDarkMode = false;
                                  }
                                  SystemChrome.setSystemUIOverlayStyle(
                                      SystemUiOverlayStyle(
                                    // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                                    systemNavigationBarIconBrightness:
                                        !MyColors.isDarkMode
                                            ? Brightness.light
                                            : Brightness.dark,
                                    systemNavigationBarColor: MyColors
                                        .colorPrimary, // navigation bar color
                                    statusBarColor: MyColors
                                        .colorPrimary, // status bar color
                                  ));

                                  await Utility.setStringPreference(
                                      Constants.primaryColorCode,
                                      colorSelection!.value.toString());

                                  Utility.setStringPreference(
                                      Constants.selectedLockedColor,
                                      colorSelection!.value.toRadixString(16));

                                  Utility.notifyThemeChange();
                                  widget.onThemeChange();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyTabBarWidget()),
                                      (route) => true);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                              });
                              setState(() {});
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
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.05,
                  width: width * 0.60,
                  child: Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: width * 0.60,
                        ),
                        padding: const EdgeInsets.only(
                          top: 9.0,
                        ),
                        height: height * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            showCustomColorPickerDialog(context);
                          },
                          child: AutoSizeText(
                            "cpv_custom".tr().toString(),
                            textScaleFactor: Constants.textScaleFactor,
                            style: const TextStyle(
                                letterSpacing: 0.8,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
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
                                onTap: () async {
                                  if (unlockSelectdColor != null &&
                                      densitySelectedColor != null) {
                                    String code = densitySelectedColor!.value
                                        .toRadixString(16);
                                    await dbHelper.deSelectColor();
                                    await dbHelper.insertColor(ColorTable(
                                      previousColor: 0,
                                      colorCode: code,
                                      selected: 1,
                                      isLocked: ColorsConst.unLockedColor,
                                    ));

                                    Set<Color> densityColorList = {
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade50,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade100,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade200,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade300,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade400,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade500,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade600,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade700,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade800,
                                      ColorTools.createPrimarySwatch(
                                              densitySelectedColor!)
                                          .shade900,
                                    };

                                    for (var dencityColor in densityColorList) {
                                      String code1 =
                                          dencityColor.value.toRadixString(16);
                                      await dbHelper
                                          .insertDensityColor(DensityColor(
                                        previousColor: "0",
                                        colorCode: code1,
                                        selected: "0",
                                        parentColorCode: code,
                                      ));
                                    }

                                    MyColors.colorPrimary =
                                        densitySelectedColor!;
                                  } else if (unlockSelectdColor != null) {
                                    await dbHelper.deSelectColor();
                                    String colorCode = unlockSelectdColor!.value
                                        .toRadixString(16);
                                    await dbHelper.selectColor(ColorTable(
                                      previousColor: 0,
                                      colorCode: colorCode,
                                      selected: 1,
                                      isLocked: ColorsConst.unLockedColor,
                                    ));

                                    MyColors.colorPrimary = unlockSelectdColor!;
                                  }

                                  int red = MyColors.colorPrimary.red;
                                  int blue = MyColors.colorPrimary.blue;
                                  int green = MyColors.colorPrimary.green;

                                  var grayscale = (0.299 * red) +
                                      (0.587 * green) +
                                      (0.114 * blue);

                                  if (grayscale > 200) {
                                    MyColors.textColor = Colors.grey.shade700;
                                    MyColors.insideTextFieldColor =
                                        Colors.white;

                                    MyColors.isDarkMode = true;

                                    await Utility.setBooleanPreference(
                                      Constants.isDarkMode,
                                      true,
                                    );
                                  } else {
                                    MyColors.textColor = Colors.white;
                                    MyColors.insideTextFieldColor =
                                        Colors.black;
                                    MyColors.isDarkMode = false;
                                    await Utility.setBooleanPreference(
                                      Constants.isDarkMode,
                                      false,
                                    );
                                  }
                                  SystemChrome.setSystemUIOverlayStyle(
                                      SystemUiOverlayStyle(
                                    // statusBarIconBrightness: MyColors.lightModeCheck ? Brightness.light : Brightness.dark,
                                    systemNavigationBarIconBrightness:
                                        !MyColors.isDarkMode
                                            ? Brightness.light
                                            : Brightness.dark,
                                    systemNavigationBarColor: MyColors
                                        .colorPrimary, // navigation bar color
                                    statusBarColor: MyColors
                                        .colorPrimary, // status bar color
                                  ));
                                  await Utility.setStringPreference(
                                      Constants.primaryColorCode,
                                      unlockSelectdColor!.value
                                          .toRadixString(16));
                                  Utility.notifyThemeChange();
                                  // Utility.setStringPreference(Constants.themeColor,
                                  //     unlockSelectdColor!.value.toString());

                                  // Utility.setStringPreference(
                                  //     Constants.themeofDensityColor,
                                  //     densitySelectedColor.value.toString());
                                  unlockColorController
                                      .add(widget.isUnlockColorSelect);
                                  // themepicker(densitySelectedColor.value.toString());
                                  // themepicker(unlockSelectdColor!.value.toString());

                                  widget.onThemeChange();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "cpv_select".tr().toString(),
                                  textScaleFactor: Constants.textScaleFactor,
                                  style: const TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }

                          return Text(
                            "",
                            textScaleFactor: Constants.textScaleFactor,
                          );
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showCustomColorPickerDialog(BuildContext context) async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
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
                child: CustomColorPicker(
                  onThemeChange: widget.onThemeChange,
                ),
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

    densitySelectedColor = null;
    densityColorStream.add(color.densityColors);
    selectedColor = color;
    lockColorStream.add(lockedColorList);
  }

  void onLockColorChange(LColor color) {
    MyColors.unclockCheck = false;
    MyColors.densitycheck = false;

    unlockColorController.add(false);
    lockColorController.add(true);

    lockSelectdColor = color.lmainColor;
    colorSelection = lockSelectdColor;
    lselectedColor = color;

    densitySelectedColor = null;
    densityColorStream.add(color.ldensityColors);
    unlockColorStream.add(unlockColorList);
  }

  void onDensityColorChange(Color color) {
    Utility.setStringPreference("DensityColor", color.value.toString());
    selectedDensityColor = color;
    MyColors.unclockCheck = false;
    MyColors.lockCheck = false;

    // widget.isLockedColor = true;

    lockColorController.add(true);

    densitySelectedColor = color;
    colorSelection = densitySelectedColor;
    lockColorStream.add(lockedColorList);

    lockSelectdColor = color;
    unlockColorStream.add(unlockColorList);

    widget.densitychangeColor(color);
    debugPrint(
        "selected color -> ${densityCurrentColor.value.toRadixString(16)}");
  }

  static void themepicker(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.themeColor, code);
  }

  void getSelectedColor() async {
    Color c = MyColors.colorPrimary;
    lockedColorList.clear();

    int selectedLockColorIndex = lockedColorList
        .indexWhere((element) => element.lmainColor.hex == c.hex);
    int selectedUnlockColorIndex =
        unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    if (selectedLockColorIndex == -1 && selectedUnlockColorIndex == -1) {
      LColor newLockColor =
          LColor(lmainColor: MyColors.colorPrimary, ldensityColors: [
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
      lockedColorList.add(newLockColor);
      lockedColorList.addAll(lockedColorList);
    } else {
      lockedColorList.addAll(lockedColorList);
    }

    selectedLockColorIndex = lockedColorList
        .indexWhere((element) => element.lmainColor.hex == c.hex);
    selectedUnlockColorIndex =
        unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    if (selectedLockColorIndex != -1) {
      lockCurrentColor = lockedColorList[selectedLockColorIndex];
      densityColorStream
          .add(unlockColorList[selectedLockColorIndex].densityColors);
    }

    if (selectedUnlockColorIndex != -1) {
      densityColorStream
          .add(unlockColorList[selectedUnlockColorIndex].densityColors);
    }
    unlockColorStream.add(unlockColorList);

    String colorPreference =
        await Utility.getStringPreference(Constants.selectedLockedColor);
    int index = lockedColorList.indexWhere((element) =>
        element.lmainColor.value.toRadixString(16) == colorPreference);
    debugPrint("index------>$index");
    debugPrint("colorPreference------>$colorPreference");

    if (colorPreference != "" && index != -1) {
      LColor temp = lockedColorList[0];
      lockedColorList[0] = lockedColorList[index];
      lockedColorList[index] = temp;
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

      lockedColorList.add(newLockColor);
      LColor temp = lockedColorList[0];
      lockedColorList[0] = lockedColorList.last;
      lockedColorList.last = temp;
    }

    lockColorStream.add(lockedColorList);
    next();
  }

  next() {
    Color c = MyColors.colorPrimary;
    unlockColorController.add(widget.isUnlockColorSelect);
    lockColorController.add(widget.isLockedColor);
    // unlockCurrentColor = widget.unlockCurrentColor;
    // densityCurrentColor = widget.densityCurrentColor;

    // int selectedLockColorIndex = lockedColorList
    //     .indexWhere((element) => element.lmainColor.hex == c.hex);

    // int selectedUnlockColorIndex =
    //     unlockColorList.indexWhere((element) => element.mainColor.hex == c.hex);

    // debugPrint("selectedLockColorIndex---->$selectedLockColorIndex");
    // debugPrint("selectedUnlockColorIndex---->$selectedUnlockColorIndex");

    // if (selectedUnlockColorIndex != -1) {
    //   selectedColor = unlockColorList[selectedUnlockColorIndex];
    // }

    // debugPrint("selectedColor---->$selectedColor");

    // int i = lockedColorList.indexWhere((element) {
    //   return element.lmainColor.hex == c.hex;
    // });

    // debugPrint("selectedNewLockColorIndex---->$i");

    // if (i != -1) {
    //   lselectedColor = lockedColorList[i];
    // }
  }

  void getColorList() async {
    List<ColorTable> colors = await dbHelper.getColors();
    debugPrint("productList>>>>$productList");
    lockedColorList = await getLockedColor(colors);
    unlockColorList = await getUnlockColor(colors);
    debugPrint("unlockColorList---------------->${unlockColorList.length}");
    debugPrint("lockedColorList---------------->${lockedColorList.length}");
    unlockColorStream.add(unlockColorList);
    lockColorStream.add(lockedColorList);
    int index = unlockColorList.indexWhere(
        (element) => element.mainColor.hex == MyColors.colorPrimary.hex);
    if (index != -1) {
      selectedColor = unlockColorList[index];
      densityColorStream.add(selectedColor.densityColors);
      MyColors.unclockCheck = true;
      MyColors.lockCheck = false;
      MyColors.densitycheck = false;
    }

    String lockedColor =
        await Utility.getStringPreference(Constants.selectedLockedColor);

    bool isColorExist = await dbHelper.checkColorCodeExist(ColorTable(
        colorCode: lockedColor,
        isLocked: ColorsConst.lockedColor,
        previousColor: 0,
        selected: 1));
    Color mcolor = Color(int.parse("0x$lockedColor"));
    if (!isColorExist) {
      Set<Color> densityColor = {
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
      };

      lockedColorList.add(
          LColor(lmainColor: mcolor, ldensityColors: densityColor.toList()));
    }

    int lockedColorIndex = lockedColorList
        .indexWhere((element) => element.lmainColor.hex == mcolor.hex);

    if (lockedColorIndex != -1) {
      lockCurrentColor = lockedColorList[lockedColorIndex];
      if (lockCurrentColor.lmainColor.hex == MyColors.colorPrimary.hex) {
        densityColorStream.add(lockCurrentColor.ldensityColors);
      }

      MyColors.unclockCheck = true;
      MyColors.lockCheck = false;
      MyColors.densitycheck = false;
    }
    unlockColorStream.add(unlockColorList);
    lockColorStream.add(lockedColorList);
    next();

    // getSelectedColor();
  }

  Future<List<LColor>> getLockedColor(List<ColorTable> colors) async {
    List<LColor> lockedColor = [];
    List<ColorTable> color = colors
        .where((element) => element.isLocked == ColorsConst.lockedColor)
        .toList();

    await Future.forEach(color, (ColorTable element) async {
      int colorCode = int.parse("0x" + element.colorCode);
      List<Color> ldensityColors = [];

      List<DensityColor> dsColor =
          await dbHelper.getDensityColors(element.colorCode);

      debugPrint("dsColor-->${dsColor.length}");

      await Future.forEach(dsColor, (DensityColor ds) async {
        int code = int.parse("0x" + ds.colorCode);
        ldensityColors.add(Color(code));
      });

      LColor lColor =
          LColor(lmainColor: Color(colorCode), ldensityColors: ldensityColors);
      debugPrint("lColor-->${lColor.ldensityColors.length}");

      lockedColor.add(lColor);
      densityColorStream.add(lselectedColor.ldensityColors);
    });

    return lockedColor;
  }

  Future<List<MColor>> getUnlockColor(List<ColorTable> colors) async {
    List<MColor> unLockedColor = [];
    List<ColorTable> color = colors
        .where((element) => element.isLocked == ColorsConst.unLockedColor)
        .toList();

    await Future.forEach(color, (ColorTable element) async {
      int colorCode = int.parse("0x" + element.colorCode);
      List<Color> densityColors = [];
      List<DensityColor> dsColor =
          await dbHelper.getDensityColors(element.colorCode);
      debugPrint("dsColor-->${dsColor.length}");
      await Future.forEach(dsColor, (DensityColor ds) async {
        int code = int.parse("0x" + ds.colorCode);
        densityColors.add(Color(code));
      });

      MColor mColor =
          MColor(mainColor: Color(colorCode), densityColors: densityColors);
      debugPrint("lColor-->${mColor.densityColors.length}");

      unLockedColor.add(mColor);
    });

    return unLockedColor;
  }
}
