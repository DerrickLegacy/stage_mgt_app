import 'package:flutter/material.dart';

class ClientSupportRequests extends StatelessWidget {
  const ClientSupportRequests({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data representing support requests
    List<Map<String, String>> requests = [
      {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'message':
            'This is a test message from John. I am experiencing issues with my account and would like some help with resetting my password. Please get back to me at your earliest convenience.'
      },
      {
        'name': 'Jane Smith',
        'email': 'jane.smith@example.com',
        'message':
            'I need assistance with my subscription. I was charged twice this month, and I would like to get a refund for the extra charge.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Support Requests'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          var request = requests[index];
          return ClientSupportRequestsNotificationCard(
            name: request['name']!,
            email: request['email']!,
            message: request['message']!,
            onViewPressed: () {
              // Handle "view" button press
              _viewMessage(context, request['message']!);
            },
            onMarkAsReadPressed: () {
              // Handle "mark as read" button press
              _markAsRead(context);
            },
          );
        },
      ),
    );
  }

  void _viewMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Full Message'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _markAsRead(BuildContext context) {
    // Handle marking the request as read (could trigger an API call or update state)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request marked as read')),
    );
  }
}

class ClientSupportRequestsNotificationCard extends StatelessWidget {
  final String name;
  final String email;
  final String message;
  final VoidCallback onViewPressed;
  final VoidCallback onMarkAsReadPressed;

  const ClientSupportRequestsNotificationCard({
    super.key,
    required this.name,
    required this.email,
    required this.message,
    required this.onViewPressed,
    required this.onMarkAsReadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: $email'),
              Text(
                'Message: ${message.length > 50 ? message.substring(0, 50) + '...' : message}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'view') {
                onViewPressed();
              } else if (value == 'markAsRead') {
                onMarkAsReadPressed();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'view',
                  child: Text('View'),
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
