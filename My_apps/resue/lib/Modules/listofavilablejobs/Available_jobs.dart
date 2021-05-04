import 'dart:core';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:resue/Modules/Home/Components/app_bar.dart';
import 'package:resue/Modules/Home/home_screen.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resue/Modules/confirm/confirm.dart';
import 'package:resue/Modules/listofjobs/listofjobs.dart';
import 'package:resue/Modules/split/split.dart';
import 'package:resue/components/rounded_button.dart';
import 'package:resue/components/text_field_container.dart';
import 'package:resue/components/variable.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'dart:convert';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:tuple/tuple.dart';
import 'package:string_similarity/string_similarity.dart' as simil;


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../test.dart';
TextEditingController emailController = new TextEditingController();



Future<double> http_call (var text1,var text2) async {
  return simil.StringSimilarity.compareTwoStrings(text1, text2);


}

Uint8List uploadedImage;
var list_name = [];



class List_of_Ajobs extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();

}

class _appointmentState extends State<List_of_Ajobs> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

  var client = FirebaseAuth.instance.currentUser;
  //@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final title = 'List of posted jobs';
    var curr_doc;

// The filtered & ordered history that's accessed from the UI


// The currently searched-for term
    String selectedTerm;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: CupertinoPageScaffold(
            child: Scaffold(
              body:



            Container(


                decoration: BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                  ),

                ),

              child:

              Column(

           children: <Widget>[

                  Expanded(
                    flex:15,

                    child: CustomAppBar(),
                  ),
                  CupertinoSearchTextField(placeholder: "Search Jobs",itemColor: Colors.black,controller: emailController,
                      onSubmitted :(String) {


                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => List_of_Ajobs()));

                      }
                  ),

                  Expanded(
                    flex:80,
                    child: Row(
                      children: <Widget>[
                        Expanded(

                          child: Align(
                      alignment: Alignment.center,
                    child: Image.asset('assets/images/jobs.png',height : size.height * 0.5, width: size.width*0.3,),



                  ),
                        ),
                        Expanded(

                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height:5,width: 5),
                                  Expanded(flex:10,child:Text("Available Jobs",style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Open Sans',
                                      fontSize: 40),
                                  )),


                                  Expanded (
                                      flex: 90,
                                      child:StreamBuilder(

                                          stream: FirebaseFirestore.instance
                                              .collection('posted_jobs')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) return Text('Loading...');
                                            int i = 0;
                                            List<Tuple2<String, double>> entries_temp = [];


                                            int inc = 0;
                                            snapshot.data.docs.forEach((doc) {
                                              print('emailController.text');
                                              print(emailController.text);
                                              if (emailController.text != '') {
                                                http_call(emailController.text, doc.data()['job_desc'])
                                                    .then((id) {
                                                  var score = id;


                                                  entries.insert(
                                                      inc, Tuple2(Tuple2(Tuple2(doc.data()['job_summary'],doc.data()['CLIENT_id']),doc.data()['jobid']), score));
                                                  print(score);

                                                  inc++;
                                                });
                                              }
                                              else {
                                                entries.insert(
                                                    inc, Tuple2(Tuple2(Tuple2(doc.data()['job_summary'],doc.data()['CLIENT_id']),doc.data()['jobid']), 0));

                                              }
                                            });




                                            entries.sort((b, a) => a.item2.compareTo(b.item2));
                                            if(entries.length>snapshot.data.docs.length){
                                              print(entries.length.toString()+" "+ snapshot.data.docs.length.toString());
                                              entries.removeRange( snapshot.data.docs.length,entries.length);
                                            }
                                            entries.sort((b, a) => a.item2.compareTo(b.item2));
                                            print(entries);


                                            final int messageCount = snapshot.data.docs.length;

                                            final List<int> colorCodes = <int>[600, 500, 100];


                                            return ListView.separated(
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(8),
                                              itemCount: entries.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return TextFieldContainer(child: GestureDetector(


                                                    child: Center(child: Text('${entries[index].item1.item1.item1}')),
                                                    onTap: () =>
                                                    { Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>  MyAppSplit())),
                                                      jobid = entries[index].item1.item2,
                                                      client_id = entries[index].item1.item1.item2,

                                                      job_summary = entries[index].item1.item1.item1,
                                                      print(jobid),
                                                      print(client_id),
                                                      print(job_summary)


                                                    }
                                                ),
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) => const Divider(),

                                            );

                                          }
                                      )
                                  )
                                ]
                            )

                        ),
                        // Expanded(
                        //
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Image.asset('assets/images/pic.png',height : size.height * 3, width: size.width*0.5,),
                        //
                        //   ),
                        // ),


                      ],
                    )
                    ,
                  ),

                ],
              ),
            ),



    )
        )
    );

  }
}

