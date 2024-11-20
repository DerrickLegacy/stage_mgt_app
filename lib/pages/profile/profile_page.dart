import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_mgt_app/backend/models/user.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';

class Account extends StatefulWidget {
  final bool showEdit;
  const Account({Key? key, required this.showEdit}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Widget drawTextInput(
      String labelText, TextEditingController controller, IconData iconType,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      readOnly: !widget.showEdit,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconType, color: Colors.blueAccent[700]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.deepPurple.shade50,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
    );
  }

  Future<void> _loadUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    if (userId != null) {
      UserService userService = UserService();
      try {
        User? user = await userService.getUserDetails(userId);
        if (user != null) {
          setState(() {
            _usernameController.text = user.username;
            _emailController.text = user.email;
            _phoneNumberController.text = user.phoneNumber;
            _addressController.text = user.address;
          });
        }
      } catch (e) {
        print("Error loading user details: $e");
      }
    }
  }

  Future<void> updateUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    if (userId != null) {
      UserService userService = UserService();
      Map<String, dynamic> userDetails = {
        "username": _usernameController.text,
        "phoneNumber": _phoneNumberController.text,
        "address": _addressController.text,
        "email": _emailController.text,
        if (_passwordController.text.isNotEmpty)
          "password": _passwordController.text,
      };

      try {
        await userService.updateUserAccount(userId, userDetails);
        print("User updated successfully!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Account(showEdit: false),
          ),
        );
      } catch (e) {
        print("Error updating user: $e");
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.blueAccent[700],
        actions: [
          if (!widget.showEdit)
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
                      if (widget.showEdit)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueAccent[700],
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
                  Text(
                    _usernameController.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    _emailController.text,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            drawTextInput("Full Name", _usernameController, Icons.person),
            const SizedBox(height: 16.0),
            drawTextInput("Email Address", _emailController, Icons.email),
            const SizedBox(height: 16.0),
            drawTextInput("Phone Number", _phoneNumberController, Icons.phone),
            const SizedBox(height: 16.0),
            drawTextInput("Address", _addressController, Icons.home),
            const SizedBox(height: 16.0),
            if (widget.showEdit) ...[
              drawTextInput("New Password", _passwordController, Icons.lock,
                  obscureText: true),
              const SizedBox(height: 16.0),
              drawTextInput(
                  "Confirm Password", _confirmPasswordController, Icons.lock,
                  obscureText: true),
              const SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: updateUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
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
