import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// CUTOMIZED SNACKBAR
void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: Colors.teal,
    duration: const Duration(milliseconds: 5000),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// CUSTOM TOAST
void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Colors.teal
  );
}