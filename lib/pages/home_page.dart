import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_mgt_app/components/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final loggedInUser = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Name"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text("User is logged in as ${loggedInUser.email}"),
      ),
    );
  }
}
