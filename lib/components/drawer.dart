import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/contactus.dart';
import 'package:stage_mgt_app/backend/models/notification.dart';
import 'package:stage_mgt_app/backend/models/user.dart';
import 'package:stage_mgt_app/backend/services/contactus_service.dart';
import 'package:stage_mgt_app/backend/services/notification_service.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/pages/booking/add_booking.dart';
import 'package:stage_mgt_app/pages/booking/history_page.dart';
import 'package:stage_mgt_app/pages/booking/upcoming_booking.dart';
import 'package:stage_mgt_app/pages/contact_us/contact_us.dart';
import 'package:stage_mgt_app/pages/loyalty_points/loyalty_points.dart';
import 'package:stage_mgt_app/pages/management/support_requests.dart';
import 'package:stage_mgt_app/pages/notification/notification_page.dart';
import 'package:stage_mgt_app/pages/profile/profile_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String loggedInUser = "Loading...";
  String userEmail = "Loading...";
  int notificationCount = 0;
  int clientRequestCount = 0;

  final NotificationService _notificationService = NotificationService();
  final ContactUsService _contactUsService = ContactUsService();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    _loadNotificationCount();
    _loadClientRequestCount(); // Fetch client requests count
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

  Future<void> _loadNotificationCount() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String userId = pref.getString('userId') ?? '';

    if (userId.isNotEmpty) {
      try {
        List<NotificationModel> notifications =
            await _notificationService.getNotifications(userId);

        setState(() {
          notificationCount =
              notifications.where((notification) => notification.isNew).length;
        });
      } catch (e) {
        setState(() {
          notificationCount = 0;
        });
      }
    }
  }

  Future<void> _loadClientRequestCount() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String userId = pref.getString('userId') ?? '';

    if (userId.isNotEmpty) {
      try {
        List<ContactUs> clientRequests =
            await _contactUsService.fetchAllRequests();

        setState(() {
          clientRequestCount = clientRequests
              .where((clientRequest) => !clientRequest.isReadByAdmin)
              .length; // Count only unread requests
        });
      } catch (e) {
        setState(() {
          clientRequestCount = 0; // Default to 0 if an error occurs
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent.withOpacity(0.1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                loggedInUser,
                style: const TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                userEmail,
                style: const TextStyle(color: Colors.black),
              ),
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
            ...buildDrawerItems(context),
          ],
        ),
      ),
    );
  }

  List<Widget> buildDrawerItems(BuildContext context) {
    return [
      ExpansionTile(
        leading: Icon(
          Icons.home,
          color: Colors.lightBlue[700],
        ),
        title: const Text(
          'Bookings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          buildDrawerSubItem(
            context,
            icon: Icons.flight_takeoff_outlined,
            text: 'Upcoming Bookings',
            page: const UpcomingBookings(),
          ),
          buildDrawerSubItem(
            context,
            icon: Icons.add,
            text: 'New Booking',
            page: const CreateBooking(),
          ),
          buildDrawerSubItem(
            context,
            icon: Icons.history,
            text: 'Booking History',
            page: const BookingHistoryPage(),
          )
        ],
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
        text:
            'Notifications (${notificationCount > 0 ? notificationCount : 0})',
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
      ExpansionTile(
        leading: Icon(
          Icons.mark_unread_chat_alt,
          color: Colors.lightBlue[700],
        ),
        title: const Text(
          'Management',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          buildDrawerSubItem(
            context,
            icon: Icons.contact_support_outlined,
            text:
                'Support Requests (${clientRequestCount > 0 ? clientRequestCount : 0})',
            page: const ClientSupportRequests(),
          ),
          buildDrawerSubItem(
            context,
            icon: Icons.add,
            text: 'Add Vehicle',
            page: const CreateBooking(),
          ),
        ],
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
          Navigator.pop(context);
        },
      ),
    ];
  }

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

  Widget buildDrawerSubItem(BuildContext context,
      {required IconData icon, required String text, required Widget page}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.lightBlue[500],
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
