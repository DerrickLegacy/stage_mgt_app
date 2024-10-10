import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/imageSquareTitle.dart';
import 'package:stage_mgt_app/components/my_button.dart';
import 'package:stage_mgt_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  // Generic function to show a reusable dialog
  void showCustomDialog({
    required String title,
    required String message,
    Color titleColor = Colors.red,
    Color backgroundColor = Colors.white,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Specific function to show "Invalid email or password" dialog
  void wrongEmailOrPassword() {
    showCustomDialog(
      title: 'Error',
      message: 'Invalid email or password',
      titleColor: Colors.red,
      backgroundColor: Colors.grey[200]!,
    );
  }

  // Function to handle user sign-in
  void signUserIn() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context); // Dismiss the loading indicator
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Dismiss the loading indicator

      // Show appropriate error message
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        wrongEmailOrPassword();
      } else {
        showCustomDialog(
          title: 'Authentication Error',
          message: e.message ?? 'An unknown error occurred.',
        );
      }
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
              const Icon(Icons.lock, size: 100),
              const SizedBox(height: 60.0),

              // Welcome message
              Text(
                'Welcome back, you have been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25.0),

              // Username text field
              MyTextField(
                controller: userNameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 25.0),

              // Password text field
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10.0),

              // Forgot password text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),

              // Sign-in button
              MyButton(
                onTap: signUserIn,
                text: 'Sign In',
              ),
              const SizedBox(height: 90.0),

              // "Or Continue With" divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or Continue With",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),

              // Social login buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageSquareTitle(
                      imagePath: 'lib/images/icons8-google-240.png'),
                  SizedBox(width: 25.0),
                  ImageSquareTitle(
                      imagePath: 'lib/images/icons8-apple-512.png'),
                ],
              ),
              const SizedBox(height: 40.0),

              // Register now text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member?"),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to registration screen
                    },
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
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
