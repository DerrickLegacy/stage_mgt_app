import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final loggedInUser = "Derrick";

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFFCBAF87),
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
              background: Container(color: const Color(0xFF30475E)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Taxi App",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //sub title
                          Text(
                            "\"With you, to the end of the world we sail\"",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8), // Spacing between name and image,
                  // Image Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/taxi.jpeg', // Your image
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
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
                  Icons.logout,
                  color: Colors.white,
                ),
                tooltip: 'Actions',
                onPressed: () {
                  signUserOut();
                },
              ),
            ],
            expandedHeight: 350.0,
          ),
        ],
      ),
    );
  }
}
