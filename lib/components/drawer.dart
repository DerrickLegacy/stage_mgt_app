import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/user.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/pages/booking/booking_main.dart';
import 'package:stage_mgt_app/pages/contact_us/contact_us.dart';
import 'package:stage_mgt_app/pages/loyalty_points/loyalty_points.dart';
import 'package:stage_mgt_app/pages/notification/notification_page.dart';
import 'package:stage_mgt_app/pages/profile/profile_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String loggedInUser = "Loading..."; // Placeholder text for username
  String userEmail = "Loading..."; // Placeholder text for email

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    if (userId != null) {
      UserService userService = UserService();
      try {
        User? useradd = await userService.getUserDetails(userId);
        setState(() {
          loggedInUser = useradd!.username;
          userEmail = useradd.email;
        });
        print(loggedInUser);
      } catch (e) {
        setState(() {
          loggedInUser = 'Error loading user';
          userEmail = 'No email available';
        });
      }
    } else {
      setState(() {
        loggedInUser = 'Guest';
        userEmail = 'No email available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              loggedInUser, // Display dynamic name or fallback
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              userEmail, // Display dynamic email or fallback
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
                  Colors.blue,
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
        page: const Account(
          showEdit: false,
        ),
      ),
      buildDrawerItem(
        context,
        icon: Icons.exit_to_app,
        text: 'Exit',
        onTap: () {
          Navigator.pop(context); // Close the drawer
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
        color: Colors.lightBlue[700],
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
