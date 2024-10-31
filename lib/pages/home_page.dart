import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/drawer.dart';
import 'package:stage_mgt_app/components/loyaltycard.dart';
import 'package:stage_mgt_app/components/remindar_c.dart';
import 'package:stage_mgt_app/components/reminderCard.dart';
import 'package:stage_mgt_app/components/service_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final loggedInUser = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Helper function to create a SliverToBoxAdapter widget
  Widget buildUserInfoBox(String userEmail) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 250.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "User is logged in as $userEmail",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            // title: const Text("App Name"),
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.deepPurple),
              title: Row(
                children: [
                  const Row(children: [
                    Text(
                      "App Name",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [],
                    )
                  ]),
                  Image.asset(
                    'lib/images/icons8-google-240.png', // Default image
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.face,
                  color: Colors.white,
                ),
                tooltip: 'My Profile',
                onPressed: () {
                  // Add Profile Logic Here
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                tooltip: 'Actions',
                onPressed: () {
                  // Add actions logic here
                },
              ),
            ],
            expandedHeight: 350.0,
          ),
          SliverToBoxAdapter(
            child: _buildInfoCard2(
              "User is logged in as ${loggedInUser.email}",
              "Derrick Legacy", // User location
              '', // Path to the avatar image
            ),
          ),
          SliverToBoxAdapter(
            child: LoyaltyBalanceCard(),
          ),

          const SliverToBoxAdapter(
            child: OurServices(),
          ),
          SliverToBoxAdapter(
            child: OurRemainder(),
          ),
          // SliverToBoxAdapter(
          //     child: ReminderCard(
          //       taxiNumberPlate: "UBC 123X",
          //       driverName: "John Doe",
          //       departureTime: "10:30 AM",
          //       onCallTap: () {
          //      print("Calling John Doe");
          //      },
          //    ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildInfoCard2(String name, String location, String avatarUrl) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 80.0, // Adjust height as needed
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30, // Adjust the size as needed
                backgroundImage: AssetImage(avatarUrl), // Avatar image
              ),
              const SizedBox(width: 15),
              // User Information
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Icons (Bell and Settings)
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Notification icon action
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Settings icon action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
