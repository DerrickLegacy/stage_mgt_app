import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/components/drawer.dart';
import 'package:stage_mgt_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final loggedInUser = "Derrick";

  void signUserOut(BuildContext context) {
    UserService service = UserService();
    service
        .logoutUser(); // Assuming this method properly logs out the user (e.g., clearing session, Firebase sign-out, etc.)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: const Color(0xFF30475E)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        ],
                      )
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
                  signUserOut(context);
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
