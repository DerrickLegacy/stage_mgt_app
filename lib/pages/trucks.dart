import 'package:flutter/material.dart';

class Truck {
  final String name;
  final int hourlyRate;
  final String imageUrl;

  Truck({required this.name, required this.hourlyRate, required this.imageUrl});
}

class TrucksScreen extends StatelessWidget {
  final List<Truck> trucks = [
    Truck(
        name: 'Refrigerated trucks',
        hourlyRate: 15,
        imageUrl: 'lib/images/refrigerated-vehicles.webp'),
    Truck(name: 'Truck 2', hourlyRate: 20, imageUrl: 'lib/images/truck.jpg'),
  ];

  get onCallTap => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trucks'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: trucks.length,
        itemBuilder: (context, index) {
          final truck = trucks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    truck.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truck.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        //truck.hourlyRate as String,
                        truck.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[300],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        truck.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      // Service Image
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
