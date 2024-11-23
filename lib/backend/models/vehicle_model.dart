class VehicleModel {
  final String id; // Unique identifier for the vehicle
  final String vehicleType; // e.g., Bus, Taxi
  final int seatingCapacity; // Number of seats
  final String status; // e.g., "Available", "In Maintenance"
  final double costPerMilage;
  final String createdBy; // User who added the vehicle
  final DateTime createdAt; // When the vehicle was added

  VehicleModel({
    required this.id,
    required this.vehicleType,
    required this.seatingCapacity,
    required this.status,
    required this.createdBy,
    required this.costPerMilage,
    required this.createdAt,
  });

  // Factory method for JSON serialization
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      vehicleType: json['vehicleType'],
      seatingCapacity: json['seatingCapacity'],
      status: json['status'],
      costPerMilage: double.parse(json['costPerMilage']), // Parse as double
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleType': vehicleType,
      'seatingCapacity': seatingCapacity,
      'status': status,
      'costPerMilage':
          costPerMilage.toString(), // Convert back to String if needed
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
