import 'package:flutter/material.dart';
import 'package:stage_mgt_app/pages/auth_page.dart';
// import 'package:stage_mgt_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: Colors.blueAccent,
      )),
      home: const AuthPage(),
    );
  }
}
