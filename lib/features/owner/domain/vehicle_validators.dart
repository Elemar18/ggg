/// Validation rules for the Add Vehicle form and the odometer update.
abstract final class VehicleValidators {
  static String? model(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Enter your motorcycle model.';
    if (v.length < 2) return 'The model is too short.';
    return null;
  }

  static String? plate(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Enter your plate number.';
    if (v.length < 3) return 'The plate number is too short.';
    if (!RegExp(r'^[A-Za-z0-9 \-]+$').hasMatch(v)) {
      return 'Use only letters, numbers, spaces or hyphens.';
    }
    return null;
  }

  static String? odometer(String? value, {int minKm = 0}) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Enter the odometer reading.';
    final n = int.tryParse(v);
    if (n == null) return 'Enter a whole number.';
    if (n > 999999) return 'That reading looks too high.';
    if (n < minKm) return "It can't be lower than your last reading ($minKm km).";
    return null;
  }

  static String? lastOilChange(DateTime? value) {
    if (value == null) return 'Select the date of your last oil change.';
    if (value.isAfter(DateTime.now())) return "The date can't be in the future.";
    return null;
  }
}
