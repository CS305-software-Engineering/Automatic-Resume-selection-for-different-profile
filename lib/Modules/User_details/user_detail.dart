import 'package:flutter/material.dart';
import 'package:resue/Modules/Job_details/jon_details.dart';
import 'package:resue/Modules/Login/login_screen.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:resue/Modules/client/client_details.dart';


import 'package:resue/components/SplitWidget.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: Container(
          child: SplitWidget(
            childFirst: job_details(),
            childSecond: FormScreen(),
          ),
        ));
  }


}
