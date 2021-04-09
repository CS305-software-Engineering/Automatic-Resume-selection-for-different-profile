import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resue/Modules/User_details/user_details.dart';


import 'background.dart';
enum SingingCharacter { lafayette, jefferson }
final databaseReference = FirebaseFirestore.instance;

class FormScreenState extends State<FormScreen> {
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
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
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
    );
  }
  Widget tenth_class_percentage() {
    return TextFormField(
      decoration: InputDecoration(labelText: '10th Percentage'),
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
    );
  }
  Widget twelfth_class_percentage() {
    return TextFormField(
      decoration: InputDecoration(labelText: '12th Percentage'),
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
    );
  }
  Widget gap() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Number of semesters with backlog'),
        keyboardType: TextInputType.number,
        validator: (String value) {
          return null;
        },
        onSaved: (String value) {
          _gap = value;
        }
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
    return

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
    );

    }
    Widget Cgpa() {
    return TextFormField(
    decoration: InputDecoration(labelText: 'cgpa'),
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
    );
    }
    Widget Branch() {
    return TextFormField(
    decoration: InputDecoration(labelText: 'branch'),
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
    );
    }


    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Enter Your Details")),
    body: SingleChildScrollView(
    child: Container(

    margin: EdgeInsets.only(left:400,right:400),
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
    SizedBox(height: 100),
    RaisedButton(
    child: Text(
    'Submit',
    style: TextStyle(color: Colors.blue, fontSize: 16),
    ),
    onPressed: () {
    if (!_formKey.currentState.validate()) {
    return;
    }

    _formKey.currentState.save();

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
    )
    ],
    ),
    ),
    ),
    ),
    );
    }
    }