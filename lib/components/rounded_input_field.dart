import 'package:flutter/material.dart';
import 'package:resue/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;

  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, TextInputType keyboardType,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: Icon(
           icon,
            color: Colors.blue,
          ),
          hintText: hintText,
          border: InputBorder.none,

        ),
      ),
    );
  }
}
