import 'dart:core';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:resue/components/rounded_button.dart';
import 'package:resue/components/text_field_container.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'background.dart';

Uint8List uploadedImage;

//method to load image and update `uploadedImage`


enum SingingCharacter { lafayette, jefferson }
final databaseReference = FirebaseFirestore.instance;

class FormScreenState extends State<FormScreen> {
  TextEditingController emailController = new TextEditingController();
  String _name;
  String _email;
  String _password;
  String _phoneNumber;
  String _tenth;
  String _twelfth;
  String _gap;
  String _tier;
  String _cgpa;
  String _branch;
  String dropdown;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: 'Name',
        border: InputBorder.none,

      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    )
    );
  }

  Widget _buildPhoneNumber() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: 'Phone number',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    )
    );
  }
  Widget tenth_class_percentage() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: '10th Percentage',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return '10th class percentage is required';
        }

        return null;
      },
      onSaved: (String value) {
        _tenth = value;
      },
    )
    );
  }
  Widget twelfth_class_percentage() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: '12th Percentage',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return '12th class percentage is required';
        }

        return null;
      },
      onSaved: (String value) {
        _twelfth = value;
      },
    ),
    );
  }
  Widget gap() {
    return TextFieldContainer(child: TextFormField(
        decoration: InputDecoration(

          hintText: 'Number of semesters with backlog',
          border: InputBorder.none,

        ),

        keyboardType: TextInputType.number,
        validator: (String value) {
          return null;
        },
        onSaved: (String value) {
          _gap = value;
        }
    ),
    );
  }
  Widget college_type() {
    String dropdownValue = 'Choose College Type';
    List<String> listValue = <String>[
      'Choose College Type',
      'Tier 1',
      'Tier 2',
      'Tier 3'
    ];
    return TextFieldContainer(
        child:

      DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,

        //dropdownColor: Colors.,
        style: TextStyle(color: Colors.deepPurple),
        //padding: const EdgeInsets.all(15.0),
        underline: Container(
          height: 2,
          //width: 30,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            _tier=dropdownValue;
          });
        },
        items: listValue.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );

  }
  Widget Cgpa() {
    return  TextFieldContainer(child:TextFormField(
      decoration: InputDecoration(

        hintText: 'CGPA',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'CGPA is required';
        }

        return null;
      },
      onSaved: (String value) {
        _cgpa = value;
      },
    ),
    );
  }
  Widget Branch() {
    return TextFieldContainer(
        child: TextFormField(
          decoration: InputDecoration(

            hintText: 'branch',
            border: InputBorder.none,

          ),

      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'branch is required';
        }

        return null;
      },
      onSaved: (String value) {
        _branch = value;
      },
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Enter Your Details")),
      body:  SingleChildScrollView(
    child: Center(child: Container(
          width: 300,
          margin: EdgeInsets.only(left:10,right:1),
          child: Form(

            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildPhoneNumber(),
                tenth_class_percentage(),
                twelfth_class_percentage(),
                Cgpa(),
                Branch(),
                gap(),
                college_type(),

                TextFieldContainer(

                  child: TextField(
                    controller: emailController,
                    minLines: 2,
                    maxLines: 20,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Give Your Details"),

                  ),

                ),
            RoundedButton(

                    text:'Apply',

                color: Colors.green,
                press: () async {



                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    print(_phoneNumber);
                    var url =
                    Uri.parse(
                        'https://us-central1-resume-b5075.cloudfunctions.net/user?name='+_name+'|'+_phoneNumber+'|'+_tenth+'|'+_twelfth+'|'+_gap+'|'+_tier+'|'+_cgpa+'|'+_branch+'|'+(emailController.text).toString()+'|'+FirebaseAuth.instance.currentUser.email);
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
                    databaseReference.collection("companies").add({
                      'name': _name,
                      'phonenumber': _phoneNumber,
                      'tenth':_tenth,
                      'twelth':_twelfth,
                      'gap':_gap,
                      'tier':_tier,
                      'cgpa':_cgpa,
                      'branch':_branch,


                    }).then((value){
                      print(value.id);
                    });


                    //Send to API
                  },
            ),

              ],
            ),
          ),
        ),
      ),

    ),

    );
  }
}






