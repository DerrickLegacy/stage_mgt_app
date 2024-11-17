import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/booking.dart';
import 'package:stage_mgt_app/backend/services/booking_service.dart';

// Define a Character enum for radio buttons
enum Character { mobileMoney, creditCard }

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  // Define a variable to hold the selected payment method
  final bookingService = BookingService();
  late final String upcomingBookingID;
  final List<Map<String, String>> travelHistory = [];

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String storedProperty = pref.getString(property) ?? '';
    return storedProperty;
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
          for (var booking in historyBookings) {
            travelHistory.add({
              "Index": "${historyBookings.indexOf(booking) + 1}",
              "Date": booking.travelDate,
              "From": booking.from,
              "To": booking.to,
            });
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading travel history: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadTravelHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SingleChildScrollView(
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
                                            color:
                                                Colors.grey.withOpacity(0.1)),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                history["Index"]!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff1d1b20),
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
                                                const Icon(Icons.calendar_today,
                                                    size: 12,
                                                    color: Colors.grey),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    history["Date"]!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff1d1b20),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                const Icon(Icons.location_on,
                                                    size: 12,
                                                    color: Colors.red),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    history["From"]!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff1d1b20),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff1d1b20),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
