import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/imageSquareTitle.dart';
import 'package:stage_mgt_app/components/my_button.dart';
import 'package:stage_mgt_app/components/my_textfield.dart';
import 'package:stage_mgt_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

void registerUser() {}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                onTap: () => registerUser(),
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
