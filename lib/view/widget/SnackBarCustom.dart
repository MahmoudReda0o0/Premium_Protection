import 'package:flutter/material.dart';

class SnackBarCustom {
  static void showSnackBar({  required String message,required BuildContext context,int duration =2 }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration:  Duration(seconds: duration),
      ),
    );
  }
}
