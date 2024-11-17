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
              expandedHeight: 230,
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
            // Add other Sliver widgets here as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
