import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Your generated localization
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// In-app purchase + your custom PurchaseService
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:hudhud_quran_app_new/providers/purchase_service_provider.dart';
// ^ We import the provider, not purchase_service.dart directly

// For privacy/eula links
import 'package:url_launcher/url_launcher.dart';

// Logging provider
import 'package:hudhud_quran_app_new/providers/ff_logging_service_provider.dart';

import '../models/unique_test_model.dart';

class SubscriptionTierScreen extends ConsumerStatefulWidget {
  final ValueChanged<SubscriptionTier> onNext;
  final VoidCallback onSkip; // Not displayed, but kept for coordinator flow

  const SubscriptionTierScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  ConsumerState<SubscriptionTierScreen> createState() =>
      _SubscriptionTierScreenState();
}

class _SubscriptionTierScreenState extends ConsumerState<SubscriptionTierScreen> {
  // --------------------------------------------------------------------------
  // State variables
  // --------------------------------------------------------------------------
  SubscriptionTier _selectedTier = SubscriptionTier.free;
  bool _isProcessing = false;   // For blocking UI & showing spinner during purchase
  bool _isYearly = false;       // Monthly vs. yearly toggle
  bool _isLoadingPrices = true; // Whether we're fetching product details

  /// Product prices from the store, keyed by productId, e.g. { 'plus_monthly_1': '$3.99' }
  Map<String, String> _storePrices = {};

