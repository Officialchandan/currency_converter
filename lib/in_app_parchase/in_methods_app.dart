import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'consumable_store.dart';

class KeysForId {
  static bool kAutoConsume = true;
  static String kUpgradeId = 'currency.app_unlock_color';
  static String kSilverSubscriptionId = 'currency.app_no_ads';
  static List<String> kProductIds = <String>[
    kUpgradeId,
    kSilverSubscriptionId,
  ];
}

class InMethodsApp {
  static InAppPurchase inAppPurchase = InAppPurchase.instance;
  static late StreamSubscription<List<PurchaseDetails>> subscription;
  static List<ListTile> productList = <ListTile>[];

  static List<String> notFoundIds = [];
  static List<ProductDetails> products = [];
  static List<PurchaseDetails> purchases = [];
  static List<String> _consumables = [];
  static bool _isAvailable = false;
  static bool _purchasePending = false;
  static bool _loading = true;
  static String? _queryProductError;

  Future<void> initStoreInfo() async {
    final bool isAvailable = await inAppPurchase.isAvailable();
    if (!isAvailable) {
      // setState(() {
      _isAvailable = isAvailable;
      products = [];
      purchases = [];
      notFoundIds = [];
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(KeysForId.kProductIds.toSet());
    if (productDetailResponse.error != null) {
      // setState(() {
      _queryProductError = productDetailResponse.error!.message;
      _isAvailable = isAvailable;
      products = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      // setState(() {
      _queryProductError = null;
      _isAvailable = isAvailable;
      products = productDetailResponse.productDetails;
      purchases = [];
      notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      // });
      return;
    }

    List<String> consumables = await ConsumableStore.load();
    // setState(() {
    _isAvailable = isAvailable;
    products = productDetailResponse.productDetails;
    notFoundIds = productDetailResponse.notFoundIDs;
    _consumables = consumables;
    _purchasePending = false;
    _loading = false;
    // });
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    // setState(() {
    _consumables = consumables;
    // });
  }

  void showPendingUI() {
    // setState(() {
    _purchasePending = true;
    // });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == KeysForId.kUpgradeId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      // setState(() {
      _purchasePending = false;
      _consumables = consumables;
      // });
    } else {
      // setState(() {
      purchases.add(purchaseDetails);
      _purchasePending = false;
      // });
    }
  }

  void handleError(IAPError error) {
    // setState(() {
    _purchasePending = false;
    // });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!KeysForId.kAutoConsume &&
              purchaseDetails.productID == KeysForId.kUpgradeId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      var priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      var iapStoreKitPlatformAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == KeysForId.kSilverSubscriptionId &&
        purchases[KeysForId.kSilverSubscriptionId] != null) {
      oldSubscription = purchases[KeysForId.kSilverSubscriptionId]
          as GooglePlayPurchaseDetails;
    } else if (productDetails.id == KeysForId.kSilverSubscriptionId &&
        purchases[KeysForId.kSilverSubscriptionId] != null) {
      oldSubscription = purchases[KeysForId.kSilverSubscriptionId]
          as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper? transaction,
      SKStorefrontWrapper? storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
