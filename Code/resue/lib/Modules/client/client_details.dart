import 'dart:convert';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resue/components/rounded_button.dart';
// ignore: must_be_immutable
class MybApp extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Job Description Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Job Description'),
            ),
            body: Center(child:Column(children:<Widget>[
              Container(
                margin: EdgeInsets.all(30),
                child: TextField(
                  controller: emailController,
                  minLines: 2,
                  maxLines: 20,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Give Job Description"),

                ),

              ),
              RoundedButton(
                  text: "Submit",
                  color: Colors.blue,
                  press: () async {
                    var url =
                Uri.parse(
                        'https://us-central1-resume-b5075.cloudfunctions.net/scheduleAppointment?name='+(emailController.text).toString());
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

                    print(emailController.text);
                  }
                  ),


            ]
            ))
        )
    );
  }
}