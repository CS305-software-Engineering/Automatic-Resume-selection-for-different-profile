import 'package:flutter/material.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';
import '../Profile/profile.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';
import '../Login/components/background.dart';
import '../Login/admin_login.dart';
import '../Signup/signup_screen.dart';
import 'Book.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const IconData domain_verification =
IconData(0xe6ce, fontFamily: 'MaterialIcons');
var curr_doc;
var queue_num;
var presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
class Book extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
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
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(
                    icon: Icon(Icons.domain_verification),
                    text: "Bookings"),
                Tab(icon: Icon(Icons.face), text: "Profile"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Body(),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('current_doc')
                    .snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (!snapshot1.hasData) return Text('Loading...');
                  List<QueryDocumentSnapshot> document11 =
                      snapshot1.data.docs;

                  snapshot1.data.docs.forEach((doc) {
                    print("printing.....");
                    print("curr_doc...");
                    curr_doc = doc['curr_doc'];
                    print(curr_doc);
                  });

                  int postition = 0;
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(currentFirebaseUser.email)
                        .collection('appointments')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      List<QueryDocumentSnapshot> items22 =
                          snapshot.data.docs;
                      final int messageCount = snapshot.data.docs.length;
                      print("curr_doc...");
                      print(curr_doc);

                      return ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (context, position) {
                          // snapshot.data.documents[index]['name'];
                          // document['userRef'] exists here
                          var dept = snapshot.data.docs
                              .elementAt(position)
                              .data()['dep']
                              .toString();
                          print('element at position dep:  ' + dept);

                          var date7 = snapshot.data.docs
                              .elementAt(position)
                              .data()['date']
                              .toString();

                          print('element at position date:  ' + date7);
                          var d = new DateTime.now();
                          var curr_day = d.day + presum[d.month - 1];
                          print('Current date:  ' + curr_day.toString());
                          var index = ((int.parse(date7) -
                              curr_day +
                              int.parse(curr_doc)) %
                              7)
                              .toString();
                          print('index:  ' + index.toString());

                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(dept)
                                .doc(index)
                                .collection('patients')
                                .where("name",
                                isEqualTo: currentFirebaseUser.email)
                                .snapshots(),
                            builder: (BuildContext context1,
                                AsyncSnapshot<QuerySnapshot> snapshot3) {
                              if (!snapshot1.hasData)
                                return Text('Loading...');
                              List<QueryDocumentSnapshot> document11 =
                                  snapshot3.data.docs;

                              snapshot3.data.docs.forEach((doc) {
                                print("printing.....");
                                print("Queue_num...");
                                queue_num = doc['index'];
                                print(queue_num);
                              });
                              var booking_date;
                              for (var i = 0; i < 12; i++) {
                                if (int.parse(date7) - presum[i] < 0) {
                                  var t1 = int.parse(date7) - presum[i - 1];
                                  booking_date = t1.toString() +
                                      '-' +
                                      (i).toString() +
                                      '-' +
                                      '2021';
                                  break;
                                }
                              }

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text("Department: " +
                                      dept +
                                      "\nDate:" +
                                      booking_date +
                                      "\nQueue Number:  " +
                                      queue_num ??
                                      '<No message retrieved>'),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }),
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
            //             .collection('Users')
            //             .doc(currentFirebaseUser.email)
            //             .collection('appointments')
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

            CreateProfilePage(),
          ],
        )),
  );
}