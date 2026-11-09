// lib/services/purchase_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform; // For checking Android vs iOS
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';

import '../providers/ff_logging_service_provider.dart';
import '../z_onboarding/models/unique_test_model.dart';
import '../z_onboarding/providers/user_profile_provider.dart';

/// A service that manages in-app purchases (Apple/Google).
/// - iOS receipts are validated server-side (your Node backend).
/// - Android purchases skip server validation, relying on local checks (though you could add them).
class PurchaseService {
  // --------------------------------------------------------------------------
  // Dependencies
  // --------------------------------------------------------------------------
  final LoggingService loggingService;
  final Ref ref; // For reading userProfileProvider, logs, etc.

  // --------------------------------------------------------------------------
  // InAppPurchase plugin & subscriptions
  // --------------------------------------------------------------------------
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // We'll store products once they're fetched
  List<ProductDetails> _availableProducts = [];

  // --------------------------------------------------------------------------
  // Apple-only Node endpoint (Android is bypassed)
  // --------------------------------------------------------------------------
  static const String _backendValidateUrl =
      'https://app.hudhudquran.com/iap/validate';

  // --------------------------------------------------------------------------
  // Initialization tracking
  // --------------------------------------------------------------------------
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  final Completer<bool> _initCompleter = Completer<bool>();
  Future<bool> get initializationComplete => _initCompleter.future;

  // --------------------------------------------------------------------------
  // Error handling or debugging
  // --------------------------------------------------------------------------
  String _lastError = '';
  String get lastError => _lastError;

  // --------------------------------------------------------------------------
  // The set of known product IDs
  // --------------------------------------------------------------------------
  static const Set<String> productIds = {
    'plus_monthly_1',
    'plus_yearly_1',
    'pro_monthly_1',
    'pro_yearly_1',
  };

  // --------------------------------------------------------------------------
  // Constructor
  // --------------------------------------------------------------------------
  PurchaseService({
    required this.loggingService,
    required this.ref,
  });

  // --------------------------------------------------------------------------
  // Initialize IAP: check availability, purchase stream, query products
  // --------------------------------------------------------------------------
  Future<bool> init() async {
    // If already done, short-circuit
    if (_isInitialized) {
      return true;
    }

    loggingService.logWarning('[PurchaseService] init() called');

    try {
      final isAvailable = await _iap.isAvailable();
      debugPrint('PurchaseService: Store available => $isAvailable');
      loggingService.logWarning(
        '[PurchaseService] Store available => $isAvailable',
      );

      if (!isAvailable) {
        _lastError = 'Store not available';
        loggingService.logWarning(
          '[PurchaseService] Store NOT available, returning early',
        );
        _initCompleter.complete(false);
        return false;
      }

      // Subscribe to purchase updates
      _subscription = _iap.purchaseStream.listen(
        _handlePurchaseUpdates,
        onDone: () => _subscription?.cancel(),
        onError: (error) {
          _lastError = 'Purchase stream error: $error';
          debugPrint('PurchaseService: purchaseStream error => $error');
          loggingService.logError(
            '[PurchaseService] purchaseStream error => $error',
          );
        },
      );

      // Fetch product details
      final response = await _iap.queryProductDetails(productIds);
      _availableProducts = response.productDetails.toList();

      debugPrint(
        'PurchaseService: found ${_availableProducts.length} products in store',
      );
      loggingService.logWarning(
        '[PurchaseService] found ${_availableProducts.length} products in store',
      );

      // Check if any product IDs were not found
      if (response.notFoundIDs.isNotEmpty) {
        final missingIds = response.notFoundIDs.join(', ');
        _lastError = 'Products not found: $missingIds';
        loggingService.logError(
          '[PurchaseService] Products not found: $missingIds',
        );
      }

      // Optional: log the found products for debug
      for (final product in _availableProducts) {
        loggingService.logWarning(
          '[PurchaseService] Product found: ${product.id}, price: ${product.price}',
        );
      }

      _isInitialized = true;
      _initCompleter.complete(true);
      return true;
    } catch (e, stackTrace) {
      _lastError = 'Error initializing: $e';
      loggingService.logError(
        '[PurchaseService] Error in init: $e\n$stackTrace',
      );
      _initCompleter.complete(false);
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // Handle purchase updates from the plugin
  // --------------------------------------------------------------------------
  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    loggingService.logWarning(
      '[PurchaseService] _handlePurchaseUpdates -> # of purchases: '
          '${purchaseDetailsList.length}',
    );

    for (final purchaseDetails in purchaseDetailsList) {
      loggingService.logWarning(
        '[PurchaseService] Handling purchase: '
            '${purchaseDetails.productID}, status=${purchaseDetails.status}',
      );

      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        _verifyPurchaseAndUpdateState(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        _lastError = 'Purchase error: ${purchaseDetails.error}';
        debugPrint('PurchaseService: ERROR => ${purchaseDetails.error}');
        loggingService.logError(
          '[PurchaseService] ERROR => ${purchaseDetails.error}',
        );
      }

      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
        loggingService.logWarning(
          '[PurchaseService] completePurchase called for '
              '${purchaseDetails.productID}',
        );
      }
    }
  }

