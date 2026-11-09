// lib/widgets/review_mode_toggle.dart

import 'package:flutter/material.dart';
import '../providers/ff_logging_service_provider.dart';

// note: NOT Localized *****
class ReviewModeToggle extends StatelessWidget {
  const ReviewModeToggle({
    super.key,
    required this.isReviewMode,
    required this.onToggle,
  });

  final bool isReviewMode;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Review Mode'),
      value: isReviewMode,
      onChanged: onToggle,
    );
  }
}
