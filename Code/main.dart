import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Modules/Login/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'User';
    List<String> listValue = <String>['User', 'Admin'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'leso',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}
