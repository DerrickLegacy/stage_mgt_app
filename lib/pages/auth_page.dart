import 'package:flutter/material.dart';
import 'package:stage_mgt_app/backend/services/user_service.dart';
import 'package:stage_mgt_app/pages/home_page.dart';
import 'package:stage_mgt_app/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: UserService().checkUserSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data == true) {
            return HomePage(); // User is logged in, show HomePage
          } else {
            return const LoginPage(); // No user session, show LoginPage
          }
        },
      ),
    );
  }
}
