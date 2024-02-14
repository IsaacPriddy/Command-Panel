import 'package:flutter/material.dart';

class CommonWidgets {

  ButtonStyle customButtonStyle({double height = 1, double width = 1, double fontSize = 18.0}) {
    return ElevatedButton.styleFrom(
      fixedSize: Size(height * 0.18, width * 0.10),
      padding: EdgeInsets.all(width * 0.0234), // was 16
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.amber.shade50, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.blueGrey.shade200,  // Was Colors.blueGrey.shade200
      textStyle: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
        fontFamily: 'Elnath',
      ),
    );
  }

  TextStyle customTextStyle() {
    return const TextStyle(
        color: Colors.black,
        fontFamily: 'Elnath',
    );
  }
  // ADD MORE HERE
}