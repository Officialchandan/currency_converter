// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// import 'consumable_store.dart';
// import 'package:in_app_purchase_android/billing_client_wrappers.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
// import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

// const bool _kAutoConsume = true;

// const String _kUpgradeId = 'currency.app_unlock_color';
// const String _kSilverSubscriptionId = 'currency.app_no_ads';
// List<PurchaseDetails> purchases = [];

// const List<String> _kProductIds = <String>[
//   _kUpgradeId,
//   _kSilverSubscriptionId,
// ];

// class ProviderModel with ChangeNotifier {
//   final InAppPurchase inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> subscription;

//   List<String> _notFoundIds = [];
//   List<ProductDetails> _products = [];
//   List<PurchaseDetails> _purchases = [];
//   List<String> _consumables = [];
//   bool _isAvailable = false;
//   bool _purchasePending = false;
//   bool _loading = true;
//   String? _queryProductError;

//   Future<void> initInApp() async {
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         inAppPurchase.purchaseStream;
//     subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       subscription.cancel();
//     }, onError: (error) {
//       // handle error here.
//     });
//     await initStoreInfo();
//   }

//   verifyPreviousPurchases() async {
//     print("=============================verifyPreviousPurchases");
//     await inAppPurchase.restorePurchases();
//     await Future.delayed(const Duration(milliseconds: 100), () {
//       for (var pur in purchases) {
//         if (pur.productID.contains('currency.app_unlock_color')) {
//           removeAds = true;
//         }
//         if (pur.productID.contains('currency.app_no_ads')) {
//           silverSubscription = true;
//         }
//       }

//       finishedLoad = true;
//     });

//     notifyListeners();
//   }

//   bool _removeAds = false;
//   bool get removeAds => _removeAds;
//   set removeAds(bool value) {
//     _removeAds = value;
//     notifyListeners();
//   }

//   bool _silverSubscription = false;
//   bool get silverSubscription => _silverSubscription;
//   set silverSubscription(bool value) {
//     _silverSubscription = value;
//     notifyListeners();
//   }

//   bool _finishedLoad = false;
//   bool get finishedLoad => _finishedLoad;
//   set finishedLoad(bool value) {
//     _finishedLoad = value;
//     notifyListeners();
//   }

//   Future<void> initStoreInfo() async {
//     final bool isAvailable = await inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       _isAvailable = isAvailable;
//       _products = [];
//       _purchases = [];
//       _notFoundIds = [];
//       _consumables = [];
//       _purchasePending = false;
//       _loading = false;
//       return;
//     }

//     if (Platform.isIOS) {
//       var iosPlatformAddition = inAppPurchase
//           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     }

//     ProductDetailsResponse productDetailResponse =
//         await inAppPurchase.queryProductDetails(_kProductIds.toSet());
//     if (productDetailResponse.error != null) {
//       _queryProductError = productDetailResponse.error!.message;
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _purchases = [];
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       _consumables = [];
//       _purchasePending = false;
//       _loading = false;
//       return;
//     }

//     if (productDetailResponse.productDetails.isEmpty) {
//       _queryProductError = null;
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _purchases = [];
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       _consumables = [];
//       _purchasePending = false;
//       _loading = false;
//       return;
//     }

//     List<String> consumables = await ConsumableStore.load();
//     _isAvailable = isAvailable;
//     _products = productDetailResponse.productDetails;
//     _notFoundIds = productDetailResponse.notFoundIDs;
//     _consumables = consumables;
//     _purchasePending = false;
//     _loading = false;
//     notifyListeners();
//   }

//   Future<void> consume(String id) async {
//     await ConsumableStore.consume(id);
//     final List<String> consumables = await ConsumableStore.load();
//     _consumables = consumables;
//   }

//   void showPendingUI() {
//     _purchasePending = true;
//   }

//   void deliverProduct(PurchaseDetails purchaseDetails) async {
//     // IMPORTANT!! Always verify purchase details before delivering the product.
//     if (purchaseDetails.productID == _kUpgradeId) {
//       await ConsumableStore.save(purchaseDetails.purchaseID!);
//       List<String> consumables = await ConsumableStore.load();
//       _purchasePending = false;
//       _consumables = consumables;
//     } else {
//       _purchases.add(purchaseDetails);
//       _purchasePending = false;
//     }
//   }

//   void handleError(IAPError error) {
//     _purchasePending = false;
//   }

//   Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
//     // IMPORTANT!! Always verify a purchase before delivering the product.
//     // For the purpose of an example, we directly return true.
//     return Future<bool>.value(true);
//   }

//   void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
//     // handle invalid purchase here if  _verifyPurchase` failed.
//   }

//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         showPendingUI();
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//           handleError(purchaseDetails.error!);
//         } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//             purchaseDetails.status == PurchaseStatus.restored) {
//           bool valid = await _verifyPurchase(purchaseDetails);
//           if (valid) {
//             deliverProduct(purchaseDetails);
//           } else {
//             _handleInvalidPurchase(purchaseDetails);
//             return;
//           }
//         }
//         if (Platform.isAndroid) {
//           if (!_kAutoConsume && purchaseDetails.productID == _kUpgradeId) {
//             final InAppPurchaseAndroidPlatformAddition androidAddition =
//                 inAppPurchase.getPlatformAddition<
//                     InAppPurchaseAndroidPlatformAddition>();
//             await androidAddition.consumePurchase(purchaseDetails);
//           }
//         }
//         if (purchaseDetails.pendingCompletePurchase) {
//           await inAppPurchase.completePurchase(purchaseDetails);
//         }
//       }
//     });
//   }

//   Future<void> confirmPriceChange(BuildContext context) async {
//     if (Platform.isAndroid) {
//       final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase
//           .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//       var priceChangeConfirmationResult =
//           await androidAddition.launchPriceChangeConfirmationFlow(
//         sku: 'purchaseId',
//       );
//       if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Price change accepted'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             priceChangeConfirmationResult.debugMessage ??
//                 "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
//           ),
//         ));
//       }
//     }
//     if (Platform.isIOS) {
//       var iapStoreKitPlatformAddition = inAppPurchase
//           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
//     }
//   }

//   GooglePlayPurchaseDetails? _getOldSubscription(
//       ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
//     // This is just to demonstrate a subscription upgrade or downgrade.
//     // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
//     // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
//     // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
//     // Please remember to replace the logic of finding the old subscription Id as per your app.
//     // The old subscription is only required on Android since Apple handles this internally
//     // by using the subscription group feature in iTunesConnect.
//     GooglePlayPurchaseDetails? oldSubscription;
//     if (productDetails.id == _kSilverSubscriptionId &&
//         purchases[_kSilverSubscriptionId] != null) {
//       oldSubscription =
//           purchases[_kSilverSubscriptionId] as GooglePlayPurchaseDetails;
//     } else if (productDetails.id == _kSilverSubscriptionId &&
//         purchases[_kSilverSubscriptionId] != null) {
//       oldSubscription =
//           purchases[_kSilverSubscriptionId] as GooglePlayPurchaseDetails;
//     }
//     return oldSubscription;
//   }
// }

// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//       SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }

//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }
