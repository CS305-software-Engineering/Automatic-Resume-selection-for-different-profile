import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Screens/Date/date.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Showapp/show_app.dart';
import 'constants.dart';
import 'Screens/Login/select_type.dart';

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
    precacheImage(AssetImage("assets/images/signup.jpg"), context);
    precacheImage(AssetImage("assets/images/login.jpg"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'leso',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyStatefulWidget(),
    );
  }
}
