import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../atoms/field_error_text.dart';
import '../atoms/field_input.dart';
import '../atoms/field_label.dart';
import '../owner_tokens.dart';

/// A label, a text box and an error line. Validates when the user leaves the
/// field and when the form is submitted.
class LabeledField extends StatefulWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onFieldSubmitted,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autofocus;

  @override
  State<LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<LabeledField> {
  final _focus = FocusNode();
  final _key = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus) _key.currentState?.validate();
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: OwnerMetrics.sm),
      child: FormField<String>(
        key: _key,
        initialValue: widget.controller.text,
        validator: widget.validator,
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(widget.label),
            const SizedBox(height: OwnerMetrics.xs),
            FieldInput(
              controller: widget.controller,
              focusNode: _focus,
              hintText: widget.hintText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              textCapitalization: widget.textCapitalization,
              autofocus: widget.autofocus,
              semanticLabel: widget.label,
              hasError: state.hasError,
              onSubmitted: widget.onFieldSubmitted,
              onChanged: (value) {
                state.didChange(value);
                if (state.hasError) state.validate();
              },
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: OwnerMetrics.xs),
                child: FieldErrorText(state.errorText!),
              ),
          ],
        ),
      ),
    );
  }
}
