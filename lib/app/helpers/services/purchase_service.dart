import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../constants/purchase_constants.dart';

class PurchaseService extends GetxService implements Bindings {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final products = <ProductDetails>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxString('');

  // Purchase state flags
  final hasUserConfirmedPurchase = false.obs;
  final hasExplicitlyTappedPurchase = false.obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  @override
  void onClose() {
    _subscription.cancel();
    if (Platform.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    super.onClose();
  }

  Future<void> initialize() async {
    isLoading.value = true;

    // Check if IAP is available
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      errorMessage.value = 'In-app purchases not available';
      isLoading.value = false;
      return;
    }

    // Set up iOS delegate if needed
    if (Platform.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
    }

    // Listen to purchase updates
    _subscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => _subscription.cancel(),
      onError: (error) => errorMessage.value = error.toString(),
    );

    // Load products
    await _loadProducts();
    isLoading.value = false;
  }

  Future<void> _loadProducts() async {
    final ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails(productIds.toSet()); // Changed _kProductIds to productIds

    if (response.notFoundIDs.isNotEmpty) {
      errorMessage.value = 'Some products not found: ${response.notFoundIDs}';
    }

    products.value = response.productDetails;

    // Debug print products
    for (var product in products) {
      print('Found product: ${product.id} - ${product.title} - ${product.price}');
    }
  }

  Future<void> purchaseProduct(String productId, {bool isFreeze = false, bool isRestore = false}) async {
    try {
      // Set purchase flags
      hasExplicitlyTappedPurchase.value = true;
      hasUserConfirmedPurchase.value = true;

      // Find the product
      final product = products.firstWhere(
            (p) => p.id == productId,
        orElse: () => throw Exception('Product not found'),
      );

      // Make purchase
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);

      if (Platform.isAndroid) {
        // On Android, we need to use the correct purchase method
        await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
      } else {
        // On iOS
        await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      }

    } catch (e) {
      errorMessage.value = 'Purchase failed: ${e.toString()}';
      hasExplicitlyTappedPurchase.value = false;
      hasUserConfirmedPurchase.value = false;
      rethrow;
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      // Only process purchases if user explicitly initiated them
      if (!hasUserConfirmedPurchase.value || !hasExplicitlyTappedPurchase.value) {
        if (purchase.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchase);
        }
        continue;
      }

      switch (purchase.status) {
        case PurchaseStatus.pending:
        // Handle pending state
          break;

        case PurchaseStatus.purchased:
        // Verify purchase and call backend
          await _verifyPurchase(purchase);
          break;

        case PurchaseStatus.error:
          errorMessage.value = purchase.error?.message ?? 'Purchase error';
          break;

        case PurchaseStatus.restored:
        // Handle restored purchases (for non-consumables)
          break;

        case PurchaseStatus.canceled:
          errorMessage.value = 'Purchase was canceled';
          break;
      }

      // Complete the purchase
      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }

    // Reset purchase flags after processing
    hasUserConfirmedPurchase.value = false;
    hasExplicitlyTappedPurchase.value = false;
  }

  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    try {
      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) {
        throw Exception('User not logged in');
      }

      // Determine purchase type
      bool isFreeze = purchase.productID == singlePurchaseId ||
          purchase.productID == bundlePurchaseId;
      bool isRestore = purchase.productID == singlePurchaseId ||
          purchase.productID == bundlePurchaseId;
      bool isLifetime = purchase.productID == lifetimePurchaseId;

      // Prepare API call based on platform
      final response = await APIProvider().postAPICall(
        isFreeze ? 'streak/buyFreeze' :
        isRestore ? 'streak/buyRestore' :
        'subscription/buy',
        Platform.isAndroid
            ? {
          "device": "android",
          "purchaseToken": purchase.verificationData.serverVerificationData,
          "productId": purchase.productID,
          "free": false,
          if (isFreeze || isRestore) "receiptId": "",
        }
            : {
          "device": "ios",
          "receiptId": purchase.verificationData.localVerificationData,
          "productId": purchase.productID,
          "free": false,
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        // Success - update local state
        if (isLifetime) {
          LocalStorage.setPremiumUser(value: true);
        }

        // Show success message
        Get.snackbar('Success', response.data["message"] ?? 'Purchase successful');
      } else {
        throw Exception(response.data["message"] ?? 'Purchase verification failed');
      }
    } catch (e) {
      errorMessage.value = 'Verification failed: ${e.toString()}';
      rethrow;
    }
  }

  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseService());
  }

}

// iOS Payment Queue Delegate
class PaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
