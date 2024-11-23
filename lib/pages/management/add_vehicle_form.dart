import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/models/vehicle_model.dart';
import 'package:stage_mgt_app/backend/services/vehicle.dart';

class NewVehicle extends StatefulWidget {
  const NewVehicle({super.key});

  @override
  State<NewVehicle> createState() => _NewVehicleState();
}

class _NewVehicleState extends State<NewVehicle> {
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _costPerMileageController =
      TextEditingController();
  final TextEditingController _seatingCapacityController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _driverIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Vehicle"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  buildTextField(
                    "Vehicle Type",
                    Icons.category,
                    _vehicleTypeController,
                  ),
                  const SizedBox(height: 10.0),
                  buildTextField(
                    "Seating Capacity",
                    Icons.event_seat,
                    _seatingCapacityController,
                    isNumber: true,
                  ),
                  const SizedBox(height: 10.0),
                  buildTextField(
                    "Cost per Mileage",
                    Icons.money,
                    _costPerMileageController,
                    isNumber: true,
                  ),
                  const SizedBox(height: 10.0),
                  buildTextField(
                    "Status",
                    Icons.info,
                    _statusController,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveVehicleDetails();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text("Save Vehicle"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (isNumber && double.tryParse(value) == null) {
          return "$label must be a valid number";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  void saveVehicleDetails() {
    try {
      // Validate and parse seating capacity
      final seatingCapacity = int.tryParse(_seatingCapacityController.text);
      if (seatingCapacity == null) {
        throw Exception("Seating Capacity must be a valid number");
      }

      // Validate and parse cost per mileage
      final costPerMileage = double.tryParse(_costPerMileageController.text);
      if (costPerMileage == null) {
        throw Exception("Cost per Mileage must be a valid number");
      }

      final now = DateTime.now();
      final vehicle = VehicleModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        vehicleType: _vehicleTypeController.text,
        seatingCapacity: seatingCapacity,
        status: _statusController.text,
        costPerMilage: costPerMileage, // Directly using parsed value
        createdBy: "admin", // Replace with the logged-in user ID
        createdAt: now,
      );

      // Save the vehicle using the service
      VehicleService().addVehicle(vehicle.toJson()).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vehicle details saved successfully")),
        );

        // Clear the form fields
        _registrationNumberController.clear();
        _vehicleTypeController.clear();
        _seatingCapacityController.clear();
        _statusController.clear();
        _driverIdController.clear();
        _costPerMileageController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}
