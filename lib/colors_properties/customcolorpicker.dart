import 'dart:io';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:currency_converter/Themes/colors.dart';
import 'package:currency_converter/in_app_parchase/in_methods_app.dart';
import 'package:currency_converter/pages/home/home_page.dart';
import 'package:currency_converter/utils/constants.dart';
import 'package:currency_converter/utils/utility.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class CustomColorPicker extends StatefulWidget {
  final Function onThemeChange;
  const CustomColorPicker({required this.onThemeChange, Key? key})
      : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Color currentColor = MyColors.colorPrimary;
  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
              Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(
                    "try_this_color".tr().toString(),
                    textScaleFactor: Constants.textScaleFactor,
                  ),
                  onPressed: () {
                    MyColors.lockColorfordefault = currentColor;
                    Utility.setTryColorPreference(
                        "Color", currentColor.value.toRadixString(16));

                    int red = currentColor.red;
                    int blue = currentColor.blue;
                    int green = currentColor.green;

                    var grayscale =
                        (0.299 * red) + (0.587 * green) + (0.114 * blue);
                    print("************************-> $grayscale");

                    if (grayscale > 170) {
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

                    MyColors.colorPrimary = currentColor;

                    MyColors.calcuColor = currentColor;
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      // statusBarIconBrightness: MyColors.lightModeCheck?Brightness.light:Brightness.dark,
                      //
                      //
                      systemNavigationBarIconBrightness: MyColors.lightModeCheck
                          ? Brightness.light
                          : Brightness.dark,

                      systemNavigationBarColor:
                          MyColors.colorPrimary, // navigation bar color
                      statusBarColor: MyColors.colorPrimary, // status bar color
                    ));
                    widget.onThemeChange();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MyTabBarWidget()),
                        (route) => false);
                  },
                ),
              ),
              Container(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async {
                        debugPrint("PRESSED UNLOCK BUTTON");
                        Map<String, PurchaseDetails> purchases =
                            Map.fromEntries(InMethodsApp.purchases
                                .map((PurchaseDetails purchase) {
                          if (purchase.pendingCompletePurchase) {
                            InMethodsApp.inAppPurchase
                                .completePurchase(purchase);
                          }
                          return MapEntry<String, PurchaseDetails>(
                              purchase.productID, purchase);
                        }));

                        InMethodsApp.productList.addAll(InMethodsApp.products
                            .map((ProductDetails productDetails) {
                          PurchaseDetails? previousPurchase =
                              purchases[productDetails.id];

                          if (previousPurchase != null) {
                            InMethodsApp().confirmPriceChange(context);
                          } else {
                            late PurchaseParam purchaseParam;

                            if (Platform.isAndroid) {
                              final oldSubscription = InMethodsApp()
                                  .getOldSubscription(
                                      productDetails, purchases);

                              purchaseParam = GooglePlayPurchaseParam(
                                  productDetails: productDetails,
                                  applicationUserName: null,
                                  changeSubscriptionParam: (oldSubscription !=
                                          null)
                                      ? ChangeSubscriptionParam(
                                          oldPurchaseDetails: oldSubscription,
                                          prorationMode: ProrationMode
                                              .immediateWithTimeProration,
                                        )
                                      : null);
                            } else {
                              purchaseParam = PurchaseParam(
                                productDetails: productDetails,
                                applicationUserName: null,
                              );
                            }

                            if (productDetails.id == KeysForId.kUpgradeId) {
                              InMethodsApp.inAppPurchase.buyNonConsumable(
                                purchaseParam: purchaseParam,
                                // autoConsume:
                                //     KeysForId.kAutoConsume || Platform.isIOS
                              );
                              setState(() {});
                            } else {
                              InMethodsApp.inAppPurchase.buyNonConsumable(
                                purchaseParam: purchaseParam,
                                // autoConsume:
                                //     KeysForId.kAutoConsume || Platform.isIOS
                              );
                              setState(() {});
                            }
                          }
                          return const ListTile();
                        }));
                      },
                      child: Text(
                        "unlock".tr().toString(),
                        textScaleFactor: Constants.textScaleFactor,
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
