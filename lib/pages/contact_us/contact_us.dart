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

  final ContactUsService contactService = ContactUsService();

  Future<void> sendMessage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userId') ?? '';

    var messageDetails = {
      'userId': userId,
      'phoneNumber': phoneNumberController.text,
      'emailAddress': emailAddressController.text,
      'message': messageController.text,
    };

    await contactService.sendMessage(messageDetails);
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
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: "Contact Number",
                  hintText: "Enter Contact Number",
                  prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailAddressController,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter Email Address",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await sendMessage();
                      // Optionally, display a success message or navigate to another page
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Message sent successfully!')),
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppDrawer()));
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
                  )
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