  // --------------------------------------------------------------------------
  // Lifecycle
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // Load product prices after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStorePrices();
    });
  }

  /// Wait for PurchaseService to finish initialization, then build a map
  /// of productId -> localized price
  Future<void> _loadStorePrices() async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    loggingService.logWarning('[SubscriptionTierScreen] _loadStorePrices -> start');

    try {
      final purchaseService = ref.read(purchaseServiceProvider);

      // 1) Check if PurchaseService is initialized yet
      if (!purchaseService.isInitialized) {
        loggingService.logWarning(
          '[SubscriptionTierScreen] Waiting for purchase service initialization...',
        );
        final success = await purchaseService.initializationComplete;
        if (!success) {
          throw Exception("PurchaseService failed to initialize");
        }
      }

      // 2) Now we know it's initialized, we can safely read the products
      final products = purchaseService.availableProducts;
      loggingService.logWarning(
        '[SubscriptionTierScreen] _loadStorePrices -> found ${products.length} products in store',
      );

      // 3) Build a map productId -> price
      final Map<String, String> tempMap = {};
      for (final product in products) {
        loggingService.logWarning(
          '   - product.id = ${product.id}, price = ${product.price}',
        );
        tempMap[product.id] = product.price;
      }

      // 4) Update state to show those prices
      setState(() {
        _storePrices = tempMap;
        _isLoadingPrices = false;
      });
      loggingService.logWarning(
        '[SubscriptionTierScreen] _loadStorePrices -> success, map: $_storePrices',
      );
    } catch (e, st) {
      loggingService.logError(
        '[SubscriptionTierScreen] _loadStorePrices -> ERROR: $e\n$st',
      );
      setState(() {
        _isLoadingPrices = false;
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Failed to load store prices.')),
      );
    }
  }

  // --------------------------------------------------------------------------
  // Build UI
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final loggingService = ref.read(ffLoggingServiceProvider);

    loggingService.logWarning(
      '[SubscriptionTierScreen] build -> subscription_tier_screen_viewed event',
    );
    analytics.logEvent('subscription_tier_screen_viewed');

    // If still loading product details, show a spinner
    if (_isLoadingPrices) {
      return Scaffold(
        appBar: AppBar(
          title: Text(loc.subscriptionTierScreenAppBarTitle),
          backgroundColor: Colors.blue[50],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Semantics(
      label: loc.subscriptionTierScreenSemantic,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text(loc.subscriptionTierScreenAppBarTitle),
          backgroundColor: Colors.blue[50],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),

                  // Toggle row "Monthly / Yearly"
                  _buildBillingToggle(loc, loggingService),
                  const SizedBox(height: 12),

                  // Auto-renew disclaimer
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        loc.subscriptionAutoRenewNotice,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tiers:
                  _buildFreeCard(context, loc, loggingService),
                  const SizedBox(height: 12),
                  _buildPremiumCard(context, loc, loggingService),
                  const SizedBox(height: 12),
                  _buildPremiumPlusCard(context, loc, loggingService),

                  const SizedBox(height: 24),

                  // "Subscribe" button
                  Center(
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _onConfirmSelection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Text(
                          loc.subscriptionTierScreenSubscribeLabel,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // "Restore Purchases"
                  _buildRestorePurchasesButton(loc, loggingService),
                  const SizedBox(height: 20),

                  // Privacy & EULA links
                  _buildLegalLinksSection(),
                  const SizedBox(height: 30),

                  // A friendly final message or emoji
                  Center(
                    child: Column(
                      children: [
                        const Text('😀', style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 8),
                        Text(
                          loc.subscriptionTierScreenFinalMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            // Optional loading overlay if a purchase is in progress
            if (_isProcessing)
              Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Restore Purchases Button
  // --------------------------------------------------------------------------
  Widget _buildRestorePurchasesButton(
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    return Center(
      child: TextButton(
        onPressed: _isProcessing
            ? null
            : () async {
          loggingService.logWarning(
            '[SubscriptionTierScreen] restorePurchases -> start',
          );
          final messenger = ScaffoldMessenger.of(context);

          setState(() => _isProcessing = true);
          try {
            final purchaseService = ref.read(purchaseServiceProvider);
            await purchaseService.restorePurchases();

            loggingService.logWarning(
              '[SubscriptionTierScreen] restorePurchases -> success',
            );
            messenger.showSnackBar(
              SnackBar(
                content: Text(
                  loc.subscriptionPurchaseRestoreSuccess,
                ),
              ),
            );
          } catch (e, st) {
            loggingService.logError(
              '[SubscriptionTierScreen] restorePurchases -> error: $e\n$st',
            );
            messenger.showSnackBar(
              SnackBar(
                content: Text('${loc.subscriptionPurchaseError}: $e'),
              ),
            );
          } finally {
            loggingService.logWarning(
              '[SubscriptionTierScreen] restorePurchases -> done',
            );
            setState(() => _isProcessing = false);
          }
        },
        child: Text(
          loc.subscriptionTierScreenRestoreLabel,
          style: TextStyle(color: Colors.blue[800], fontSize: 16),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Billing Toggle: monthly vs. yearly
  // --------------------------------------------------------------------------
  Widget _buildBillingToggle(
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            loc.subscriptionTierScreenMonthly,
            style: TextStyle(
              color: _isYearly ? Colors.grey : Colors.blue[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          Switch(
            value: _isYearly,
            activeColor: Colors.blue[800],
            onChanged: (val) {
              loggingService.logWarning(
                '[SubscriptionTierScreen] _buildBillingToggle -> user toggled to $val',
              );
              setState(() {
                _isYearly = val;
              });
            },
          ),
          Text(
            loc.subscriptionTierScreenYearly,
            style: TextStyle(
              color: _isYearly ? Colors.blue[800] : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Free tier card
  // --------------------------------------------------------------------------
  Widget _buildFreeCard(
      BuildContext context,
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    final isSelected = _selectedTier == SubscriptionTier.free;
    return GestureDetector(
      onTap: () {
        loggingService.logWarning(
          '[SubscriptionTierScreen] _buildFreeCard -> user selected FREE',
        );
        setState(() => _selectedTier = SubscriptionTier.free);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(isSelected),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardHeader(
              title: loc.subscriptionTierScreenFreeLabel,
              price: 'Free',
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),
            ..._buildBulletPoints([loc.subscriptionTierScreenFreeDescription]),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Premium tier card
  // --------------------------------------------------------------------------
  Widget _buildPremiumCard(
      BuildContext context,
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    final isSelected = _selectedTier == SubscriptionTier.premium;
    // Decide product ID based on monthly/yearly
    final productId = _isYearly ? 'plus_yearly_1' : 'plus_monthly_1';
    // If no price is found in the store, show "..."
    final priceText = _storePrices[productId] ?? '...';

    return GestureDetector(
      onTap: () {
        loggingService.logWarning(
          '[SubscriptionTierScreen] _buildPremiumCard -> user selected Premium',
        );
        setState(() => _selectedTier = SubscriptionTier.premium);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(isSelected),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardHeader(
              title: loc.subscriptionTierScreenPremiumLabel,
              price: priceText,
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),
            ..._buildBulletPoints(
              [loc.subscriptionTierScreenPremiumDescription],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PremiumPlus tier card
  // --------------------------------------------------------------------------
  Widget _buildPremiumPlusCard(
      BuildContext context,
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    final isSelected = _selectedTier == SubscriptionTier.premiumPlus;
    final productId = _isYearly ? 'pro_yearly_1' : 'pro_monthly_1';
    final priceText = _storePrices[productId] ?? '...';

    return GestureDetector(
      onTap: () {
        loggingService.logWarning(
          '[SubscriptionTierScreen] _buildPremiumPlusCard -> user selected PremiumPlus',
        );
        setState(() => _selectedTier = SubscriptionTier.premiumPlus);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(isSelected),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardHeader(
              title: loc.subscriptionTierScreenPremiumPlusLabel,
              price: priceText,
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),
            ..._buildBulletPoints(
              [loc.subscriptionTierScreenPremiumPlusDescription],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Helper: Card header (tier name + price)
  // --------------------------------------------------------------------------
  Widget _cardHeader({
    required String title,
    required String price,
    required bool isSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue[800] : Colors.black87,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.blue[800] : Colors.black87,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Helper: bullet-point builder
  // --------------------------------------------------------------------------
  List<Widget> _buildBulletPoints(List<String> bulletPoints) {
    return bulletPoints.expand((point) {
      final lines = point.split('\n');
      return lines.map(
            (line) => Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  line.trim(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  // --------------------------------------------------------------------------
  // Helper: card decoration
  // --------------------------------------------------------------------------
  BoxDecoration _cardDecoration(bool isSelected) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? Colors.blue[800]! : Colors.transparent,
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Build Privacy & EULA links
  // --------------------------------------------------------------------------
  Widget _buildLegalLinksSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () => _launchUrl('https://www.hudhudemergence.com/privacy-policy'),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.blue[800],
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _launchUrl('https://www.hudhudemergence.com/eula'),
            child: Text(
              'Terms of Use (EULA)',
              style: TextStyle(
                color: Colors.blue[800],
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Confirm Selection (initiate purchase)
  // --------------------------------------------------------------------------
  Future<void> _onConfirmSelection() async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final loggingService = ref.read(ffLoggingServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    loggingService.logWarning(
      '[SubscriptionTierScreen] _onConfirmSelection -> user selected $_selectedTier',
    );

    if (_selectedTier == SubscriptionTier.free) {
      loggingService.logWarning(
        '[SubscriptionTierScreen] _onConfirmSelection -> FREE tier => onNext immediately',
      );
      widget.onNext(_selectedTier);
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // Decide the correct productId
      late String productId;
      if (_selectedTier == SubscriptionTier.premium) {
        productId = _isYearly ? 'plus_yearly_1' : 'plus_monthly_1';
      } else {
        productId = _isYearly ? 'pro_yearly_1' : 'pro_monthly_1';
      }

      loggingService.logWarning(
        '[SubscriptionTierScreen] Attempting to buy productId=$productId',
      );

      analytics.logEvent('subscription_purchase_attempt', parameters: {
        'tier': _selectedTier.name,
        'product_id': productId,
      });

      // Buy the product
      final purchaseService = ref.read(purchaseServiceProvider);
      final products = purchaseService.availableProducts;

      final matchedProduct = products.firstWhere(
            (p) => p.id == productId,
        orElse: () => throw Exception('Product not found in store: $productId'),
      );

      await purchaseService.buyProduct(matchedProduct);

      loggingService.logWarning(
        '[SubscriptionTierScreen] _onConfirmSelection -> purchase flow initiated',
      );

      // If successful, userProfileProvider will be updated in purchaseService's listener
      widget.onNext(_selectedTier);
    } catch (e, st) {
      loggingService.logError(
        '[SubscriptionTierScreen] _onConfirmSelection -> error: $e\n$st',
      );

      analytics.logEvent('subscription_purchase_error', parameters: {
        'tier': _selectedTier.name,
        'error': e.toString(),
      });

      messenger.showSnackBar(
        SnackBar(
          content: Text('${loc.subscriptionPurchaseError}: $e'),
        ),
      );
    } finally {
      loggingService.logWarning(
        '[SubscriptionTierScreen] _onConfirmSelection -> end purchase flow',
      );
      setState(() => _isProcessing = false);
    }
  }

  // --------------------------------------------------------------------------
  // Launch external URL (privacy, EULA)
  // --------------------------------------------------------------------------
  Future<void> _launchUrl(String url) async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.logWarning('[SubscriptionTierScreen] _launchUrl -> $url');

    final messenger = ScaffoldMessenger.of(context);
    final uri = Uri.parse(url);

    final canOpen = await canLaunchUrl(uri);
    if (canOpen) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      loggingService.logWarning(
        '[SubscriptionTierScreen] _launchUrl -> could NOT launch $url',
      );
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not launch URL.')),
      );
    }
  }
}
