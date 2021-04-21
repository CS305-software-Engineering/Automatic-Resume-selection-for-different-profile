import 'dart:convert';
import 'package:flutter/material.dart';
import '../payment/HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'admin_login.dart';
import 'login_screen.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'User';
  List<String> listValue = <String>['User', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Account Type',
                    style: TextStyle(
                      fontSize: 20.0,
                      //color: Colors.black54,
                    ),
                  )),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,

                //dropdownColor: Colors.,
                style: TextStyle(color: Colors.deepPurple),
                //padding: const EdgeInsets.all(15.0),
                underline: Container(
                  height: 2,
                  //width: 30,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: listValue.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Center(
              child: RoundedButton(
                  text: "Next",
                  color: button,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (dropdownValue == 'User') {
                            return LoginScreen();
                          } else {
                            return AdminLoginScreen();
                          }
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
