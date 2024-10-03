import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/imageSquareTitle.dart';
import 'package:stage_mgt_app/components/my_button.dart';
import 'package:stage_mgt_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
            // forgot password
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
                ImageSquareTitle(imagePath: 'lib/images/icons8-google-240.png'),
                SizedBox(width: 25.0),
                ImageSquareTitle(imagePath: 'lib/images/icons8-apple-512.png'),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            // register now text

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member ?"),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Register now",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
