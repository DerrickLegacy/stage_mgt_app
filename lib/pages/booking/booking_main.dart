import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

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

  // Sample data for history
  final List<Map<String, String>> travelHistory = [
    {
      "Index": "1",
      "Date": "2024-01-01",
      "From": "Kampala",
      "To": "Nairobi",
    },
    {
      "Index": "2",
      "Date": "2024-02-15",
      "From": "Entebbe",
      "To": "Dar es Salaam",
    },
    {
      "Index": "3",
      "Date": "2024-03-10",
      "From": "Jinja",
      "To": "Kigali",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
        backgroundColor: Colors.deepPurple,
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
                  headerBackgroundColor: Colors
                      .deepPurple, // Purple color for the accordion headers
                  contentBorderColor:
                      Colors.deepPurple, // Purple color for the content border
                  children: [
                    // Upcoming Travels Section
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
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField("From", Icons.location_on),
                          const SizedBox(height: 10.0),
                          buildTextField("To", Icons.location_on),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                  child: buildTextField(
                                      "Date", Icons.calendar_today)),
                              const SizedBox(width: 10.0),
                              Expanded(
                                  child: buildTextField(
                                      "Number of Passengers", Icons.person)),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              "Approximate Distance", Icons.social_distance),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              "Approximate Travel Time", Icons.access_time),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                  child: buildTextField(
                                      "Contact Number", Icons.phone)),
                              const SizedBox(width: 10.0),
                              Expanded(
                                  child: buildTextField(
                                      "Email Address", Icons.email)),
                            ],
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors
                          .deepPurple.shade700, // Darker purple when opened
                      contentBackgroundColor: Colors.deepPurpleAccent
                          .withOpacity(0.1), // Light purple for content
                      contentBorderColor: Colors.deepPurple,
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
                          buildTextField("Name", Icons.person),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Route",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          buildTextField("From", Icons.location_on),
                          const SizedBox(height: 10.0),
                          buildTextField("To", Icons.location_on),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                  child: buildTextField(
                                      "Date", Icons.calendar_today)),
                              const SizedBox(width: 10.0),
                              Expanded(
                                  child: buildTextField(
                                      "Number Of Passengers", Icons.person)),
                            ],
                          ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.deepPurple.shade700,
                      contentBackgroundColor:
                          Colors.deepPurpleAccent.withOpacity(0.1),
                      contentBorderColor: Colors.deepPurple,
                    ),

                    // Travel History Section
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(15.0),
                      isOpen: false,
                      leftIcon: const Icon(Icons.history, color: Colors.white),
                      header: const Text(
                        "Travel History",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataTable(
                            columns: const [
                              DataColumn(label: Text("Index")),
                              DataColumn(label: Text("Date")),
                              DataColumn(label: Text("From")),
                              DataColumn(label: Text("To")),
                            ],
                            rows: travelHistory.map((history) {
                              return DataRow(cells: [
                                DataCell(Text(history["Index"]!)),
                                DataCell(Text(history["Date"]!)),
                                DataCell(Text(history["From"]!)),
                                DataCell(Text(history["To"]!)),
                              ]);
                            }).toList(),
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.deepPurple.shade700,
                      contentBackgroundColor:
                          Colors.deepPurpleAccent.withOpacity(0.1),
                      contentBorderColor: Colors.deepPurple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build a custom TextFormField
  Widget buildTextField(String labelText, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
