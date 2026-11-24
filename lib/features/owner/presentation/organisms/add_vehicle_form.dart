import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/vehicle_form_data.dart';
import '../../domain/vehicle_validators.dart';
import '../atoms/action_button.dart';
import '../atoms/section_label.dart';
import '../atoms/surface_card.dart';
import '../molecules/date_picker_field.dart';
import '../molecules/info_box.dart';
import '../molecules/labeled_field.dart';
import '../owner_tokens.dart';

/// O1: the Add Vehicle form. Holds the form state and validation only.
class AddVehicleForm extends StatefulWidget {
  const AddVehicleForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
    this.message,
  });

  final ValueChanged<VehicleFormData> onSubmit;
  final bool isLoading;
  final String? message;

  @override
  State<AddVehicleForm> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _model = TextEditingController();
  final _plate = TextEditingController();
  final _odometer = TextEditingController();
  DateTime? _lastOilChange;

  @override
  void dispose() {
    _model.dispose();
    _plate.dispose();
    _odometer.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      VehicleFormData(
        model: _model.text.trim(),
        plate: _plate.text.trim().toUpperCase(),
        odometerKm: int.parse(_odometer.text.trim()),
        lastOilChange: _lastOilChange!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionLabel('Vehicle details'),
                LabeledField(
                  label: 'Model',
                  controller: _model,
                  hintText: 'Honda Click 125',
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: VehicleValidators.model,
                ),
                LabeledField(
                  label: 'Plate',
                  controller: _plate,
                  hintText: 'ABC 1234',
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  validator: VehicleValidators.plate,
                ),
                LabeledField(
                  label: 'Odometer (km)',
                  controller: _odometer,
                  hintText: '12100',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: VehicleValidators.odometer,
                ),
                DatePickerField(
                  label: 'Last oil change',
                  hintText: 'Select date',
                  value: _lastOilChange,
                  onChanged: (d) => setState(() => _lastOilChange = d),
                  validator: VehicleValidators.lastOilChange,
                ),
              ],
            ),
          ),
          const SizedBox(height: OwnerMetrics.gap),
          const InfoBox(
            'The app creates the service rules: oil every 3,000 km or 3 months, '
            'battery check, tire check.',
          ),
          if (widget.message != null) ...[
            const SizedBox(height: OwnerMetrics.gap),
            InfoBox(widget.message!),
          ],
          const SizedBox(height: OwnerMetrics.gap),
          ActionButton(
            label: 'Save vehicle',
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
