//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:leso/Screens/Showapp/show_app.dart';
import '../Date/date.dart';
import '../Login/components/background.dart';
import '../variables.dart';
import '../Signup/signup_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../book/Book.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import '../book/Book.dart';
import 'package:uuid/uuid.dart';

var delay = 0;
String password;
CollectionReference users = FirebaseFirestore.instance.collection('user');
User currentFirebaseUser = FirebaseAuth.instance.currentUser;
TextEditingController emailController = new TextEditingController();
class AdminBody extends StatelessWidget {
  const AdminBody({
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
              margin: const EdgeInsets.only(top: 0.0),
              color: Colors.transparent,
              width: double.infinity,
              height: 60,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Delay (in minutes)",
              keyboardType: TextInputType.number,
              onChanged: (value) {
                delay = int.parse(value);
              },
            ),
            RoundedButton(
              color: button,
              text: "Confirm Delay",
              press: () {
                print(
                    'https://us-central1-leso123-8b446.cloudfunctions.net/date?name=' +
                        currentFirebaseUser.email +
                        "|" +
                        DateTime.now().toString() +
                        "|" +
                        Departmant +
                        "|" +
                        "5" +
                        "|" +
                        delay.toString());

                HttpClient()
                    .getUrl(Uri.parse(
                        'https://us-central1-leso123-8b446.cloudfunctions.net/date?name=' +
                            currentFirebaseUser.email +
                            "|" +
                            DateTime.now().toString() +
                            "|" +
                            Departmant +
                            "|" +
                            "5" +
                            delay.toString()))
                    .then((request) => request.close()) // sends the request
                    .then((response) => response
                        .transform(Utf8Decoder())
                        .listen(print)); // transforms and prints the response
                print(DateTime.now().toString());
              },
            ),
            RoundedButton(
              color: button,
              text: "Next Appointment",
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
                            "3"))
                    .then((request) => request.close()) // sends the request
                    .then((response) => response
                        .transform(Utf8Decoder())
                        .listen(print)); // transforms and prints the response
                print(DateTime.now().toString());
              },
            ),
            RoundedButton(
              color: button,
              text: "Show Appointments",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppointmentPage();
                      //return AddUser("dd", "d", 19);
                    },
                  ),
                );

              },
            ),



           TextField(
              controller: emailController,
              obscureText: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER YOUR EMAIL',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