  // --------------------------------------------------------------------------
  // Verify iOS purchases with your Node backend; skip for Android
  // --------------------------------------------------------------------------
  Future<void> _verifyPurchaseAndUpdateState(PurchaseDetails purchase) async {
    final productId = purchase.productID;
    debugPrint('PurchaseService: verifying product => $productId');
    loggingService.logWarning(
      '[PurchaseService] verifying product => $productId',
    );

    // If Android, skip server validation
    if (Platform.isAndroid) {
      loggingService.logWarning(
        '[PurchaseService] Android purchase detected, skipping server validation',
      );
      _markLocalSubscriptionTier(productId);
      return;
    }

    // If iOS => proceed with server validation
    final rawReceipt = purchase.verificationData.serverVerificationData;
    loggingService.logWarning(
      '[PurchaseService] rawReceipt length => ${rawReceipt.length}',
    );

    try {
      final isValid = await _callServerValidateEndpoint(rawReceipt);
      if (!isValid) {
        _lastError = 'Server says receipt invalid';
        debugPrint('PurchaseService: server says receipt is invalid. Aborting.');
        loggingService.logWarning(
          '[PurchaseService] server says receipt is invalid => ABORT',
        );
        return;
      }
    } catch (e) {
      _lastError = 'Server validation error: $e';
      debugPrint('PurchaseService: Exception calling server => $e');
      loggingService.logError(
        '[PurchaseService] Exception calling server => $e',
      );
      return;
    }

    // If valid, update local subscription tier
    _markLocalSubscriptionTier(productId);
  }

  // --------------------------------------------------------------------------
  // Update subscription tier in local userProfile
  // --------------------------------------------------------------------------
  void _markLocalSubscriptionTier(String productId) async {
    final userProfileNotifier = ref.read(userProfileProvider.notifier);

    if (productId == 'plus_monthly_1' || productId == 'plus_yearly_1') {
      await userProfileNotifier.updateSubscriptionTier(SubscriptionTier.premium);
      debugPrint('PurchaseService: set subscriptionTier => premium');
      loggingService.logWarning(
        '[PurchaseService] set subscriptionTier => premium',
      );
    } else if (productId == 'pro_monthly_1' || productId == 'pro_yearly_1') {
      await userProfileNotifier.updateSubscriptionTier(SubscriptionTier.premiumPlus);
      debugPrint('PurchaseService: set subscriptionTier => premiumPlus');
      loggingService.logWarning(
        '[PurchaseService] set subscriptionTier => premiumPlus',
      );
    }
  }

