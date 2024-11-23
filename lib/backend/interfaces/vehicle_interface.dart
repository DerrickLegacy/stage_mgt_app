import 'package:stage_mgt_app/backend/models/vehicle_model.dart';

abstract class IVehicle {
  Future<void> addVehicle(Map<String, dynamic> vehicleDetails);
  Future<VehicleModel> getVehicleDetails(String vehicleId);
  Future<void> deleteVehicle(String vehicleId);
  Future<void> updateVehicle(String vehicleId, Map<String, dynamic> updates);
}
