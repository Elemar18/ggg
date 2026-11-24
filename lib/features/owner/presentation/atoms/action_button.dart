import 'package:flutter/material.dart';

import '../owner_tokens.dart';

enum ActionButtonVariant { primary, secondary }

/// Full-width button. A null [onPressed] shows the disabled style.
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.variant = ActionButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ActionButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final primary = variant == ActionButtonVariant.primary;
    final foreground =
        primary ? OwnerColors.onPrimaryButton : OwnerColors.textPrimary;
    final VoidCallback? effective = isLoading ? () {} : onPressed;

    return SizedBox(
      width: double.infinity,
      height: OwnerMetrics.buttonHeight,
      child: ElevatedButton(
        onPressed: effective,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              primary ? OwnerColors.primaryButton : OwnerColors.surface,
          foregroundColor: foreground,
          disabledBackgroundColor:
              primary ? OwnerColors.disabledButton : OwnerColors.surface,
          disabledForegroundColor:
              primary ? OwnerColors.onDisabledButton : OwnerColors.textTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OwnerMetrics.buttonRadius),
            side: primary
                ? BorderSide.none
                : const BorderSide(color: OwnerColors.borderStrong),
          ),
        ).copyWith(
          overlayColor: const WidgetStatePropertyAll(OwnerColors.pressedOverlay),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
              )
            : Text(label, style: OwnerText.button),
      ),
    );
  }
}
