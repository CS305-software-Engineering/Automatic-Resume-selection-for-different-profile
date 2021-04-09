import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:resue/Modules/Signup/signup_screen.dart';
import 'package:resue/Modules/User_details/components/body.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:resue/components/already_have_an_account_acheck.dart';
import 'package:resue/components/rounded_button.dart';
import 'package:resue/components/rounded_input_field.dart';
import 'package:resue/components/rounded_password_field.dart';

import 'background.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              child:Image.asset('assest/main.png',height : size.height * 0.80,),
            ),
            Container(

              child:Column(

                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 50),
                  ),
              RoundedInputField(
              hintText: "Your Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value ;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),

            RoundedButton(
              text: "LOGIN",
              color: Colors.green,
              press: () async {
                try  {
                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  if(user!=null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FormScreen();
                        },
                      ),
                    );
                  }

                }
                catch(e) {
                  print(e);
                }
                print(email);
                print(password);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(

              press: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );

              },
            ),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
