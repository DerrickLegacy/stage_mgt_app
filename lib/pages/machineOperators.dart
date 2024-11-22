import 'package:flutter/material.dart';

class MachineOperator {
  final String name;
  final int hourlyRate;
  final String imageUrl;

  MachineOperator({
    required this.name,
    required this.hourlyRate,
    required this.imageUrl,
  });
}

class MachineOperatorsScreen extends StatelessWidget {
  final List<MachineOperator> operators = [
    MachineOperator(
      name: 'Excavator Operator',
      hourlyRate: 25,
      imageUrl: 'lib/images/escalator_operator.png',
    ),
    MachineOperator(
      name: 'Crane Operator',
      hourlyRate: 30,
      imageUrl: 'lib/images/crane_operator.png', 
    ),
    // Add more operators as needed
  ];

  void onCallTap() {
    // Add your call functionality here
    print("Calling machine operator...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Operators'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: operators.length,
        itemBuilder: (context, index) {
          final operator = operators[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          operator.imageUrl,
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
                              operator.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[900],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Hourly Rate: UGX ${operator.hourlyRate}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.brown[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onCallTap, // Call functionality when tapped
                    child: const Icon(
                      Icons.phone,
                      color: Colors.blue, // Phone icon color
                      size: 24,
                    ),
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
//from Lasse