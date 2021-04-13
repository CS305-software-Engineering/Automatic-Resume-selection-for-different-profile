import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


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
Future<http.Response> http_call (var text1,var text2) async {
print('https://api.dandelion.eu/datatxt/sim/v1/?text1='+text1+'&text2='+text2+'&token=3acbc91ea472416d9ff2074554c10e1f');
  final response = await http.get(Uri.parse(
      'https://api.dandelion.eu/datatxt/sim/v1/?text1='+text1+'&text2='+text2+'&token=3acbc91ea472416d9ff2074554c10e1f')
  );
  return response;

 }
// http_call (var text1,var text2) async {
//   var url =
//   Uri.parse(
//       'https://api.dandelion.eu/datatxt/sim/v1/?text1='+text1+'&text2='+text2+'&token=83e41d6b660a4873921ce67bbeda9832');
//   print(url);
//   // Await the http get response, then decode the json-formatted response.
//   var response = await http.post(url,headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8',
//   },
//     body: jsonEncode(<String, String>{
//       'title': 'ff' ,
//     }),);
//   var jsonResponse = await convert.jsonDecode(response.body);
//   print("response..");
//
//   return jsonResponse['similarity'];
//
// }

class AppointmentPage extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<AppointmentPage> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

  //final List<String> items=[];

  //MyApp({Key key, @required this.items}) : super(key: key);

  //@override
  Widget build(BuildContext context) {
    final title = 'Shortlisted candidates';
    var curr_doc;
    // var current_doc= FirebaseFirestore.instance
    //             .collection('current_doc')
    //             .doc('doc_id').get().then((QuerySnapshot querySnapshot)=>{
    //               print(docref.docs[0].data["field"])
    //             });
    // FirebaseFirestore.instance
    //     .collection('current_doc')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) {
    //   print("printing.....");

    //     curr_doc = doc['curr_doc'];
    //   });
    // });
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Job_Description')
                    .snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (!snapshot1.hasData) return Text('Loading...');
                  List<QueryDocumentSnapshot> document11 = snapshot1.data.docs;
                  //final int messageCount = snapshot1.data.docs.length;
                  //curr_doc=document11['curr_doc'];
                  snapshot1.data.docs.forEach((doc) {

                     curr_doc = doc['curr_doc'];
                    print('curr_doc...');
                    curr_doc = curr_doc.substring(0,1000);
                    print(curr_doc);


                  });
                  //print(items22);
                  //
                  int postition=0;
                  return StreamBuilder(

                    stream: FirebaseFirestore.instance
                        .collection('Resumes')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      int i=0;

                      snapshot.data.docs.forEach((doc) {

                        var data = doc.data();
                        print(curr_doc);
                        http_call(curr_doc,data['details']).then((id)  {
                          print(double.parse(id.body.split(',')[1].split(':')[1]));



                         data.addAll({'score':double.parse(id.body.split(',')[1].split(':')[1])});
                         list_name.add(data);



                        });








                      });



                      final int messageCount = snapshot.data.docs.length;


                      return ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (context, position) {
                          // snapshot.data.documents[index]['name'];
                          // document['userRef'] exists here
                          return Card(

                            child: Padding(

                              padding: const EdgeInsets.all(20.0),
                              child: Text('hello'),




                            ),
                          );







                        },
                      );
                    },
                  );
                })
        ));
  }
}