import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/components/my_button.dart';
import 'package:stage_mgt_app/components/my_textfield.dart';
import 'package:stage_mgt_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    UserService userService = UserService();
    Map<String, dynamic> userDetails = {
      "username": userNameController.text,
      "phoneNumber": phoneNumberController.text,
      "address": addressController.text,
      "password": passwordController.text,
      "email": emailController.text,
      // Make sure to include other fields if necessary
    };

    // Call registerUser on StageBookingService with the userDetails map
    try {
      await userService.registerUser(userDetails);
      print("User registered successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print("Error registering user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70.0),
              // Logo
              const Icon(
                Icons.person_add,
                size: 100,
              ),
              const SizedBox(height: 60.0),

              // Welcome Message
              Text(
                'Thank you for choosing to trust us!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25.0),

              // Username TextField
              MyTextField(
                controller: userNameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 25.0),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 25.0),

              // Phone Number TextField
              MyTextField(
                controller: phoneNumberController,
                hintText: 'Phone Number',
                obscureText: false,
              ),
              const SizedBox(height: 25.0),

              // Address TextField
              MyTextField(
                controller: addressController,
                hintText: 'Address',
                obscureText: false,
              ),
              const SizedBox(height: 25.0),

              // Password TextField
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25.0),

              // Confirm Password TextField
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 40.0),

              // Register Button
              MyButton(
                onTap: registerUser,
                title: 'Register',
              ),
              const SizedBox(height: 40.0),

              // Navigate to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
