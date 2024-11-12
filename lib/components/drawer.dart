import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stage_mgt_app/pages/booking/booking_main.dart';
import 'package:stage_mgt_app/pages/contact_us/contact_us.dart';
import 'package:stage_mgt_app/pages/loyalty_points/loyalty_points.dart';
import 'package:stage_mgt_app/pages/notification/notification_page.dart';
import 'package:stage_mgt_app/pages/profile/profile_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  final loggedInUser = "Derrick";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "AHAABWE DERRICK", // Display name or fallback
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              loggedInUser, // User's email or fallback
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'lib/images/icons8-google-240.png', // Default image
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF30475E),
                  Color(0xffd1c4e9),
                ],
                stops: [0.0, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Drawer items list
          ...buildDrawerItems(context),
        ],
      ),
    );
  }

  // Method to create and return the list of drawer items
  List<Widget> buildDrawerItems(BuildContext context) {
    return [
      buildDrawerItem(
        context,
        icon: Icons.home,
        text: 'Bookings',
        page: const Booking(),
      ),
      buildDrawerItem(
        context,
        icon: Icons.card_giftcard,
        text: 'Loyalty Points',
        page: const LoyaltyPoints(),
      ),
      buildDrawerItem(
        context,
        icon: Icons.notifications_active,
        text: 'Notifications',
        page: const NotificationPage(),
      ),
      const Divider(),
      buildDrawerItem(
        context,
        icon: Icons.contact_support,
        text: 'Support Contact Us',
        page: const ContactSupport(),
      ),
      const Divider(),
      buildDrawerItem(
        context,
        icon: Icons.account_circle,
        text: 'Account',
        page: const Account(showEdit: false),
      ),
      buildDrawerItem(
        context,
        icon: Icons.exit_to_app,
        text: 'Exit',
        onTap: () {
          // Handle exit logic here
          Navigator.pop(context); // Close drawer or handle any other logic
        },
      ),
    ];
  }

  // Helper method to build individual drawer items
  Widget buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      Widget? page,
      Function()? onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap ??
          () {
            if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
    );
  }
}
