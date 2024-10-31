import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final bool showEdit;
  const Account({super.key, required this.showEdit});

  Widget drawTextInput(String labelText, IconData iconType,
      {bool obscureText = false}) {
    return TextFormField(
      readOnly:
          !showEdit, // Makes the field non-editable but still allows selection
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconType, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.deepPurple.shade50,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
      enabled: showEdit, // Disables the field entirely when not in edit mode
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.deepPurple,
        actions: [
          if (!showEdit)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Account(showEdit: true),
                  ),
                );
              },
              icon: const Icon(Icons.edit_note_outlined),
              tooltip: "Edit Profile",
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  // Profile Picture
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'lib/images/taxi.jpeg',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (showEdit)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                              onPressed: () {
                                // Handle profile picture change
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    "Ahaabwe Derrick",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    "derrick@gmail.com",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            drawTextInput("Full Name", Icons.person),
            const SizedBox(height: 16.0),
            drawTextInput("Email Address", Icons.email),
            const SizedBox(height: 16.0),
            drawTextInput("Phone Number", Icons.phone),
            const SizedBox(height: 16.0),
            drawTextInput("Address", Icons.home),
            const SizedBox(height: 16.0),
            if (showEdit) ...[
              drawTextInput("New Password", Icons.lock, obscureText: true),
              const SizedBox(height: 16.0),
              drawTextInput("Confirm Password", Icons.lock, obscureText: true),
              const SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5.0,
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
