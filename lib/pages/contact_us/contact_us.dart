import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stage_mgt_app/backend/interfaces/contactus_controller.dart';
// import 'package:stage_mgt_app/backend/models/contactus.dart';
import 'package:stage_mgt_app/backend/services/contactus_service.dart';
import 'package:stage_mgt_app/components/drawer.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({Key? key}) : super(key: key);

  @override
  _ContactSupportState createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final ContactUsService contactService = ContactUsService();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  // Load user details (phone number and email) from SharedPreferences
  Future<void> _loadUserDetails() async {
    final String phoneNumber = await getUserProperty("phoneNumber");
    final String email = await getUserProperty("email");

    phoneNumberController.text = phoneNumber;
    emailAddressController.text = email;
  }

  Future<void> sendMessage() async {
    var messageDetails = {
      'userId': await getUserProperty("userId"),
      'phoneNumber': phoneNumberController.text,
      'emailAddress': emailAddressController.text,
      'message': messageController.text,
      'title': titleController.text,
      'isReadByAdmin': false,
      'username': await getUserProperty("username"),
    };

    await contactService.sendMessage(messageDetails);
  }

  Future<String> getUserProperty(String property) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(property) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Support"),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Phone Number Field (Read-Only)
              TextFormField(
                controller: phoneNumberController,
                enabled: false, // Make it read-only
                decoration: const InputDecoration(
                  labelText: "Contact Number",
                  hintText: "Your Contact Number",
                  prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Email Address Field (Read-Only)
              TextFormField(
                controller: emailAddressController,
                enabled: false, // Make it read-only
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "Your Email Address",
                  prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Title Field
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "Request Title",
                  prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Message Field
              TextField(
                controller: messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Message",
                  hintText: "Enter your message here...",
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 95.0),
                    child: Icon(Icons.message, color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await sendMessage();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Message sent successfully!')),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppDrawer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueAccent,
                      shadowColor: Colors.blueAccent,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    emailAddressController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
