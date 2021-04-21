import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Success/success.dart';
import '../payment/HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../confirm_details/confirm_details.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';
  List<String> listValue = <String>[
    'One',
    'General Surgery',
    'Dermatology,Venereology and leprology',
    'Gynaecology',
    'Internal Medicine',
    'Obstetrics(For Pregnant Women)',
    'Ophthalmology(EYE)',
    'Oral Health Sciences Center(Dental)',
    'Orthopaedics',
    'Paediatrics Orthopaedics',
    'Paediatric Surgery',
    'Paediatric Medicine',
    'Plastic Surgery',
    'Urology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              margin:
                  const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select a Speciality',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                    Departmant = dropdownValue;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ConfirmPage();
                          //return AddUser("dd", "d", 19);
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
