import 'package:flutter/material.dart';
import 'package:stage_mgt_app/pages/auth_page.dart';
// import 'package:stage_mgt_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stage_mgt_app/backend/services/notification_service.dart';

import 'firebase_options.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Printing a message whenever the task is executed
    print("Executing task: $task");

    // Call the actual task function here
    await NotificationService().createBookingReminder();

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize WorkManager in main.dart
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Register the background task
  await Workmanager().registerPeriodicTask(
    "dailyBookingCheck",
    "dailyBookingTask",
    frequency: const Duration(seconds: 10),
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
