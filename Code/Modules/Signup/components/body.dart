import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resue/Modules/Login/login_screen.dart';
import 'package:resue/Modules/Signup/components/social_icon.dart';
import 'package:resue/components/already_have_an_account_acheck.dart';
import 'package:resue/components/rounded_button.dart';
import 'package:resue/components/rounded_input_field.dart';
import 'package:resue/components/rounded_password_field.dart';

import 'background.dart';
import 'or_divider.dart';


String email;
String password;
class Body extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 50),
            ),
            SizedBox(height: size.height * 0.03),

            RoundedInputField(
              hintText: "Your Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),

            RoundedButton(
              text: "SIGNUP",
              color: Colors.green,
              press: () async {
                print(email);
                print(password);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(newUser!=null){

                  }


                }
                catch(e){
                  print(e);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
