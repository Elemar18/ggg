import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/vehicle_validators.dart';
import '../atoms/action_button.dart';
import '../molecules/info_box.dart';
import '../molecules/labeled_field.dart';
import '../owner_tokens.dart';

/// Opens the "update odometer" bottom sheet.
/// [onSave] returns an error message to show, or null when it worked.
Future<void> showOdometerSheet(
  BuildContext context, {
  required int lastKm,
  required Future<String?> Function(int km) onSave,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: OwnerColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(OwnerMetrics.cardRadius)),
    ),
    builder: (_) => _OdometerSheet(lastKm: lastKm, onSave: onSave),
  );
}

class _OdometerSheet extends StatefulWidget {
  const _OdometerSheet({required this.lastKm, required this.onSave});

  final int lastKm;
  final Future<String?> Function(int km) onSave;

  @override
  State<_OdometerSheet> createState() => _OdometerSheetState();
}

class _OdometerSheetState extends State<_OdometerSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _saving = false;
  String? _message;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _saving = true;
      _message = null;
    });
    final error = await widget.onSave(int.parse(_controller.text.trim()));
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _saving = false;
        _message = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20 + bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Update odometer', style: OwnerText.headerTitle.copyWith(fontSize: 18)),
            const SizedBox(height: 4),
            Text('Enter the number shown on your motorcycle.',
                style: OwnerText.headerSubtitle),
            LabeledField(
              label: 'Odometer (km)',
              controller: _controller,
              hintText: '${widget.lastKm}',
              keyboardType: TextInputType.number,
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) =>
                  VehicleValidators.odometer(v, minKm: widget.lastKm),
            ),
            if (_message != null) ...[
              const SizedBox(height: OwnerMetrics.gap),
              InfoBox(_message!),
            ],
            const SizedBox(height: OwnerMetrics.gap),
            ActionButton(label: 'Save reading', isLoading: _saving, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
