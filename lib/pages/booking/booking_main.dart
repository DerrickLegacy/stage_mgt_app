import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';
import 'package:stage_mgt_app/backend/services/booking_service.dart';

// Define a Character enum for radio buttons
enum Character { mobileMoney, creditCard }

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  // Define a variable to hold the selected payment method
  Character? _character = Character.mobileMoney;
  final bookingService = BookingService();

  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _upFromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _upToController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _upDateController = TextEditingController();
  final TextEditingController _upPassengerController = TextEditingController();
  // final TextEditingController _bookingDateController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  // final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _upDistanceController = TextEditingController();
  final TextEditingController _upTimeController = TextEditingController();
  final TextEditingController _travelTimeController = TextEditingController();
  // final TextEditingController _contactController = TextEditingController();
  final TextEditingController _upContactController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _upEmailController = TextEditingController();

  late final String upcomingBookingID;

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String storedProperty = pref.getString(property) ?? '';
    return storedProperty;
  }

  Future<void> submitBooking() async {
    // loadUpcomingTravels();
    String paymentMethod =
        _character == Character.mobileMoney ? 'Mobile Money' : 'Credit Card';
    BookingModel booking = BookingModel(
      bookingId: '', // Will be set by Firestore on creation
      name: _nameController.text,
      userId: await getUserProperty(
          "userId"), // Replace with actual user ID from auth
      from: _fromController.text,
      to: _toController.text,
      travelDate: _dateController.text,
      numberOfPassengers: _passengerController.text,
      paymentMethod: paymentMethod,
      status: "no action",
      distance: '',
      travelTime: "4:00 pm",
      emailAddress: await getUserProperty("email"),
      contactNumber: await getUserProperty("phoneNumber"), cardNumber: '',
      cvc: '',
    );

    try {
      await bookingService.createBooking(booking);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created Successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating booking: $e')),
      );
    }
  }

  // Load upcoming travels
  Future<void> loadUpcomingTravels() async {
    try {
      List<BookingModel> upcomingBookings = await bookingService
          .getUpcomingBookings(await getUserProperty("userId"));
      print(upcomingBookings);
      if (upcomingBookings.isNotEmpty) {
        var upcomingBooking = upcomingBookings[0];
        // Update the controllers with the fetched data
        _upFromController.text = upcomingBooking.from;
        _upToController.text = upcomingBooking.to;
        _dateController.text = upcomingBooking.travelDate;
        _upPassengerController.text = upcomingBooking.numberOfPassengers;
        _upDistanceController.text = upcomingBooking
            .distance; // Make sure the model has a distance field
        _upTimeController.text = upcomingBooking
            .travelTime; // Make sure the model has a travelTime field
        _upContactController.text = upcomingBooking
            .contactNumber; // Make sure the model has a contactNumber field
        _upEmailController.text = upcomingBooking
            .emailAddress; // Make sure the model has an emailAddress field
        upcomingBookingID = upcomingBooking.bookingId;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading upcoming travels: $e')),
      );
    }
  }

  Future<void> loadTravelHistory() async {
    try {
      List<BookingModel> historyBookings = await bookingService
          .getTravelHistory(await getUserProperty("userId"));
      // print("Here....we go::::::::");
      // inspect(historyBookings);
      if (historyBookings.isNotEmpty) {
        setState(() {
          travelHistory.clear();
          historyBookings.forEach((booking) {
            travelHistory.add({
              "Index": "${historyBookings.indexOf(booking) + 1}",
              "Date": "${booking.travelDate}",
              "From": "${booking.from}",
              "To": "${booking.to}",
            });
          });
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading travel history: $e')),
      );
    }
  }

  // Sample data for history
  final List<Map<String, String>> travelHistory = [];

// Function to show the DatePickerDialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        // Use the correct controller based on the dateType parameter

        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void cancelUpcomingBooking(String upcomingBookingID) async {
    // Show a confirmation dialog before canceling the booking
    bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Cancellation"),
          content: const Text(
              "Are you sure you want to cancel this upcoming booking?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false); // Close dialog with 'No'
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true); // Close dialog with 'Yes'
              },
            ),
          ],
        );
      },
    );

    if (confirmed != null && confirmed) {
      // If the user confirmed, proceed with canceling the booking
      try {
        // Assuming you have a `BookingModel` instance and a `cancelBooking` method in your backend
        // Example: cancel the booking in Firestore or API

        await bookingService.cancelBooking(upcomingBookingID);

        // Optionally, show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking canceled successfully")),
        );

        _upFromController.clear();
        _upToController.clear();
        _upPassengerController.clear();
        _upDistanceController.clear();
        _upTimeController.clear();
        _upContactController.clear();
        _upEmailController.clear();
      } catch (e) {
        // Handle any errors during cancellation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error canceling booking: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadUpcomingTravels();
    loadTravelHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Accordion(
                  maxOpenSections: 1,
                  headerBackgroundColor: Colors.blueAccent,
                  contentBorderColor: Colors.blue,
                  children: [
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(15.0),
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.flight_takeoff, color: Colors.white),
                      header: const Text(
                        "Upcoming Travels",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField(
                            "From",
                            Icons.location_on,
                            _upFromController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10.0),
                          buildTextField(
                            readOnly: true,
                            "To",
                            Icons.location_on,
                            _upToController,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const Expanded(
                                child: InkWell(
                                  child: AbsorbPointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        prefixIcon: Icon(Icons.calendar_today),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: buildTextField(
                                  "Number of Passengers",
                                  Icons.person,
                                  _upPassengerController,
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          buildTextField(
                            "Approximate Distance",
                            Icons.social_distance,
                            _upDistanceController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10.0),
                          buildTextField(
                            "Approximate Travel Time",
                            Icons.access_time,
                            _upTimeController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: buildTextField(
                                  "Contact Number",
                                  readOnly: true,
                                  Icons.phone,
                                  _upContactController,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: buildTextField(
                                  "Email Address",
                                  readOnly: true,
                                  Icons.email,
                                  _upEmailController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const SizedBox(width: 10.0),
                              ElevatedButton(
                                onPressed: () {
                                  cancelUpcomingBooking(upcomingBookingID);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red[700],
                                  shadowColor: Colors.blueAccent,
                                  elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.blue[700],
                      contentBackgroundColor:
                          Colors.blueAccent.withOpacity(0.1),
                      contentBorderColor: Colors.blue,
                    ),

                    // Book For A Journey Section
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(15.0),
                      isOpen: false,
                      leftIcon:
                          const Icon(Icons.flight_takeoff, color: Colors.white),
                      header: const Text(
                        "Book For A Journey",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Personal Details",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          buildTextField("Name", Icons.person, _nameController),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Route",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          buildTextField(
                              "From", Icons.location_on, _fromController),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              "To", Icons.location_on, _toController),
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
                                        labelText: 'Date',
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
                          buildTextField("Travel Time(2:00 pm)",
                              Icons.location_on, _travelTimeController),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Select Payment Method",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
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
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
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
                                Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        submitBooking();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue[700],
                                        shadowColor: Colors.blueAccent,
                                        elevation: 5,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text("Book Now"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.blue[700],
                      contentBackgroundColor:
                          Colors.blueAccent.withOpacity(0.1),
                      contentBorderColor: Colors.blue,
                    ),

                    // Travel History Section
                    AccordionSection(
                      headerPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      isOpen: true,
                      leftIcon: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      header: Row(
                        children: [
                          const Text(
                            "Travel History",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${travelHistory.length} trips",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Header Row
                                    const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: 32,
                                              child: Text("No.",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey))),
                                          SizedBox(width: 8),
                                          SizedBox(
                                              width: 70,
                                              child: Text("Date",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey))),
                                          SizedBox(width: 8),
                                          Expanded(
                                              child: Text("From",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey))),
                                          SizedBox(width: 8),
                                          Expanded(
                                              child: Text("To",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey))),
                                        ],
                                      ),
                                    ),
                                    // Data Rows
                                    ...travelHistory.map((history) => Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.1)),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Index
                                                SizedBox(
                                                  width: 32,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Text(
                                                      history["Index"]!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff1d1b20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                // Date
                                                SizedBox(
                                                  width: 70,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.calendar_today,
                                                          size: 12,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 4),
                                                      Flexible(
                                                        child: Text(
                                                          history["Date"]!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff1d1b20),
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                // From
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on,
                                                          size: 12,
                                                          color: Colors.red),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          history["From"]!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff1d1b20),
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                // To
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.flag,
                                                          size: 12,
                                                          color: Colors.green),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          history["To"]!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff1d1b20),
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      headerBackgroundColorOpened: Colors.blue,
                      contentBackgroundColor: Colors.grey[50],
                      contentBorderColor: Colors.transparent,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create a text input field
  Widget buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool readOnly = false}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
