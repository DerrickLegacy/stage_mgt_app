import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/imageSquareTitle.dart';
import 'package:stage_mgt_app/components/my_button.dart';
import 'package:stage_mgt_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void wrongEmailOrPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.black,
              ),
              SizedBox(width: 10.0),
              Text(
                'Login Failed',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Invalid email or password. Please try again.',
            style: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void signUserIn() async {
    // Show the login loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userNameController.text,
        password: passwordController.text,
      );
      Navigator.pop(context); // This removes the loading dialog on success
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // This removes the loading dialog on error

      if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        wrongEmailOrPassword();
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
              const SizedBox(
                height: 70.0,
              ),
              // Logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 60.0,
              ),
              // Welcome back, you have been missed!
              Text(
                'welcome back, you have been missed !',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              // Username textfield
              MyTextField(
                controller: userNameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(
                height: 25.0,
              ),
              // password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              // forgot passwordx
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'Forgot Password ?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ]),
              ),
              const SizedBox(
                height: 40.0,
              ),
              // sign in button
              MyButton(
                onTap: signUserIn,
              ),
              const SizedBox(
                height: 90.0,
              ),
              //continue with
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
              const SizedBox(
                height: 50.0,
              ),
              // Google sign in
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
              const SizedBox(
                height: 40.0,
              ),
              // register now text

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member ?"),
                  const SizedBox(
                    width: 4.0,
                  ),
                  GestureDetector(
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
