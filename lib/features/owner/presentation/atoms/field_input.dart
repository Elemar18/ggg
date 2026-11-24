import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../owner_tokens.dart';

/// The text box itself (no label, no error). Also used read-only for dates.
class FieldInput extends StatelessWidget {
  const FieldInput({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.hasError = false,
    this.suffix,
    this.semanticLabel,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool hasError;
  final Widget? suffix;
  final String? semanticLabel;
  final bool autofocus;

  OutlineInputBorder _border(Color color, double width) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(OwnerMetrics.fieldRadius),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      textField: true,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        autofocus: autofocus,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: OwnerText.fieldText,
        cursorColor: OwnerColors.textPrimary,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: OwnerColors.fieldBackground,
          hintText: hintText,
          hintStyle: OwnerText.fieldHint,
          suffixIcon: suffix,
          constraints: const BoxConstraints(minHeight: OwnerMetrics.fieldHeight),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          border: _border(OwnerColors.border, 1),
          enabledBorder:
              _border(hasError ? OwnerColors.textPrimary : OwnerColors.border, 1),
          focusedBorder: _border(OwnerColors.textPrimary, 1.5),
        ),
      ),
    );
  }
}
