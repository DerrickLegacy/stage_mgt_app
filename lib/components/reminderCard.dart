import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String taxiNumberPlate;
  final String driverName;
  final String departureTime;
  final VoidCallback onCallTap;

  const ReminderCard({
    Key? key,
    required this.taxiNumberPlate,
    required this.driverName,
    required this.departureTime,
    required this.onCallTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150.0, // Adjust the height as needed
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Stack(
          children: [
            // Phone Icon in the top left corner
            Positioned(
              // top: 10,
              // left: 10,
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: onCallTap, // Call functionality when tapped
                child: const Icon(
                  Icons.phone,
                  color: Colors.blue, // Phone icon color
                  size: 24,
                ),
              ),
            ),
            // Card content (Text information)
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Next Vehicle",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  //const SizedBox(height: 10),
                  Text(
                    "Taxi Number: $taxiNumberPlate",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Driver: $driverName",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Departure Time: $departureTime",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Taxi Icon Avatar in the right corner
            const Positioned(
              // top: 0,
              // right: 10,
               top: 50,
               left: 10,
              child: CircleAvatar(
                radius: 30, // Avatar size
                backgroundColor: Colors.blue, // Background color for the avatar
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.white, // Taxi icon color
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
