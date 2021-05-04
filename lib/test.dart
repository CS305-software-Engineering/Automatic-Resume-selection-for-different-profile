import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:resue/Home_client/Components/app_bar.dart';
import 'package:resue/Modules/User_details/user_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resue/Modules/result/result.dart';
import 'package:resue/components/text_field_container.dart';
import 'package:resue/components/variable.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tuple/tuple.dart';
import 'package:string_similarity/string_similarity.dart' as simil;
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
TextEditingController emailController = new TextEditingController();



Future<double> http_call (var text1,var text2) async {
return simil.StringSimilarity.compareTwoStrings(text1, text2);


}

class List_of_testjobs extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<List_of_testjobs> {
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

            body:
            Column(children: <Widget>[
              Expanded(flex:15,child: CustomAppBar()),
              CupertinoSearchTextField(placeholder: "Search Jobs",controller: emailController,
                  onSubmitted :(String) {


                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => List_of_testjobs()));







              }





              ),
              Expanded(flex:70,child: DynamicChange())


        ]
            )



        )
    );
  }
}
class DynamicChange extends StatefulWidget {
  @override
  StateDynamic createState() => StateDynamic();
} // Clas
class StateDynamic extends State<DynamicChange> {
  int number = 10;

  Widget build(BuildContext context) {
    return new Scaffold(
      body: thisScreenNeeds(),

    );
  }

  Widget thisScreenNeeds() {
    return

      StreamBuilder(

        stream: FirebaseFirestore.instance
        .collection('student@gmail.com').doc('posted_jobs').collection('jobs')
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
                inc, Tuple2(doc.data()['job_summary'], score));
            inc++;
          });
        }
        else {
          entries.insert(
              inc, Tuple2(doc.data()['job_summary'], 0));
        }
      });

     if(entries.length>snapshot.data.docs.length){
       print(entries.length.toString()+" "+ snapshot.data.docs.length.toString());
       entries.removeRange(0, snapshot.data.docs.length);
     }
      entries.sort((a, b) => a.item2.compareTo(b.item2));


      final int messageCount = snapshot.data.docs.length;

      final List<int> colorCodes = <int>[600, 500, 100];


      return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return TextFieldContainer(child: GestureDetector(


              child: Center(child: Text('${entries[index].item1}')),
              onTap: () =>
              {
              }
          ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),

      );

    }
    );

  }
}

