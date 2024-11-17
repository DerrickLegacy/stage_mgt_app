import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';
import 'package:stage_mgt_app/backend/services/booking_service.dart';

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

  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  final TextEditingController _travelTimeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
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

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

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
      emailAddress: _emailController.text,
      contactNumber: _phoneController.text,
      cardNumber: _cardNumberController.text,
      cvc: _cvcController.text,
    );

    try {
      await bookingService.createBooking(booking);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created Successfully.')),
      );
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
                buildTextField("Travel Time(2:00 pm)", Icons.access_time,
                    _travelTimeController),
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
                  buildTextField("CVC (Card Verification Code)", Icons.lock,
                      _cvcController),
                ],
                const SizedBox(height: 20.0),
                const Text(
                  "Note: Please make sure to fill in all the required fields.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Book Now",
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
