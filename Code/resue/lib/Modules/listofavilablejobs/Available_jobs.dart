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
import 'package:resue/Modules/confirm/confirm.dart';
import 'package:resue/components/rounded_button.dart';
import 'package:resue/components/text_field_container.dart';
import 'package:resue/components/variable.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';


Uint8List uploadedImage;
var list_name = [];



class List_of_Ajobs extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<List_of_Ajobs> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

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
                  .collection('posted_jobs')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Text('Loading...');
                int i=0;


                final List<QueryDocumentSnapshot> entries = snapshot.data.docs;



                final int messageCount = snapshot.data.docs.length;

                final List<int> colorCodes = <int>[600, 500, 100];

                var url;

                return  ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {

                    return  TextFieldContainer (child: GestureDetector(


                        child: Center(child: Text(' ${entries[index].data()['job_summary']}')),

                        onTap: () =>{

                           Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  confirm())),
                          jobid = entries[index].data()['jobid'],
                          client_id = entries[index].data()['CLIENT_id'],
                          job_des = entries[index].data()['job_desc'],
                          job_summary = entries[index].data()['job_summary'],
                          print(jobid),
                          print(client_id),
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