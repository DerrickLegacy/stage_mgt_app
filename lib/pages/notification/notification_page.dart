import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/notification.dart';
import 'package:stage_mgt_app/backend/services/notification_service.dart';
import 'package:stage_mgt_app/components/notification_card.dart';

// Notification Page
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> _notificationsFuture;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _getUserNotifications();
  }

  // Fetch a user property from SharedPreferences
  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

  // Fetch notifications for the current user
  Future<List<NotificationModel>> _getUserNotifications() async {
    final String userId = await getUserProperty('userId');
    return _notificationService.getNotifications(userId);
  }

  Future<void> markRead(String docId) async {
    if (docId.isEmpty) {
      print("Error: docId is empty");
      return;
    }

    print("Marking: $docId as read");
    try {
      await _notificationService.markAsRead(docId);
      setState(() {
        _notificationsFuture = _getUserNotifications();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Notification Marked as Read successfully")));
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  // Delete a specific notification by ID
  Future<void> deleteNotification(String docId) async {
    if (docId.isEmpty) {
      print("Error: docId is empty");
      return;
    }

    print("Deleting notification with docId: $docId");
    try {
      await _notificationService.deleteNotification(docId);
      setState(() {
        _notificationsFuture = _getUserNotifications();
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Notification Deleted successfully")));
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading notifications"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications available"));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return NotificationCard(
                notification: notification,
                onDelete: () => deleteNotification(notification.docId),
                onMarkAsRead: () => markRead(notification.docId),
              );
            },
          );
        },
      ),
    );
  }
}
