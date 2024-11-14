import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Number of notifications
        itemBuilder: (context, index) {
          return NotificationCard(
            title: "Ride Update",
            message: "Your driver is 5 minutes away. Get ready!",
            time: "${index + 1}h ago",
            isNew: index % 2 == 0, // Alternate between new and read
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isNew;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    this.isNew = false,
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
          backgroundColor: isNew ? Colors.blueAccent : Colors.grey.shade300,
          child: Icon(
            isNew ? Icons.notifications_active : Icons.notifications_none,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isNew ? Colors.blueAccent : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        trailing: Text(
          time,
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          // Handle notification tap
        },
      ),
    );
  }
}
