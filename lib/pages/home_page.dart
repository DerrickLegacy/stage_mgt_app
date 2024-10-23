import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/drawer.dart';
import 'package:stage_mgt_app/components/loyaltycard.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final loggedInUser = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  print("I am pressed");
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  Container(color: const Color.fromARGB(255, 30, 189, 229)),
              title: const Row(
                children: [
                  Text("App Name"),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.face),
                tooltip: 'My Profile',
                onPressed: () {
                  // Add Profile Logic Here
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
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
          SliverToBoxAdapter(
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
                    "User is logged in as ${loggedInUser.email}",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                    "User is logged in as ${loggedInUser.email}",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
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
