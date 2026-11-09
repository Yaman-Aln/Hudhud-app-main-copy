// lib/screens/gratitude_log_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Logging & Analytics
import '../providers/ff_logging_service_provider.dart';
import '../providers/analytics_service_provider.dart';

// Providers & Models
import '../providers/gratitude_provider.dart';
import '../models/gratitude_entry_model.dart';

// Widgets
import '../widgets/gratitude_modal.dart';
import '../widgets/bottom_nav_bar.dart';

// NEW: Generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

class GratitudeLogScreen extends ConsumerWidget {
  const GratitudeLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!; // localizations
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // Log "gratitude_log_screen_viewed"
    analytics.logEvent('gratitude_log_screen_viewed', parameters: {
      'from_screen': 'unknown',
      'to_screen': 'gratitude_log',
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final gratitudeEntries = ref.watch(gratitudeEntriesProvider);
    final gratitudeDataAsync = ref.watch(gratitudeDataProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        elevation: 0,
        title: Text(
          loc.gratitudeLogTitle, // e.g. "My Gratitude Log"
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
            color: Colors.black,
          ),
        ),
        leading: Semantics(
          label: loc.gratitudeLogBackArrowSemantic, // e.g. "Go back to home"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Log "gratitude_log_back_pressed"
              analytics.logEvent('gratitude_log_back_pressed', parameters: {
                'from_screen': 'gratitude_log',
                'to_screen': 'root',
                'cta_source': 'app_bar_arrow',
              });
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
        actions: [
          // Clear all button
          Semantics(
            label: loc.gratitudeLogClearAllSemantic, // e.g. "Clear all gratitude entries"
            button: true,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () async {
                // Log "gratitude_log_clear_pressed"
                analytics.logEvent('gratitude_log_clear_pressed', parameters: {
                  'from_screen': 'gratitude_log',
                  'cta_source': 'delete_button',
                });

                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogCtx) => AlertDialog(
                    title: Text(loc.gratitudeLogClearDialogTitle),
                    content: Text(loc.gratitudeLogClearDialogBody),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogCtx, true),
                        child: Text(loc.gratitudeLogClearConfirm),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(dialogCtx, false),
                        child: Text(loc.cancelLabel),
                      ),
                    ],
                  ),
                );

                if (confirm ?? false) {
                  await ref.read(gratitudeEntriesProvider.notifier).clearEntries();

                  // Log "gratitude_log_cleared"
                  analytics.logEvent('gratitude_log_cleared', parameters: {
                    'from_screen': 'gratitude_log',
                    'cta_source': 'delete_button',
                  });
                }
              },
            ),
          ),
          // Add new entry button
          Semantics(
            label: loc.gratitudeLogAddSemantic, // e.g. "Add new gratitude entry"
            button: true,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () async {
                // Log "gratitude_log_add_pressed"
                analytics.logEvent('gratitude_log_add_pressed', parameters: {
                  'from_screen': 'gratitude_log',
                  'cta_source': 'plus_button',
                });
                await _showGratitudeModalAndSave(context, ref, loggingService);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        ref: ref,
        pathId: null,
      ),
      body: gratitudeEntries.isEmpty
          ? _buildEmptyScreen(context, ref, loggingService)
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the streak
          gratitudeDataAsync.when(
            data: (gratitudeData) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                // e.g. "⭐ Gratitude Streak: 3 days"
                loc.gratitudeLogStreak(
                  gratitudeData.consecutiveGratitudeDays.toString(),
                ),
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            loading: () => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                loc.gratitudeLogStreakLoading, // "Calculating streak..."
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                loc.gratitudeLogStreakError, // "Failed to calculate streak."
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),

          // Display total gratitude days
          gratitudeDataAsync.when(
            data: (gratitudeData) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              child: Text(
                // e.g. "Total Gratitude Days: 10"
                loc.gratitudeLogTotalDays(
                  gratitudeData.totalGratitudeDays.toString(),
                ),
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
            loading: () => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              child: Text(
                loc.gratitudeLogDataLoading, // "Loading gratitude data..."
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              child: Text(
                loc.gratitudeLogDataError, // "Failed to load gratitude data."
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),

          // The main gratitude list
          Expanded(
            child: ListView.builder(
              itemCount: gratitudeEntries.length,
              itemBuilder: (context, index) {
                final entry = gratitudeEntries[index];

                return Semantics(
                  container: true,
                  label: loc.gratitudeLogCardSemantic, // e.g. "Gratitude entry card"
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      childrenPadding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 8.0,
                      ),
                      initiallyExpanded: true,
                      title: Text(
                        _formatDate(entry.date, loc),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      children: entry.entries.map((gratitude) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.volunteer_activism,
                            color: Colors.orange,
                            size: screenWidth * 0.08,
                            semanticLabel: loc.gratitudeLogItemIcon, // e.g. "Gratitude icon"
                          ),
                          title: Text(
                            gratitude,
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// If empty => show big orange "volunteer_activism" icon & instructions
  Widget _buildEmptyScreen(
      BuildContext context,
      WidgetRef ref,
      LoggingService loggingService,
      ) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            label: loc.gratitudeLogEmptyIconSemantic, // e.g. "Tap to add your first gratitude"
            button: true,
            child: GestureDetector(
              onTap: () async {
                // Log "gratitude_log_add_pressed"
                analytics.logEvent('gratitude_log_add_pressed', parameters: {
                  'from_screen': 'gratitude_log_empty',
                  'cta_source': 'icon_add_circle',
                });
                await _showGratitudeModalAndSave(context, ref, loggingService);
              },
              child: Icon(
                Icons.volunteer_activism,
                color: Colors.orange,
                size: 72,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            loc.gratitudeLogEmptyMessage, // e.g. "No gratitude entries yet.\nTap the “+” to add your first gratitude!"
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Show the GratitudeModal, then save
  Future<void> _showGratitudeModalAndSave(
      BuildContext context,
      WidgetRef ref,
      LoggingService loggingService,
      ) async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final newGratitudes = await showDialog<List<String>>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) => const GratitudeModal(),
    );

    if (newGratitudes != null && newGratitudes.isNotEmpty) {
      try {
        final today = DateTime.now().toIso8601String().split('T')[0];
        await ref.read(gratitudeEntriesProvider.notifier).addEntry(
          today,
          newGratitudes,
        );

        loggingService.logWarning(
          '[GratitudeLogScreen] Added new gratitude entries: $newGratitudes',
        );
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(loc.gratitudeLogEntriesAdded)), // "Gratitudes added successfully!"
        );

        analytics.logEvent(
          'gratitude_entries_added',
          parameters: {
            'entries_count': newGratitudes.length,
            'from_screen': 'gratitude_log',
          },
        );
      } catch (error) {
        loggingService.logWarning(
          '[GratitudeLogScreen] Error adding new gratitude entries: $error',
        );
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(loc.gratitudeLogEntriesFailed)), // "Failed to add gratitudes. Please try again."
        );
      }
    }
  }

  /// Format date e.g. "DD/MM/YYYY"
  String _formatDate(DateTime date, AppLocalizations loc) {
    // Or use local date format if you want, e.g.:
    // final dateFormat = DateFormat.yMd(loc.localeName);
    // return dateFormat.format(date);

    return '${date.day}/${date.month}/${date.year}';
  }
}
