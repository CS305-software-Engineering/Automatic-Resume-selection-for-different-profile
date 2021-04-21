import 'package:flutter/material.dart';
import '../confirm_details/body.dart';
import 'package:flutter/material.dart';
import '../Login/components/background.dart';
import '../Signup/signup_screen.dart';
import '../book/Book.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'department.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';

const IconData domain_verification =
    IconData(0xe6ce, fontFamily: 'MaterialIcons');

class LayoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 0,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              centerTitle: true,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100.0),
                      bottomRight: Radius.circular(100.0))),

              // title: Text(
              //   "leso",
              //   style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 25),
              // ),

              backgroundColor: kPrimaryColor,
              // bottom: TabBar(
              //   tabs:[
              //     Tab(icon:Icon(Icons.home),text:"Home"),
              //     Tab(icon:Icon(Icons.domain_verification),text:"Bookings"),
              //     Tab(icon:Icon(Icons.face),text:"Profile"),
              //   ],
              // ),
            ),
          ),
          body: MyStatefulWidget(),
        ),
      );
}
