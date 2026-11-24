import 'package:flutter/material.dart';

import '../../domain/formatters.dart';
import '../atoms/field_error_text.dart';
import '../atoms/field_input.dart';
import '../atoms/field_label.dart';
import '../owner_tokens.dart';

/// A label and a read-only box that opens the date picker when tapped.
class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.onChanged,
    this.validator,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final String hintText;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String? Function(DateTime?)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value == null ? '' : formatDate(widget.value!),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick(FormFieldState<DateTime> state) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? now,
      firstDate: widget.firstDate ?? DateTime(now.year - 5),
      lastDate: widget.lastDate ?? now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: OwnerColors.primaryButton,
            onPrimary: OwnerColors.onPrimaryButton,
            surface: OwnerColors.surface,
            onSurface: OwnerColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    _controller.text = formatDate(picked);
    state.didChange(picked);
    widget.onChanged(picked);
    if (state.hasError) state.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: OwnerMetrics.sm),
      child: FormField<DateTime>(
        initialValue: widget.value,
        validator: widget.validator,
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(widget.label),
            const SizedBox(height: OwnerMetrics.xs),
            FieldInput(
              controller: _controller,
              readOnly: true,
              hintText: widget.hintText,
              semanticLabel: '${widget.label}. Opens a date picker.',
              hasError: state.hasError,
              onTap: () => _pick(state),
              suffix: const Icon(Icons.calendar_today_outlined,
                  size: 18, color: OwnerColors.textTertiary),
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
