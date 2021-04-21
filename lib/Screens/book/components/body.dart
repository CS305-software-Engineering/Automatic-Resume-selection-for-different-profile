import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';
import '../../Date/date.dart';
import '../../Login/components/background.dart';
import '../../Signup/signup_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email;
String password;

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 230.0),
              color: Colors.transparent,
              width: double.infinity,
              height: 60,
            ),
            RoundedButton(
              color: button,
              text: "Book Appointment",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              color: button,
              text: "View/Cancel Bookings",
              press: () {
                HttpClient()
                    .getUrl(Uri.parse(
                    'http://us-central1-first-outlet-307908.cloudfunctions.net/fun_caller?name=' +
                        currentFirebaseUser.email +
                        "|" +
                        DateTime.now().toString() +
                        "|" +
                        Departmant +
                        "|" +
                        "5"))
                    .then((request) => request.close()) // sends the request
                    .then((response) => response
                    .transform(Utf8Decoder())
                    .listen(print)); // transforms and prints the response
              },
            ),
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: 60,
              child: FlatButton(
                onPressed: () {},
                color: Colors.blueGrey,
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
