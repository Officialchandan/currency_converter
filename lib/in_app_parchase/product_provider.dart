import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:currency_converter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import '../utils/constants.dart';

enum _TypeInApp { inapp, subs }

class InAppProvider with ChangeNotifier {
  final MethodChannel _channel = const MethodChannel('flutter_inapp');
  late StreamSubscription conectionSubscription;
  late StreamSubscription purchaseUpdatedSubscription;
  late StreamSubscription purchaseErrorSubscription;
  final List<String> productLists = [
    "currency.app_unlock_color",
    "currency.app_no_ads"
  ];
  String logEventResponse = "No event have been sent";
  final Map eventValues = {
    "af_content_id": "id123",
    "af_currency": "USD",
    "af_revenue": "2.5"
  };
  List<IAPItem> items = [];
  List<IAPItem> getSubscriptionItems = [];
  List<IAPItem> getProductItems = [];
  List<PurchasedItem> purchases = [];

  String getSubscriptionPrice = "";
  String getSubscriptionCurrencyCode = "";
  String getProductPrice = "";
  String getProductCurrencyCode = "";

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
    print("valueOfItems-->$items");
    for (var item in items) {
      this.items.add(item);
    }
    this.items = items;
    items.forEach((element) {
      String currencyPriceData = element.originalJson!;
      var stringDecode = json.decode(currencyPriceData);
      getProductPrice = stringDecode['price'];
      getProductCurrencyCode = stringDecode['price_currency_code'];
      print("getSubCurrency-${stringDecode['price_currency_code']}");
      print("getSubCurrency-${stringDecode['price']}");
    });
    purchases = [];
    getProductItems = items;
    notifyListeners();
  }

  requestPurchase(IAPItem item) async {
    try {
      // await FlutterInappPurchase.instance.requestPurchase(item.productId);
      await _channel.invokeMethod('buyItemByType', <String, dynamic>{
        'type': EnumUtil.getValueString(_TypeInApp.inapp),
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
    getSubscriptionItems = subItemList;
    purchases = [];
    subItemList.forEach((element) {
      String currencyPriceData = element.originalJson!;
      var stringDecode = json.decode(currencyPriceData);
      getSubscriptionPrice = stringDecode['price'];
      getSubscriptionCurrencyCode = stringDecode['price_currency_code'];
      print("getSubCurrency-${stringDecode['price_currency_code']}");
      print("getSubCurrency-${stringDecode['price']}");
    });

    notifyListeners();
    print("subItemList-->${subItemList}");
    return subItemList;
  }

  Future<bool?> logEvent({required String eventName, Map? eventValues}) async {
    debugPrint("logEventResponse-->$logEventResponse");
    bool? result;
    try {
      result = await Constants.appsflyerSdk
          .logEvent(eventName, eventValues!)
          .then((onValue) {
        logEventResponse = onValue.toString();
        notifyListeners();
      }).catchError((onError) {});
    } on Exception catch (e) {
      print("ExLogEvent");
    }
    print("Result logEvent: $result");
    return null;
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

  Future getPurchaseHistoryOfAds() async {
    print("getPurchaseHistory");
    try {
      String getPurchaseHistoryOfAds = await _channel.invokeMethod(
        'getPurchaseHistoryByType',
        <String, dynamic>{
          'type': EnumUtil.getValueString(_TypeInApp.subs),
        },
      );
      log("getInAppPurchaseHistory-->$getPurchaseHistoryOfAds");
      // items = await FlutterInappPurchase.instance.getPurchaseHistory();
      var historyList = json.decode(getPurchaseHistoryOfAds);
      print("historyList->${historyList[0]['transactionDate']}");
      Constants.isPurchaseOfAds = historyList[0]['transactionDate'];
      int time = historyList[0]['transactionDate'];
      Utility.setIntPreference(Constants.yearCheckTimeCons, time);
      notifyListeners();
    } catch (e) {
      debugPrint("exception--$e");
    }
    notifyListeners();
  }

  Future getAvailablePurchase() async {
    String msg = "";
    print("getAvailablePurchase0");
    try {
      msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('getAvailablePurchase1: $msg');
    } catch (err) {
      print('getAvailablePurchase2: $err');
    }
    print("getAvailablePurchase3-->${msg}");
    print(
        "getAvailablePurchase4-->${FlutterInappPurchase.instance.consumeAllItems.toString()}");
  }

  Future validateReceipt() async {
    print("validateReceipt");
    try {
      var isValid = await FlutterInappPurchase.instance.validateReceiptAndroid(
          packageName: "com.example.currency_converter",
          productId: "currency.app_no_ads",
          productToken:
              "cmoplgpnmdggnbbapbjdbjdp.AO-J1Ox8HO07vAQs3Okd-2zeEimZytu0e38aUdmFplPeTDdPZiCsBR-pVT2IcL41Ol8kyO06-llTpWDJA8A",
          accessToken:
              "cmoplgpnmdggnbbapbjdbjdp.AO-J1Ox8HO07vAQs3Okd-2zeEimZytu0e38aUdmFplPeTDdPZiCsBR-pVT2IcL41Ol8kyO06-llTpWDJA8A");
      print("isValid-->$isValid");
    } catch (e) {
      print("e---->$e");
    }
  }

  Future getPurchaseHistoryOfColors() async {
    print("getPurchaseHistoryOfColors");
    try {
      String getPurchaseHistoryOfColors = await _channel.invokeMethod(
        'getPurchaseHistoryByType',
        <String, dynamic>{
          'type': EnumUtil.getValueString(_TypeInApp.inapp),
        },
      );
      log("getPurchaseHistoryOfColors-->$getPurchaseHistoryOfColors");
      // items = await FlutterInappPurchase.instance.getPurchaseHistory();
      Constants.isPurchaseOfColors = getPurchaseHistoryOfColors;
      notifyListeners();
    } catch (e) {
      debugPrint("exception--$e");
    }
    notifyListeners();
  }
}

class EnumUtil {
  static String getValueString(dynamic enumType) =>
      enumType.toString().split('.')[1];
}
