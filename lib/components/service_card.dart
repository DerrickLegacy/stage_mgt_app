import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/machineOperators.dart';
import 'package:stage_mgt_app/components/trucks.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isNew; // To display "NEW" label if true

  const ServiceCard({
    Key? key,
    required this.title,
    required this.imagePath,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0, // Adjust the height as needed
      width: 150.0, // Adjust the width as needed
      margin: const EdgeInsets.all(10.0),
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
          // Service Image
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            bottom: 60, // Adjust to leave space for the title
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Ensures the image fits within the box
              height: 60,
              width: 60,
            ),
          ),
          // Title of the service
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Text(
              title,
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

class OurServices extends StatelessWidget {
  const OurServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title "Our Services"
          const Text(
            "Our Services",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          // Row with two service cards
          const Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ServiceCard(
                  title: "Order a Taxi",
                  imagePath:
                      'lib/images/images.jpeg', // Replace with your image path
                  // isNew: true, // Show "NEW" badge
                ),
              ),
              Expanded(
                child: ServiceCard(
                  title: "Express Drop",
                  imagePath:
                      'lib/images/deliver.jpg', // Replace with your image path
                  // lib/images/taxi.jpeg
                ),
              ),
            ],
          ),
          Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  // Navigate to a specific screen or perform an action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MachineOperatorsScreen(),
                      ));
                },
                child: const ServiceCard(
                  title: "Hire TruckOperators",
                  imagePath:
                      'lib/images/operator.jpg', // Replace with your image path
                  // isNew: true, // Show "NEW" badge
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  // Navigate to a specific screen or perform an action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrucksScreen(),
                      ));
                },
                child: const ServiceCard(
                  title: "Hire Trucks",
                  imagePath:
                      'lib/images/truck.jpg', // Replace with your image path
                  // lib/images/taxi.jpeg
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
