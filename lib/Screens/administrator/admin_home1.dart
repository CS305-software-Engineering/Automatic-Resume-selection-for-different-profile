import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leso/Screens/Profile/profile.dart';
import '../book/components/body.dart';
import 'package:flutter/material.dart';
import '../Login/components/background.dart';
import '../Signup/signup_screen.dart';
import 'admin_homepage.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
var curr_doc;
const IconData domain_verification =
    IconData(0xe6ce, fontFamily: 'MaterialIcons');

class Book1 extends StatelessWidget {
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
              title: Text(
                "leso",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              backgroundColor: kPrimaryColor,
              bottom: TabBar(
                tabs: [
                  // Tab(icon: Icon(Icons.home), text: "Home"),
                  // Tab(icon: Icon(Icons.domain_verification), text: "Bookings"),
                  // Tab(icon: Icon(Icons.face), text: "Profile"),
                ],
              ),
            ),
          ),
          body:
              AdminBody(),

    // StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('current_doc')
    //         .snapshots(),
    //     builder: (BuildContext context1,
    //         AsyncSnapshot<QuerySnapshot> snapshot1) {
    //       if (!snapshot1.hasData) return Text('Loading...');
    //       List<QueryDocumentSnapshot> document11 = snapshot1.data.docs;
    //       //final int messageCount = snapshot1.data.docs.length;
    //       //curr_doc=document11['curr_doc'];
    //       snapshot1.data.docs.forEach((doc) {
    //         print("printing.....");
    //         print("curr_doc...");
    //         curr_doc = doc['curr_doc'];
    //         print(curr_doc);
    //       });
    //       //print(items22);
    //       //
    //       int postition=0;
    //       return StreamBuilder(
    //         stream: FirebaseFirestore.instance
    //             .collection('General Surgery')
    //             .doc(curr_doc)
    //             .collection('patients')
    //             .snapshots(),
    //         builder: (BuildContext context,
    //             AsyncSnapshot<QuerySnapshot> snapshot) {
    //           if (!snapshot.hasData) return Text('Loading...');
    //           List<QueryDocumentSnapshot> items22 = snapshot.data.docs;
    //           final int messageCount = snapshot.data.docs.length;
    //           print("curr_doc...");
    //           print(snapshot.data.docs);
    //
    //           return ListView.builder(
    //             itemCount: messageCount,
    //             itemBuilder: (context, position) {
    //               // snapshot.data.documents[index]['name'];
    //               // document['userRef'] exists here
    //               return Card(
    //
    //                 child: Padding(
    //
    //                   padding: const EdgeInsets.all(20.0),
    //                   child: Text("Department: "+snapshot.data.docs.elementAt(position).data()['department']+" \n Date :"+snapshot.data.docs.elementAt(position).data()['date'] ??
    //                       '<No message retrieved>'),
    //
    //
    //
    //
    //                 ),
    //               );
    //
    //
    //
    //
    //
    //
    //
    //             },
    //           );
    //         },
    //       );
    //     }),



        ),
      );
}
