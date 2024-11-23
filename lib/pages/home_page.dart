import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/components/drawer.dart';
import 'package:stage_mgt_app/components/loyaltycard.dart';
import 'package:stage_mgt_app/components/remindar_c.dart';
import 'package:stage_mgt_app/components/service_card.dart';
import 'package:stage_mgt_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String loggedInUser = "Derrick";
  bool isDarkMode = false; // Track dark mode state

  void signUserOut(BuildContext context) {
    UserService service = UserService();

    service.logoutUser(); // Logout logic
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
        drawer: const AppDrawer(),
        body: Container(
          color: Colors.blueAccent.withOpacity(0.1),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(
                    "Taxi App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                    ),
                  ),
                  background: Image.asset(
                    'lib/images/tobias-a-muller-rOLKpojjbGM-unsplash.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                expandedHeight: 230.0,
                backgroundColor: Colors.blueAccent[400],
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.face),
                    color: Colors.white,
                    tooltip: 'My Profile',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    tooltip: 'Log Out Icon',
                    onPressed: () {
                      signUserOut(context);
                    },
                  ),
                ],
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: toggleDarkMode, // Toggle theme on button press
          child: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        ),
      ),
    );
  }
}
