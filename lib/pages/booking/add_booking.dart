import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';
import 'package:stage_mgt_app/backend/models/vehicle_details.dart';
import 'package:stage_mgt_app/backend/services/booking_service.dart';
import 'package:stage_mgt_app/backend/services/vehicle.dart';

// Define a Character enum for radio buttons
enum Character { mobileMoney, creditCard }

class CreateBooking extends StatefulWidget {
  const CreateBooking({super.key});

  @override
  State<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking> {
  Character? _character = Character.mobileMoney;
  final bookingService = BookingService();
  final vehicleService = VehicleService();

  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  final TextEditingController _travelTimeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _milageCostController = TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  String selectedVehicle = '';
  int milageCost = 0;
  double totalCost = 0.0;
  List<String> vehicleOptions = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadVehicles();
  }

  // Load user data and set default values in controllers
  Future<void> _loadUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = pref.getString("username") ?? "Your Name";
      _phoneController.text =
          pref.getString("phoneNumber") ?? "Your Phone Number";
      _emailController.text =
          pref.getString("email") ?? "your.email@example.com";
    });
  }

  List<VehicleDetails> allVehicleDetails = []; // Store the full vehicle details

  Future<void> _loadVehicles() async {
    try {
      allVehicleDetails = (await vehicleService.getVehiclesForDropDownList());

      vehicleOptions =
          allVehicleDetails.map((vehicle) => vehicle.vehicleType).toList();

      print(vehicleOptions);

      if (vehicleOptions.isNotEmpty) {
        setState(() {
          selectedVehicle = vehicleOptions[0];
          calculateTotalCost();
        });
      }
    } catch (e) {
      print("Error loading vehicles: $e");
    }
  }

  Future<List<String>> getVehiclesForDropDownList() async {
    List<String> vehiclesList =
        (await vehicleService.getVehiclesForDropDownList()).cast<String>();

    return vehiclesList;
  }

  void calculateTotalCost() {
    if (selectedVehicle.isNotEmpty) {
      // Find selected vehicle details
      final selectedVehicleDetails = allVehicleDetails.firstWhere(
        (vehicle) => vehicle.vehicleType == selectedVehicle,
        orElse: () {
          print("No matching vehicle found for: $selectedVehicle");
          return VehicleDetails(vehicleType: '', costPerMileage: '0');
        },
      );

      // Debug selected vehicle details
      print(
          "Selected Vehicle Details: ${selectedVehicleDetails.vehicleType}, ${selectedVehicleDetails.costPerMileage}");

      setState(() {
        milageCost =
            (double.tryParse(selectedVehicleDetails.costPerMileage) ?? 0)
                .toInt();
        print("Mileage Cost: $milageCost");

        double distance = 200.0;
        totalCost = milageCost * distance;
        print("Total Cost: $totalCost");

        // Update controllers
        _milageCostController.text = milageCost.toString();
        _totalCostController.text = totalCost.toStringAsFixed(2);
      });
    } else {
      print("No vehicle selected.");
    }
  }

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

  bool isLoading = false;

  Future<void> submitBooking() async {
    String paymentMethod =
        _character == Character.mobileMoney ? 'Mobile Money' : 'Credit Card';

    BookingModel booking = BookingModel(
      bookingId: '',
      name: _nameController.text,
      userId: await getUserProperty("userId"),
      from: _fromController.text,
      to: _toController.text,
      travelDate: _dateController.text,
      numberOfPassengers: _passengerController.text,
      paymentMethod: paymentMethod,
      status: "no action",
      distance: '',
      travelTime: _travelTimeController.text,
      vehicleType: selectedVehicle,
      milageCost: milageCost,
      totalCost: totalCost.toInt(),
      emailAddress: _emailController.text,
      contactNumber: _phoneController.text,
      cardNumber: _cardNumberController.text,
      cvc: _cvcController.text,
    );
    setState(() => isLoading = true);

    try {
      await bookingService.createBooking(booking);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created Successfully.')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating booking: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(currentDate.year + 5),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (selectedTime != null) {
      setState(() {
        _travelTimeController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Booking'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 15.0),
                buildTextField("Name", Icons.person, _nameController),
                const SizedBox(height: 10.0),
                buildTextField("Email Address", Icons.email, _emailController),
                const SizedBox(height: 10.0),
                const Text(
                  "Route",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 15.0),
                buildTextField("From", Icons.location_on, _fromController),
                const SizedBox(height: 10.0),
                buildTextField("To", Icons.location_on, _toController),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Travel Date',
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                        child: buildTextField("Number Of Passengers",
                            Icons.person, _passengerController)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedVehicle,
                        decoration: InputDecoration(
                          labelText: "Select Vehicle", // Label for the dropdown
                          prefixIcon: const Icon(
                              Icons.directions_car), // Optional: Add an icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Match the text field border
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedVehicle = newValue!;
                            calculateTotalCost(); // Recalculate total cost on selection
                          });
                        },
                        items: vehicleOptions.map((vehicle) {
                          return DropdownMenuItem<String>(
                            value: vehicle,
                            child: Text(vehicle),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: buildTextField(
                        "Cost Per Mileage",
                        Icons.money,
                        _milageCostController,
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                buildTextField(
                  "Total Cost",
                  Icons.money_off_csred_outlined,
                  enabled: false,
                  _totalCostController,
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _travelTimeController,
                      decoration: const InputDecoration(
                        labelText: "Travel Time",
                        hintText: "E.g., 2:00 PM",
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "Select Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                ListTile(
                  title: const Text('Mobile Money'),
                  leading: Radio<Character>(
                    value: Character.mobileMoney,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                if (_character == Character.mobileMoney)
                  buildTextField("Phone Number", Icons.phone, _phoneController),
                ListTile(
                  title: const Text('Credit Card'),
                  leading: Radio<Character>(
                    value: Character.creditCard,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                if (_character == Character.creditCard) ...[
                  buildTextField("Credit Card Number", Icons.credit_card,
                      _cardNumberController),
                  const SizedBox(height: 10.0),
                  buildTextField("CVC", Icons.lock, _cvcController),
                ],
                const SizedBox(height: 20.0),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: submitBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          // padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    IconData icon,
    TextEditingController controller, {
    bool enabled = true, // Optional parameter to control enabling/disabling
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      enabled: enabled, // Use the parameter to disable the input
    );
  }

  Widget buildDropdownField({
    required String labelText,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
