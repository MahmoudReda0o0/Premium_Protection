import 'package:flutter/material.dart';

class SnackBarCustom {
  static void build(
      {required String message,
      required BuildContext context,
      Color messageColor = Colors.white,
      int duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: messageColor),
        ),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
