import 'package:flutter/material.dart';

SnackBar customSnackBar(String input, IconData icon, Color color, Color bgColor) {
  return SnackBar(
    elevation: 0,
    backgroundColor: bgColor,
    duration: const Duration(milliseconds: 5000),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const  EdgeInsets.only(left: 8.0),
            child: Text(
              input,
              style: TextStyle(color: color)
            )
          )
        )
      ]
    )
  );
}