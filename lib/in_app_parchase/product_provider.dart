import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import '../utils/constants.dart';

enum _TypeInApp { inapp, subs }
String describeEnum(Object enumEntry) {
  if (enumEntry is Enum) return enumEntry.name;
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}

List<IAPItem> extractItems(dynamic result) {
  print("extractItems");
  List list = json.decode(result.toString());
  List<IAPItem> products = list
      .map<IAPItem>(
        (dynamic product) => IAPItem.fromJSON(product as Map<String, dynamic>),
      )
      .toList();
  // print("products$products");
  return products;
}

class InAppProvider with ChangeNotifier {
  final MethodChannel _channel = const MethodChannel('flutter_inapp');
  late StreamSubscription conectionSubscription;
  late StreamSubscription purchaseUpdatedSubscription;
  late StreamSubscription purchaseErrorSubscription;
  final List<String> productLists = [
    "currency.app_unlock_color",
    "currency.app_no_ads"
  ];
  List<IAPItem> items = [];
  List<IAPItem> getSubscriptionItems = [];
  List<PurchasedItem> purchases = [];
  Future<void> initPlatformState() async {
    String? platformVersion;
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    await FlutterInappPurchase.instance.initConnection;
    try {
      String consumeAllItems =
          await FlutterInappPurchase.instance.consumeAllItems;
      print("consumeAllItems$consumeAllItems");
    } catch (err) {
      print('err-$err');
    }
    conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {});

    purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {});
    purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {});
  }

  Future getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(productLists);
    for (var item in items) {
      this.items.add(item);
    }
    this.items = items;
    purchases = [];
    notifyListeners();
  }

  requestPurchase(IAPItem item) async {
    try {
      // await FlutterInappPurchase.instance.requestPurchase(item.productId);
      await _channel.invokeMethod('buyItemByType', <String, dynamic>{
        'type': describeEnum(_TypeInApp.inapp),
        'sku': item.productId,
        'oldSku': item.productId,
        'prorationMode': -1,
        'obfuscatedAccountId': "",
        'obfuscatedProfileId': '',
        'purchaseToken': "",
      });
    } catch (e) {
      debugPrint('ee-->$e');
    }
  }

  Future<List<IAPItem>> getSubscriptions(List<String> skus) async {
    print("getSubscription");
    List<IAPItem> subItemList =
        await FlutterInappPurchase.instance.getSubscriptions(skus);

    for (var subItem in subItemList) {
      getSubscriptionItems.add(subItem);
    }
    getSubscriptionItems = subItemList;
    purchases = [];
    notifyListeners();
    print("subItemList-->$subItemList");
    return subItemList;
  }

  requestSubscription(String sku) async {
    print("requestSubscription");
    try {
      List<String> listItem =
          await FlutterInappPurchase.instance.requestSubscription(sku);
      print("listItem--$listItem");
      notifyListeners();
    } catch (e) {
      debugPrint('ee-->$e');
    }
  }

  Future getPurchaseHistory() async {
    print("getPurchaseHistory");
    try {
      String getInappPurchaseHistory = await _channel.invokeMethod(
        'getPurchaseHistoryByType',
        <String, dynamic>{
          'type': describeEnum(_TypeInApp.subs),
        },
      );
      log("getInAppPurchaseHistory-->$getInappPurchaseHistory");
      // items = await FlutterInappPurchase.instance.getPurchaseHistory();
      Constants.isPurchase = getInappPurchaseHistory;
      notifyListeners();
    } catch (e) {
      debugPrint("exception--$e");
    }

    notifyListeners();
  }
}
