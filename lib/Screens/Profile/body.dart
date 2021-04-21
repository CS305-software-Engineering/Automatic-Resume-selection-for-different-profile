import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

TextEditingController _nameController, _numberController;
String _typeSelected = '';

DatabaseReference _ref;
@override
void initState() {
  // TODO: implement initState
  super.initState();
  _nameController = TextEditingController();
  _numberController = TextEditingController();
  _ref = FirebaseDatabase.instance.reference().child('Contacts');
}

void saveContact() {
  String name = _nameController.text;
  String number = _numberController.text;

  Map<String, String> contact = {
    'name': name,
    'number': '+91 ' + number,
    'type': _typeSelected,
  };

  _ref.push().set(contact).then((value) {
    Navigator.pop(context);
  });
}
