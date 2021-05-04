import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resue/Modules/Home/home_screen.dart';
import 'package:resue/Modules/Signup/signup_screen.dart';
import 'package:resue/Modules/User_details/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:resue/Modules/admin_login/login_screen.dart';
import 'package:resue/Modules/client/client_details.dart';

import 'package:resue/Modules/listofavilablejobs/Available_jobs.dart';
import 'package:resue/Modules/result/result.dart';
import 'package:resue/test.dart';

import 'Modules/Login/login_screen.dart';
import 'Modules/listofjobs/listofjobs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home:AdminLoginScreen()
    );
  }
}
