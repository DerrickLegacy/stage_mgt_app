import 'package:flutter/material.dart';
import 'package:stage_mgt_app/pages/booking/booking_main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  void handleSideBarDrawerOption() {
    // print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text("Derrick"),
          accountEmail: const Text("derrick@gmail.com"),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.asset(
                'lib/images/icons8-google-240.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Bookings'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Booking()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Loyalty Points'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.notifications_active),
          title: const Text('Notifications'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.format_color_fill),
          title: const Text('Profile'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Support Contact Us'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app_outlined),
          title: const Text('Exit'),
          onTap: () {},
        ),
      ],
    ));
  }
}
