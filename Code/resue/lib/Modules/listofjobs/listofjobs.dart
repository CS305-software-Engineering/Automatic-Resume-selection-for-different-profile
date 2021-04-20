import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'dart:convert';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resue/Modules/result/result.dart';
import 'package:resue/components/text_field_container.dart';
import 'package:resue/components/variable.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.

//   @override
//   Widget build(BuildContext context) {
//     String dropdownValue = 'User';
//     List<String> listValue = <String>['User', 'Admin'];
//     precacheImage(AssetImage("assets/images/signup.jpg"), context);
//     precacheImage(AssetImage("assets/images/login.jpg"), context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'leso',
//       theme: ThemeData(
//         primaryColor: kPrimaryColor,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: MyStatefulWidget(),
//     );
//   }
// }
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var list_name = [];



class List_of_jobs extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<List_of_jobs> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];
  var client = FirebaseAuth.instance.currentUser;


  //final List<String> items=[];

  //MyApp({Key key, @required this.items}) : super(key: key);

  //@override
  Widget build(BuildContext context) {
    final title = 'List of posted jobs';
    var curr_doc;

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body:

              StreamBuilder(

                  stream: FirebaseFirestore.instance
                      .collection(client.email).doc('posted_jobs').collection('jobs')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Text('Loading...');
                    int i=0;
                    print(client.email);

                    final List<QueryDocumentSnapshot> entries = snapshot.data.docs;



                    final int messageCount = snapshot.data.docs.length;

                    final List<int> colorCodes = <int>[600, 500, 100];



                    return  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {

                        return  TextFieldContainer (child: GestureDetector(


                          child: Center(child: Text('JOB Number ${entries[index].data()['jobid']}')),
                            onTap: () =>{
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  AppointmentPage())),
                               job_des = entries[index].data()['Id'],
                               jobid =  entries[index].data()['jobid'],
                              job_des = entries[index].data()['job_desc'],
                               print(job_des)


                            }
                        ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    );
                  },
                )


        )
    );
  }
}