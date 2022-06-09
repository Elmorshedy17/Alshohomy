import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastTemplate {
  final String x = "x";
  show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
