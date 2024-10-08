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
      // "TicketId": "KN-1906",
    },
    {
      "Index": "2",
      "Date": "2024-02-15",
      "From": "Entebbe",
      "To": "Dar es Salaam",
      // "TicketId": "ED-1236",
    },
    {
      "Index": "3",
      "Date": "2024-03-10",
      "From": "Jinja",
      "To": "Kigali",
      // "TicketId": "JK-19316",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Accordion(
                  maxOpenSections: 1,
                  headerBackgroundColor: Colors.blueAccent,
                  contentBorderColor: Colors.blueAccent,
                  children: [
                    // First Accordion Section - Upcoming Travels
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(6.0),
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.flight_takeoff, color: Colors.white),
                      header: const Text(
                        "Upcoming Travels",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "From",
                              hintText: "From",
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "To",
                              hintText: "To",
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Date",
                                    hintText: "Select Date",
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Number Of Passengers",
                                    hintText: "Enter Number",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.blue,
                      contentBackgroundColor: Colors.blue[50],
                      contentBorderColor: Colors.blue,
                    ),

                    // Second Accordion Section - Book For A Journey
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(6.0),
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.flight_takeoff, color: Colors.white),
                      header: const Text(
                        "Book For A Journey",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "From",
                              hintText: "From",
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "To",
                              hintText: "To",
                              prefixIcon: Icon(Icons.location_on),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Date",
                                    hintText: "Select Date",
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Number Of Passengers",
                                    hintText: "Enter Number",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Select Payment Method",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.blue,
                      contentBackgroundColor: Colors.blue[50],
                      contentBorderColor: Colors.blue,
                    ),

                    // Third Accordion Section - Travel History
                    AccordionSection(
                      headerPadding: const EdgeInsets.all(6.0),
                      isOpen: true,
                      leftIcon: const Icon(Icons.history, color: Colors.white),
                      header: const Text(
                        "History",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                              // DataColumn(label: Text("TicketId")),
                            ],
                            rows: travelHistory
                                .map(
                                  (history) => DataRow(cells: [
                                    DataCell(Text(history["Index"]!)),
                                    DataCell(Text(history["Date"]!)),
                                    DataCell(Text(history["From"]!)),
                                    DataCell(Text(history["To"]!)),
                                    // DataCell(Text(history["TickedId"]!)),
                                  ]),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      headerBackgroundColorOpened: Colors.blue,
                      contentBackgroundColor: Colors.blue[50],
                      contentBorderColor: Colors.blue,
                    ),

                    // Fourth Accordion Section - Contact Support
                    AccordionSection(
                      leftIcon:
                          const Icon(Icons.contact_phone, color: Colors.white),
                      header: const Text(
                        "Contact Support",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      content: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: support@travelsite.com"),
                          Text("Phone: +123 456 7890"),
                          Text("Working Hours: 9:00 AM - 5:00 PM (Mon-Fri)"),
                        ],
                      ),
                      headerBackgroundColor: Colors.redAccent,
                      headerBackgroundColorOpened: Colors.red,
                      contentBackgroundColor: Colors.red[50],
                      contentBorderColor: Colors.redAccent,
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
}
