import 'package:flutter/material.dart';

class LoyaltyBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 150.0, // Adjust the height as needed
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightBlue[100], // Light blue color
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top title
              const Text(
                "Loyalty Balance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              
              // Main points section with the circular icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon with points
                  Row(
                    children: [
                      // Circular icon (trophy)
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        radius: 25,
                        child: const Icon(
                          Icons.emoji_events,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Points information
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1240pts",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "1200 points till your next reward",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              const Spacer(), // Push the rest to the bottom

              // Bottom row with user details
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Derrick Legacy",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, 
                    ),
                  ),
                  Text(
                    "XXXX 2345",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
