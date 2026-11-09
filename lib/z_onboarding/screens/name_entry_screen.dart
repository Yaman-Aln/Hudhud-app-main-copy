// lib/z_onboarding/screens/name_entry_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
import 'package:hudhud_quran_app_new/services/notification_service.dart';

/// A screen where the user enters their name and chooses a notification frequency.
/// Once they tap "Next," we call [onNext] with the user's final name and frequency.
/// No "Skip" button is present; it fits into an OnboardingFlow.
class NameEntryScreen extends ConsumerStatefulWidget {
  final void Function(String name, String frequency) onNext;

  const NameEntryScreen({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  @override
  ConsumerState<NameEntryScreen> createState() => _NameEntryScreenState();
}

class _NameEntryScreenState extends ConsumerState<NameEntryScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedNotificationFrequency = 'Daily';

  @override
  void initState() {
    super.initState();
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('name_entry_screen_viewed');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Requests notification permission on iOS/macOS (alert, sound, badge)
  /// and on Android 13+ (POST_NOTIFICATIONS), if needed.
  Future<void> _requestNotificationPermissions() async {
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.initNotificationService();
    await notificationService.requestPlatformPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      label: loc.nameEntryScreenSemantic,
      child: Scaffold(
        backgroundColor: Colors.blue[50], // Example background color
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            loc.nameEntryScreenAppBarTitle,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Intro text
              Text(
                loc.nameEntryScreenIntroText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),

              // Container with the text field
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Semantics(
                  label: loc.nameEntryTextFieldSemantic,
                  textField: true,
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: loc.profileEnterYourName,
                      labelStyle: const TextStyle(color: Colors.black87),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Notifications frequency selector
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Text(
                      "Notifications:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Semantics(
                        label: loc.nameEntryNotificationFrequencyDropdownLabel,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedNotificationFrequency,
                          underline: const SizedBox(),
                          onChanged: (newValue) {
                            if (newValue == null) return;
                            setState(() {
                              _selectedNotificationFrequency = newValue;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Daily',
                              child: Text(
                                loc.nameEntryNotificationFrequencyDaily,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Weekly',
                              child: Text(
                                loc.nameEntryNotificationFrequencyWeekly,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'None',
                              child: Text(
                                loc.nameEntryNotificationFrequencyNone,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Optional explanation if user chose daily/weekly
              if (_selectedNotificationFrequency != 'None')
                Text(
                  loc.notificationPermissionPrompt,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(height: 40),

              // Next button
              Center(
                child: Semantics(
                  button: true,
                  label: loc.nameEntryNextSemantic,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Request notification permissions only if daily/weekly
                      if (_selectedNotificationFrequency != 'None') {
                        await _requestNotificationPermissions();
                      }

                      // If no user name was provided, default to loc.profileNameGuest
                      final rawName = _controller.text.trim();
                      final wasEmpty = rawName.isEmpty;
                      final finalName =
                      wasEmpty ? loc.profileNameGuest : rawName;

                      analytics.logEvent('name_entry_next', parameters: {
                        'was_empty': wasEmpty.toString(),
                        'selectedNotificationFrequency': _selectedNotificationFrequency,
                      });

                      // Call onNext with the final name & frequency
                      widget.onNext(finalName, _selectedNotificationFrequency);
                    },
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
                        loc.nameEntryNextLabel,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A reusable decoration for containers, matching any existing onboarding style
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
