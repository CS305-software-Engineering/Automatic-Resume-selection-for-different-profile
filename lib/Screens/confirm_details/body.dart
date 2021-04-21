import 'package:flutter/material.dart';
import '../Date/date.dart';
import '../Login/components/background.dart';
import '../../Success/Success_page.dart';
import '../../Success/success.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email;
String password;

class ConfirmBody extends StatelessWidget {
  const ConfirmBody({
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
              height: 10,
            ),
            Text(
              "Department: " + Departmant,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Date: " + Date,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              color: button,
              text: "Confirm Details",
              press: () {
                addUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SuccessBody();
                    },
                  ),
                );
              },
            ),
            //SizedBox(height: size.height * 0.03),
            // RoundedButton(
            //   color: button,
            //   text: "View/Cancel Bookings",
            //   press: () {},
            // ),
            // Container(
            //   color: Colors.transparent,
            //   width: double.infinity,
            //   height: 60,
            //   child: FlatButton(
            //     onPressed: () {},
            //     color: Colors.blueGrey,
            //     child: Text(
            //       "Contact Us",
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 22.0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
