// subscription_tier_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

// Adjust these imports for your file paths:
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/ff_logging_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/purchase_service_provider.dart';
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

import '../models/unique_test_model.dart';

class SubscriptionTierScreen extends ConsumerStatefulWidget {
  final ValueChanged<SubscriptionTier> onNext;
  final VoidCallback onSkip; // In case you want a skip button somewhere else

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
  /// Default to "premium" so that the "free premium" card is initially highlighted.
  SubscriptionTier _selectedTier = SubscriptionTier.premium;

  bool _isProcessing = false;
  bool _isLoadingPrices = true;

  /// Example: { 'plus_yearly_1': '$9.99' }
  Map<String, String> _storePrices = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadStorePrices());
  }

  Future<void> _loadStorePrices() async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    loggingService.logWarning('[SubscriptionTierScreen] _loadStorePrices -> start');

    try {
      final purchaseService = ref.read(purchaseServiceProvider);

      // Wait for PurchaseService to finish initializing if needed
      if (!purchaseService.isInitialized) {
        loggingService.logWarning('[SubscriptionTierScreen] waiting for init...');
        final success = await purchaseService.initializationComplete;
        if (!success) {
          throw Exception("PurchaseService failed to initialize");
        }
      }

      // Load available products from store
      final products = purchaseService.availableProducts;
      loggingService.logWarning(
        '[SubscriptionTierScreen] found ${products.length} products in store',
      );

      final Map<String, String> tempMap = {};
      for (final p in products) {
        loggingService.logWarning(
          '   - product.id = ${p.id}, price = ${p.price}',
        );
        tempMap[p.id] = p.price;
      }

      setState(() {
        _storePrices = tempMap;
        _isLoadingPrices = false;
      });
      loggingService.logWarning('[SubscriptionTierScreen] success -> $_storePrices');
    } catch (e, st) {
      ref
          .read(ffLoggingServiceProvider)
          .logError('[SubscriptionTierScreen] error loading store prices: $e\n$st');
      setState(() {
        _isLoadingPrices = false;
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Failed to load store prices.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final loggingService = ref.read(ffLoggingServiceProvider);

    loggingService.logWarning('[SubscriptionTierScreen] build -> viewed');
    analytics.logEvent('subscription_tier_screen_viewed');

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

                  // Auto-renew disclaimer
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        loc.subscriptionAutoRenewNotice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Card #1: FREE Premium
                  _buildFreePremiumCard(context, loc, loggingService),
                  const SizedBox(height: 12),

                  // Card #2: Paid Support (premiumPlus)
                  _buildSupportCard(context, loc, loggingService),

                  const SizedBox(height: 24),

                  // "Subscribe"/Confirm button
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

                  // Restore Purchases
                  _buildRestorePurchasesButton(loc, loggingService),
                  const SizedBox(height: 20),

                  // Privacy & EULA
                  _buildLegalLinksSection(),
                  const SizedBox(height: 30),

                  // Final message
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

            // Loading overlay if processing
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
  // Card #1: Free Premium
  // --------------------------------------------------------------------------
  Widget _buildFreePremiumCard(
      BuildContext context,
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    final isSelected = _selectedTier == SubscriptionTier.premium;
    return GestureDetector(
      onTap: () {
        loggingService.logWarning('[SubscriptionTierScreen] selected FREE Premium');
        setState(() => _selectedTier = SubscriptionTier.premium);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(isSelected),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If you previously had a localizations key for the free tier label,
            // you can use something like: loc.subscriptionTierScreenFreeLabel
            // For now, we assume "Free" is hard-coded, as we only have freeDescription in your snippet
            _cardHeader(
              title: 'Free',
              price: 'Free',
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),

            // This references your JSON: "subscriptionTierScreenFreeDescription"
            ..._buildBulletPoints([
              loc.subscriptionTierScreenFreeDescription,
            ]),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Card #2: Paid Support => premiumPlus
  // --------------------------------------------------------------------------
  Widget _buildSupportCard(
      BuildContext context,
      AppLocalizations loc,
      LoggingService loggingService,
      ) {
    final isSelected = _selectedTier == SubscriptionTier.premiumPlus;
    const productId = 'plus_yearly_1'; // your premium product
    final priceText = _storePrices[productId] ?? '...';

    return GestureDetector(
      onTap: () {
        loggingService.logWarning('[SubscriptionTierScreen] selected SUPPORT (paid)');
        setState(() => _selectedTier = SubscriptionTier.premiumPlus);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(isSelected),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This references "subscriptionTierScreenSupportLabel" => e.g. "Support Yearly"
            _cardHeader(
              title: loc.subscriptionTierScreenSupportLabel,
              price: priceText,
              isSelected: isSelected,
            ),
            const SizedBox(height: 6),

            // The bullet text references "subscriptionTierScreenPremiumPlusDescription"
            ..._buildBulletPoints([
              loc.subscriptionTierScreenPremiumPlusDescription,
            ]),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Card appearance helpers
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

  List<Widget> _buildBulletPoints(List<String> lines) {
    return lines.expand((l) {
      final splitted = l.split('\n');
      return splitted.map(
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
  // Restore Purchases
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
          loggingService
              .logWarning('[SubscriptionTierScreen] restorePurchases -> start');
          final messenger = ScaffoldMessenger.of(context);

          setState(() => _isProcessing = true);
          try {
            final purchaseService = ref.read(purchaseServiceProvider);
            await purchaseService.restorePurchases();

            loggingService.logWarning('[SubscriptionTierScreen] restore success');
            messenger.showSnackBar(
              SnackBar(
                content: Text(loc.subscriptionPurchaseRestoreSuccess),
              ),
            );
          } catch (e, st) {
            loggingService.logError(
              '[SubscriptionTierScreen] restore error: $e\n$st',
            );
            messenger.showSnackBar(
              SnackBar(
                content: Text('${loc.subscriptionPurchaseError}: $e'),
              ),
            );
          } finally {
            loggingService.logWarning('[SubscriptionTierScreen] restore done');
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
  // Privacy & EULA
  // --------------------------------------------------------------------------
  Widget _buildLegalLinksSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () =>
                _launchUrl('https://www.hudhudemergence.com/privacy-policy'),
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
  // Confirm Selection
  // --------------------------------------------------------------------------
  Future<void> _onConfirmSelection() async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final loggingService = ref.read(ffLoggingServiceProvider);
    final messenger = ScaffoldMessenger.of(context);

    loggingService.logWarning('[SubscriptionTierScreen] user selected $_selectedTier');

    // If user selected "premium" => skip purchase
    if (_selectedTier == SubscriptionTier.premium) {
      loggingService.logWarning('[SubscriptionTierScreen] user gets premium for FREE');
      analytics.logEvent('subscription_free_premium_selected');
      widget.onNext(_selectedTier);
      return;
    }

    // If user selected "premiumPlus" => attempt a purchase
    if (_selectedTier == SubscriptionTier.premiumPlus) {
      setState(() => _isProcessing = true);

      try {
        const productId = 'plus_yearly_1';
        loggingService.logWarning(
          '[SubscriptionTierScreen] Attempting to buy $productId',
        );

        analytics.logEvent('subscription_purchase_attempt', parameters: {
          'tier': _selectedTier.name,
          'product_id': productId,
        });

        final purchaseService = ref.read(purchaseServiceProvider);
        final products = purchaseService.availableProducts;

        // Make sure we find our correct product
        final matchedProduct = products.firstWhere(
              (p) => p.id == productId,
          orElse: () => throw Exception('Product not found: $productId'),
        );

        // Fire up the store flow
        await purchaseService.buyProduct(matchedProduct);

        loggingService.logWarning('[SubscriptionTierScreen] purchase flow done');
        widget.onNext(_selectedTier);
      } catch (e, st) {
        loggingService.logError('[SubscriptionTierScreen] purchase error: $e\n$st');
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
        setState(() => _isProcessing = false);
      }
    }
  }

  // --------------------------------------------------------------------------
  // Launch external URL
  // --------------------------------------------------------------------------
  Future<void> _launchUrl(String url) async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    final messenger = ScaffoldMessenger.of(context);
    loggingService.logWarning('[SubscriptionTierScreen] _launchUrl -> $url');

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final launched =
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Could not launch URL.')),
        );
      }
    } else {
      loggingService.logWarning('[SubscriptionTierScreen] could NOT launch $url');
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not launch URL.')),
      );
    }
  }
}
