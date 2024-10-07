import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(child: Text('User is logged in')));
  }
}
