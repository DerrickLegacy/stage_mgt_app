class VehicleModel {
  final String id; // Unique identifier for the vehicle
  final String registrationNumber; // Vehicle registration number
  final String vehicleType; // e.g., Bus, Taxi
  final int seatingCapacity; // Number of seats
  final String status; // e.g., "Available", "In Maintenance"
  final String driverId; // Link to the vehicle owner (if applicable)
  final String createdBy; // User who added the vehicle
  final DateTime createdAt; // When the vehicle was added

  VehicleModel({
    required this.id,
    required this.registrationNumber,
    required this.vehicleType,
    required this.seatingCapacity,
    required this.status,
    required this.driverId,
    required this.createdBy,
    required this.createdAt,
  });

  // Factory method for JSON serialization
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      registrationNumber: json['registrationNumber'],
      vehicleType: json['vehicleType'],
      seatingCapacity: json['seatingCapacity'],
      status: json['status'],
      driverId: json['driverId'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registrationNumber': registrationNumber,
      'vehicleType': vehicleType,
      'seatingCapacity': seatingCapacity,
      'status': status,
      'driverId': driverId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
