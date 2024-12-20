import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class ButtonCustom {
  static Widget build({
    required Color buttonColor,
    required Function onPressed,
    required String title,
    Color textColor = Colors.white,
    double tilteSize = 20,
    double height = 55,
    double? width,
  }) {
    return SizedBox(
      height: height,
      width: (width != null) ? width : null,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              //side: const BorderSide(color: Colors.red),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
        ),
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: Text(
            title,
            style:  TextStyle(
            color: Constant.whiteColor,
            fontSize: tilteSize,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
    );
  }
}
