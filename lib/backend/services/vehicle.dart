import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_mgt_app/backend/interfaces/vehicle_interface.dart';
import 'package:stage_mgt_app/backend/models/vehicle_details.dart';
import 'package:stage_mgt_app/backend/models/vehicle_model.dart';

class VehicleService extends IVehicle {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = "vehicles";

  // Add a new vehicle
  @override
  Future<void> addVehicle(Map<String, dynamic> vehicleDetails) async {
    try {
      await _db.collection(collectionName).add(vehicleDetails);
    } catch (e) {
      throw Exception("Failed to add vehicle type: $e");
    }
  }

  Future<List<VehicleDetails>> getVehiclesForDropDownList() async {
    try {
      final QuerySnapshot snapshot = await _db.collection(collectionName).get();

      return snapshot.docs.map((doc) {
        final vehicleType = doc['vehicleType'] as String;
        final costPerMileage = doc['costPerMilage'] as String;

        return VehicleDetails(
          vehicleType: vehicleType,
          costPerMileage: costPerMileage,
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch vehicle types: $e");
    }
  }

  // Delete a vehicle by ID
  @override
  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await _db.collection(collectionName).doc(vehicleId).delete();
    } catch (e) {
      throw Exception("Failed to delete vehicle type: $e");
    }
  }

  // Get vehicle details by ID
  @override
  Future<VehicleModel> getVehicleDetails(String vehicleId) async {
    try {
      final docSnapshot =
          await _db.collection(collectionName).doc(vehicleId).get();
      if (docSnapshot.exists) {
        return VehicleModel.fromJson(docSnapshot.data()!);
      } else {
        throw Exception("Vehicle not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch vehicle details: $e");
    }
  }

  // Update vehicle details by ID
  @override
  Future<void> updateVehicle(
      String vehicleId, Map<String, dynamic> updates) async {
    try {
      await _db.collection(collectionName).doc(vehicleId).update(updates);
    } catch (e) {
      throw Exception("Failed to update vehicle: $e");
    }
  }
}
