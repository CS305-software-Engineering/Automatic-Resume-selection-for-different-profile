import 'dart:convert';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resue/Home_client/Components/app_bar.dart';
import 'package:resue/Modules/client_home/client_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resue/Modules/listofjobs/listofjobs.dart';
import 'package:resue/components/rounded_button.dart';
// ignore: must_be_immutable
class MybApp extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController emailController2 = new TextEditingController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Job Description Page',
        home: Scaffold(

            body: Center(
                child: Column(children: <Widget>[
                  Expanded(flex:15,child: CustomAppBar()),

                Expanded(flex:30,child:Container(
                    margin: EdgeInsets.all(100),
                    child: TextField(
                      controller : emailController,
                      minLines: 2,
                      maxLines: 20,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Give Job Description"),
                    ),
                  ),
                ),
                Expanded(flex:30,child: Container(
                    margin: EdgeInsets.all(100),
                    child: TextField(
                      controller : emailController2,
                      minLines: 2,
                      maxLines: 20,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Job details"),
                    ),
                  ),),

                  RoundedButton(
                      text: "Submit",
                      color: Colors.blue,
                      press: () async {
                        print('https://us-central1-resume-b5075.cloudfunctions.net/scheduleAppointment?name='+'|'+FirebaseAuth.instance.currentUser.email+'|'+(emailController.text).toString()+'|'+(emailController2.text).toString());

                        var url =
                        Uri.parse(
                            'https://us-central1-resume-b5075.cloudfunctions.net/scheduleAppointment?name='+FirebaseAuth.instance.currentUser.email+'|'+(emailController.text).toString()+'|'+(emailController2.text).toString());
                        // Await the http get response, then decode the json-formatted response.
                        var response = await http.post(url,headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                          body: jsonEncode(<String, String>{
                            'title': emailController.text ,
                          }),);
                        if (response.statusCode == 200) {
                          var jsonResponse = convert.jsonDecode(response.body);
                          var itemCount = jsonResponse['totalItems'];
                          print('Number of books about http: $itemCount.');
                        } else {
                          print('Request failed with status: ${response.statusCode}.');
                        }


                                      Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AppBarPage()));
                      }
                  ),


                ]))));

  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 60);
    var controlPoint = Offset(60, size.height);

    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Path path = Path();
    // path.moveTo(size.width/2,0);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height/4);
    // path.cubicTo(size.width*0.55, size.height*0.16, size.width*0.85, size.height*0.05, size.width/2, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}