import 'package:flutter/material.dart';

final buttonStyle = Material(
  elevation: 5.0,
  //borderRadius: BorderRadius.circular(30.0),
  color: Colors.blueGrey[800],
  child: MaterialButton(
    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    onPressed: () {},
  ),
);
const btnColor = Colors.indigo;
const backgroundColor = Colors.black;
const primaryAccentColor = Colors.blueAccent;
const lightInputTextStyle = TextStyle(color: Colors.black, fontSize: 15);

class CommonStyle {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "",
      String hintTextStr = "",
      String prefixText = ""}) {
    return InputDecoration(
      //contentPadding: EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      prefixText: prefixText,
      labelStyle: TextStyle(color: Colors.blueGrey[400], fontSize: 16),
      hintStyle: TextStyle(color: Colors.blueGrey[400], fontSize: 18),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange)),
    );
  }
}
