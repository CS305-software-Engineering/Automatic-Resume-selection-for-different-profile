import 'package:flutter/material.dart';
import '../Details/dd.dart';
import '../Screens/confirm_details/body.dart';
import 'package:flutter/material.dart';
import '../Screens/Login/components/background.dart';
import '../Screens/Signup/signup_screen.dart';
import '../Screens/book/Book.dart';
import '../components/already_have_an_account_acheck.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Screens/book/Book.dart';
import 'package:firebase_auth/firebase_auth.dart';
String curr_d;

const IconData domain_verification =
    IconData(0xe6ce, fontFamily: 'MaterialIcons');
StreamSubscription periodicSub;

Timer _timer;
int _start = int.parse(Position) ;


class SuccessBody extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SuccessBody> {
  @override
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  User currentFirebaseUser = FirebaseAuth.instance.currentUser;
  void startTimer() {
    setState(() {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {

          print(_start);
          print(int.parse(Position));

        },
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              centerTitle: true,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(100.0))),
              title: Text(
                "leso",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              backgroundColor: kPrimaryColor,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.domain_verification), text: "Bookings"),
                  Tab(icon: Icon(Icons.face), text: "Profile"),
                ],
              ),
            ),
          ),
          body: Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 0.0),
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      "Appointment Booked Successfully..",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  RoundedButton(
                    color: button,
                    text: "Check Queue Position",
                    press: () {
                      startTimer();
                    },
                    //child: Text("Queue Position"),
                  ),
                  //Text("$_start")
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),


                             Text(
                              "Current Queue Position: " + "$Position",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              textAlign: TextAlign.center,
                            )



                ],
              ),
            ),
          ),
        ),
      );
}
