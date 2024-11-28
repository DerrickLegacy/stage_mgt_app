import 'package:flutter/material.dart';

class Truck {
  final String name;
  final int hourlyRate;
  final String imageUrl;

  Truck({required this.name, required this.hourlyRate, required this.imageUrl});
}

class TrucksScreen extends StatelessWidget {
  //const TrucksScreen({super.key});

  final List<Truck> trucks = [
    Truck(
        name: 'Refrigerated trucks',
        hourlyRate: 15,
        imageUrl: 'lib/images/refrigerated-vehicles.webp'),
    Truck(name: 'Dump truck', hourlyRate: 20, imageUrl: 'lib/images/truck.jpg'),
    // ... more trucks
  ];

  get onCallTap => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trucks'),
        backgroundColor: Colors.blueAccent,
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
                SizedBox(width: 20),
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
                      SizedBox(height: 4),
                      Text(
                        //truck.hourlyRate as String,
                        'hourly Rate: USD ${truck.hourlyRate}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[300],
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent, // Text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // TODO: Navigate to hiring screen
                          print('Hiring ${truck.name}');
                        },
                        child: const Text('Hire'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return ListTile(
          //   //leading: Image.network(truck.imageUrl),
          //   title: Text(truck.name),
          //   subtitle: Text('\$${truck.hourlyRate} per hour'),
          //   trailing: const Icon(Icons.arrow_right),
          //   leading: CircleAvatar(
          //     radius: 50,
          //     backgroundImage: NetworkImage(truck.imageUrl),
          //     //child: Icon(Icons.broken_image), // Placeholder icon
          //   ),
          // );
        },
      ),
    );
  }
}
