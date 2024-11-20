import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/models/contactus.dart';
import 'package:stage_mgt_app/components/request_notification_card.dart';
import 'package:stage_mgt_app/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stage_mgt_app/backend/services/contactus_service.dart'; // Import the service

class ClientSupportRequests extends StatefulWidget {
  const ClientSupportRequests({super.key});

  @override
  _ClientSupportRequestsState createState() => _ClientSupportRequestsState();
}

class _ClientSupportRequestsState extends State<ClientSupportRequests> {
  final ContactUsService _contactUsService = ContactUsService();
  late Future<List<ContactUs>> _clientRequests;

  @override
  void initState() {
    super.initState();
    _clientRequests = _contactUsService.fetchAllRequests();
  }

  // Method to handle email click
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Support RequestResponse'},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email client')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Support Requests'),
        backgroundColor: Colors.blueAccent[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: FutureBuilder<List<ContactUs>>(
        future: _clientRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No requests found.'));
          } else {
            List<ContactUs> requests = snapshot.data!;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return ClientSupportRequestsNotificationCard(
                  name: request.username,
                  title: request.title, // Correctly passing title
                  email: request.emailAddress,
                  message: request.message,
                  isReadByAdmin:
                      request.isReadByAdmin, // Passing isReadByAdmin flag
                  onViewPressed: () {
                    _viewMessage(context, request.message);
                  },
                  onMarkAsReadPressed: () {
                    _markAsRead(request.docId);
                  },
                  onEmailPressed: () {
                    _launchEmail(request.emailAddress);
                  },
                );
              },
            );
          }
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

  void _markAsRead(String docId) async {
    await _contactUsService.markAsRead(docId); // Mark as read in Firestore
    setState(() {
      _clientRequests =
          _contactUsService.fetchAllRequests(); // Refresh the request list
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request marked as read')),
    );
  }
}
