/// The values collected by the Add Vehicle form (O1).
class VehicleFormData {
  const VehicleFormData({
    required this.model,
    required this.plate,
    required this.odometerKm,
    required this.lastOilChange,
  });

  final String model;
  final String plate;
  final int odometerKm;
  final DateTime lastOilChange;
}
