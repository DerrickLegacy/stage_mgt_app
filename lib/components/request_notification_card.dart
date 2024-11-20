import 'package:flutter/material.dart';

class ClientSupportRequestsNotificationCard extends StatelessWidget {
  final String name;
  final String email;
  final String message;
  final String title;
  final bool isReadByAdmin; // Added flag for read status
  final VoidCallback onViewPressed;
  final VoidCallback onMarkAsReadPressed;
  final VoidCallback onEmailPressed;

  const ClientSupportRequestsNotificationCard({
    super.key,
    required this.name,
    required this.email,
    required this.message,
    required this.onViewPressed,
    required this.onMarkAsReadPressed,
    required this.onEmailPressed,
    required this.title,
    required this.isReadByAdmin, // Initialize flag here
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      color: isReadByAdmin
          ? Colors.white
          : Colors.blue[100], // Set background color based on read status
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: $title', // Display title correctly
              ),
              Text(
                'Message: ${message.length > 50 ? message.substring(0, 50) + '...' : message}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              GestureDetector(
                onTap: onEmailPressed, // Email click handler
                child: Text(
                  'Email: $email',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'view') {
                onViewPressed();
              } else if (value == 'markAsRead') {
                onMarkAsReadPressed();
              } else if (value == 'email') {
                onEmailPressed(); // Call email action
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'email',
                  child: Text('Send Email Reply'),
                ),
                const PopupMenuItem<String>(
                  value: 'markAsRead',
                  child: Text('Mark as Read'),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
