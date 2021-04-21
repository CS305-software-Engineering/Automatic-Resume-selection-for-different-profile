import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Screens/book/Book.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
//import 'package:axios/axios.dart';

StreamSubscription periodicSub;

Timer _timer;
int _start = 0;

class MyDemo extends StatefulWidget {
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  @override
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  User currentFirebaseUser = FirebaseAuth.instance.currentUser;
  void startTimer() {
    setState(() {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          HttpClient()
              .getUrl(Uri.parse(
                  'https://us-central1-leso123-8b446.cloudfunctions.net/date?name=' +
                      currentFirebaseUser.email +
                      "|" +
                      Date +
                      "|" +
                      Departmant +
                      "|" +
                      "3"))
              .then((request) => request.close()) // sends the request
              .then((response) =>
                  response.transform(Utf8Decoder()).listen((data) {
                    setState(() {
                      _start = int.parse(data);
                    });
                    print(_start);
                  })); // transforms and prints the response
          print(
              'https://us-central1-leso123-8b446.cloudfunctions.net/date?name=' +
                  currentFirebaseUser.email +
                  "|" +
                  Date +
                  "|" +
                  Departmant +
                  "|" +
                  "3");
        },
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Timer test")),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              startTimer();
            },
            child: Text("start"),
          ),
          Text("$_start")
        ],
      ),
    );
  }
}
