import 'package:flutter/material.dart';

import '../atoms/action_button.dart';
import '../owner_tokens.dart';

/// Full-screen spinner shown while owner data loads.
class OwnerLoadingView extends StatelessWidget {
  const OwnerLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: OwnerColors.background,
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: OwnerColors.textPrimary,
        ),
      ),
    );
  }
}

/// Full-screen message with a retry button.
class OwnerErrorView extends StatelessWidget {
  const OwnerErrorView({super.key, required this.onRetry, this.message});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message ?? 'Something went wrong. Check your connection and try again.',
                textAlign: TextAlign.center,
                style: OwnerText.fieldText,
              ),
              const SizedBox(height: OwnerMetrics.gap),
              ActionButton(label: 'Try again', onPressed: onRetry),
            ],
          ),
        ),
      ),
    );
  }
}
