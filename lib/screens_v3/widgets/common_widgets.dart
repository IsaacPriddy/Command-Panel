import 'package:flutter/material.dart';

class CommonWidgets {

  ButtonStyle customButtonStyle({double height = 1, double width = 1}) {
    return ElevatedButton.styleFrom(
      fixedSize: Size(height * 0.18, width * 0.10),
      padding: EdgeInsets.all(width * 0.0234), // was 16
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.amber.shade50, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.blueGrey.shade200,
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'Aquire',
      ),
    );
  }

  // ADD MORE HERE
}