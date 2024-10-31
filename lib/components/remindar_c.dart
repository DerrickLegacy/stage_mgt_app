import 'package:flutter/material.dart';

class ReminderCard2 extends StatelessWidget {
  final VoidCallback onCallTap;
  final String driverName;
  final String departureTime;
  //final String title;
 // final String imagePath;
  final String taxiNumberPlate;
  final bool isNew; // To display "NEW" label if true

const ReminderCard2({
    Key? key,
     required this.driverName,
    required this.departureTime,
    required this.taxiNumberPlate,
   // required this.title,
    //required this.imagePath,
   required this.onCallTap,
    this.isNew = false,
  }) : super(key: key);
  
  //get onCallTap => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0, // Adjust the height as needed
      width: 400.0, // Adjust the width as needed
      margin: const EdgeInsets.all(3.0),
      // padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
            // Title of the service
          const Positioned(
            top: 10,
             left: 10,
            // right: 3,
            child: Text(
               "Next Vehicle",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Aligns the title to the center
            ),
          ),
           // Taxi Number Plate
          Positioned(
            top: 40,
            left: 75,
            child: Text(
              "Taxi Number: $taxiNumberPlate",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
           Positioned(
            top: 70,
            left: 75,
            child: Text(
              "Driver: $driverName",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
           
          // Taxi Icon Avatar in the left corner
            const Positioned( 
               top: 50,
               left: 10,
              child: CircleAvatar(
                radius: 30, // Avatar size
                backgroundColor: Colors.white, // Background color for the avatar
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.yellow, // Taxi icon color
                  size: 50,
                ),
              ),
            ),
          // Service Image
          Positioned(
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
          // Title of the service
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Text(
              "Departure Time: $departureTime",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Aligns the title to the center
            ),
          ),
          // "NEW" label if isNew is true
          if (isNew)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OurRemainder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title "Our Services"
          const Text(
            "Remainder",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          // Row with two service cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReminderCard2(
                taxiNumberPlate: "UAH 186H",
                driverName: "John Doe",
                departureTime: "10:30 AM",
                 onCallTap: () {
               print("Calling John Doe");
               },

              ),
            ],
          ),
        ],
      ),
    );
  }
}