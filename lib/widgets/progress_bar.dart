import 'package:flutter/material.dart';

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// A simple linear progress bar with an accessibility label.
class ProgressBar extends StatelessWidget {
  final double progress; // Progress value between 0 and 100

  const ProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      label: loc.progressBarSemanticLabel(progress.toStringAsFixed(0)),
      container: true,
      child: LinearProgressIndicator(
        value: progress / 100,
        minHeight: 10,
        backgroundColor: Colors.grey[300],
        color: Colors.blue,
      ),
    );
  }
}
