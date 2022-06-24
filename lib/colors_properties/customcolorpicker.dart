import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/in_app_parchase/product_provider.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flex_color_picker/flex_color_picker.dart' as flex;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:provider/provider.dart';

import '../database/color_data.dart';
import '../main.dart';

class CustomColorPicker extends StatefulWidget {
  final Function onThemeChange;
  const CustomColorPicker({required this.onThemeChange, Key? key})
      : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color currentColor = MyColors.colorPrimary;
  late InAppProvider _inAppProvider;

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  void initState() {
    final inAppProvider = Provider.of<InAppProvider>(context, listen: false);
    _inAppProvider = inAppProvider;

    _inAppProvider.initPlatformState();
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
    final provider = Provider.of<InAppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.695,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, bottom: 0, left: 10),
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: false,
                showLabel: true,
                paletteType: PaletteType.hsl,
                portraitOnly: false,
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent,
                  ),
                  child: Text(
                    "try_this_color".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    MyColors.lockColorfordefault = currentColor;
                    Utility.setStringPreference(Constants.selectedLockedColor,
                        currentColor.value.toRadixString(16));
                    int red = currentColor.red;
                    int blue = currentColor.blue;
                    int green = currentColor.green;

                    var grayscale =
                        (0.299 * red) + (0.587 * green) + (0.114 * blue);
                    debugPrint("grayscale-> $grayscale");

                    if (grayscale > 200) {
                      MyColors.textColor = Colors.grey.shade700;
                      MyColors.insideTextFieldColor = Colors.white;

                      MyColors.isDarkMode = true;
                    } else {
                      MyColors.textColor = Colors.white;
                      MyColors.insideTextFieldColor = Colors.black;
                      MyColors.isDarkMode = false;
                    }
                    MyColors.colorPrimary = currentColor;
                    MyColors.calcuColor = currentColor;
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      systemNavigationBarIconBrightness: !MyColors.isDarkMode
                          ? Brightness.light
                          : Brightness.dark,
                      systemNavigationBarColor:
                          MyColors.colorPrimary, // navigation bar color
                      statusBarColor: MyColors.colorPrimary, // status bar color
                    ));
                    await Utility.setStringPreference(
                        Constants.primaryColorCode,
                        currentColor.value.toRadixString(16));
                    Utility.notifyThemeChange();
                    widget.onThemeChange();
                    setState(() {});
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MyTabBarWidget()),
                        (route) => false);
                  },
                ),
              ),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigoAccent,
                      ),
                      onPressed: () async {
                        await provider.getProduct();
                        provider.items
                            .map((item) => provider.requestPurchase(item))
                            .toList();
                        provider.purchaseUpdatedSubscription =
                            FlutterInappPurchase.purchaseUpdated
                                .listen((productItem) async {
                          if (productItem!.productId!.isNotEmpty) {
                            final Map eventValues = {
                              "af_content_id": uuid.v1(),
                              "af_currency": provider.getProductCurrencyCode,
                              "af_revenue": provider.getProductPrice
                            };
                            provider.logEvent(
                                eventName: "CustomColorEvent",
                                eventValues: eventValues);
                            debugPrint("productItem>>>>>>>");
                            MyColors.lockColorfordefault = currentColor;
                            MyColors.colorPrimary = currentColor;

                            int red = MyColors.colorPrimary.red;
                            int blue = MyColors.colorPrimary.blue;
                            int green = MyColors.colorPrimary.green;
                            var grayscale = (0.299 * red) +
                                (0.587 * green) +
                                (0.114 * blue);
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
                              systemNavigationBarColor:
                                  MyColors.colorPrimary, // navigation bar color
                              statusBarColor:
                                  MyColors.colorPrimary, // status bar color
                            ));
                            String code = currentColor.value.toRadixString(16);
                            await dbHelper.deSelectColor();
                            await dbHelper.insertColor(ColorTable(
                              previousColor: 0,
                              colorCode: code,
                              selected: 1,
                              isLocked: ColorsConst.unLockedColor,
                            ));

                            List<Color> densityColorList = [
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade50,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade100,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade200,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade300,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade400,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade500,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade600,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade700,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade800,
                              flex.ColorTools.createPrimarySwatch(
                                      currentColor)
                                  .shade900,
                            ];
                            for (var dencityColor in densityColorList) {
                              String code1 =
                                  dencityColor.value.toRadixString(16);
                              await dbHelper.insertDensityColor(DensityColor(
                                previousColor: "0",
                                colorCode: code1,
                                selected: "0",
                                parentColorCode: code,
                              ));
                            }
                            await Utility.setStringPreference(
                                Constants.primaryColorCode,
                                currentColor.value.toRadixString(16));
                            await Utility.setStringPreference(
                                Constants.selectedLockedColor,
                                currentColor.value.toRadixString(16));
                            Utility.notifyThemeChange();
                            widget.onThemeChange();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MyTabBarWidget()),
                                (route) => true);
                            setState(() {});
                          }
                        });
                        setState(() {});
                      },
                      child: Text(
                        "unlock".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
                        style: const TextStyle(fontSize: 16),
                      )))
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: AutoSizeText(
                "cpv_presets".tr().toString().toUpperCase(),
                maxLines: 1,
                textScaleFactor: Constants.textScaleFactor,
                style: const TextStyle(
                    letterSpacing: 0.8,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