  // --------------------------------------------------------------------------
  // Call Node backend for iOS receipt validation
  // --------------------------------------------------------------------------
  Future<bool> _callServerValidateEndpoint(String base64Receipt) async {
    loggingService.logWarning(
      '[PurchaseService] _callServerValidateEndpoint => hitting $_backendValidateUrl',
    );

    try {
      final response = await http.post(
        Uri.parse(_backendValidateUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          // iOS expects a base64 receipt in "receiptData"
          'receiptData': base64Receipt,
        }),
      );

      loggingService.logWarning(
        '[PurchaseService] validate response code => ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResp = jsonDecode(response.body);
        final success = jsonResp['success'] as bool? ?? false;
        debugPrint('PurchaseService: Server validate => success=$success');
        loggingService.logWarning(
          '[PurchaseService] Server validate => success=$success',
        );
        return success;
      } else {
        _lastError = 'Server returned error: ${response.statusCode}';
        debugPrint('PurchaseService: server error => ${response.statusCode}');
        loggingService.logError(
          '[PurchaseService] server returned error => ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      _lastError = 'Network/Server exception: $e';
      debugPrint('PurchaseService: Exception calling server => $e');
      loggingService.logError(
        '[PurchaseService] Exception calling server => $e',
      );
      rethrow; // or "return false" if you prefer
    }
  }

  // --------------------------------------------------------------------------
  // Expose the list of products. Returns empty if not yet initialized.
  // --------------------------------------------------------------------------
  List<ProductDetails> get availableProducts {
    if (!_isInitialized) {
      loggingService.logWarning(
        '[PurchaseService] Trying to access products before init completed.',
      );
      return [];
    }
    return _availableProducts;
  }

  // --------------------------------------------------------------------------
  // Initiate a purchase for a specific product
  // --------------------------------------------------------------------------
  Future<void> buyProduct(ProductDetails product) async {
    loggingService.logWarning(
      '[PurchaseService] buyProduct => ${product.id}, price=${product.price}',
    );

    final purchaseParam = PurchaseParam(productDetails: product);
    try {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      loggingService.logWarning(
        '[PurchaseService] buyNonConsumable initiated for ${product.id}',
      );
    } catch (e, st) {
      _lastError = 'buyProduct error: $e';
      loggingService.logError(
        '[PurchaseService] buyProduct error: $e\n$st',
      );
      rethrow;
    }
  }

  // --------------------------------------------------------------------------
  // Restore purchases (iOS) or query past purchases (Android)
  // --------------------------------------------------------------------------
  Future<void> restorePurchases() async {
    loggingService.logWarning('[PurchaseService] restorePurchases called');
    try {
      await _iap.restorePurchases();
      loggingService.logWarning('[PurchaseService] restorePurchases completed');
    } catch (e, st) {
      _lastError = 'restorePurchases error: $e';
      loggingService.logError(
        '[PurchaseService] restorePurchases error: $e\n$st',
      );
      rethrow;
    }
  }

  // --------------------------------------------------------------------------
  // Optionally refresh product details after initial init
  // --------------------------------------------------------------------------
  Future<void> refreshProducts() async {
    loggingService.logWarning('[PurchaseService] refreshProducts -> start');
    if (!_isInitialized) {
      loggingService.logWarning(
        '[PurchaseService] Cannot refresh products: not initialized yet.',
      );
      return;
    }
    try {
      final response = await _iap.queryProductDetails(productIds);
      _availableProducts = response.productDetails.toList();
      loggingService.logWarning(
        '[PurchaseService] refreshProducts -> found ${_availableProducts.length} products',
      );
      if (response.notFoundIDs.isNotEmpty) {
        final missing = response.notFoundIDs.join(', ');
        _lastError = 'refreshProducts: Missing product IDs: $missing';
        loggingService.logError(
          '[PurchaseService] refreshProducts missing IDs: $missing',
        );
      }
    } catch (e, st) {
      _lastError = 'Error refreshing products: $e';
      loggingService.logError(
        '[PurchaseService] refreshProducts -> error: $e\n$st',
      );
      rethrow;
    }
  }

  // --------------------------------------------------------------------------
  // Dispose the purchase stream subscription
  // --------------------------------------------------------------------------
  void dispose() {
    loggingService.logWarning('[PurchaseService] dispose() called');
    _subscription?.cancel();
  }
}
