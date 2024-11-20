// Notification Card Widget
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/models/notification.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDelete;
  final VoidCallback onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDelete,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor:
              notification.isNew ? Colors.blueAccent : Colors.grey.shade300,
          child: Icon(
            notification.isNew
                ? Icons.notifications_active
                : Icons.notifications_none,
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: notification.isNew ? Colors.blueAccent : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            notification.message,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        trailing: PopupMenuButton<String>(
          enableFeedback: true,
          // style: ButtonStyle(shadowColor: colors.blue),
          tooltip: "Notification Actions",
          surfaceTintColor: Colors.blue,
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            }
            if (value == 'mark as read') {
              onMarkAsRead();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
            const PopupMenuItem(
              value: 'mark as read',
              child: Text('Mark as read'),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
