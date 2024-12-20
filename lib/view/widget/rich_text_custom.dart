import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class RichTextCustom extends StatelessWidget {
   RichTextCustom({super.key, required this.action, required this.fristText, required this.secondText});
  final VoidCallback action;
  String fristText;
  String secondText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
           TextSpan(
            text: fristText,
            style:const TextStyle(color: Constant.blackColor),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = action,
            text: secondText,
            style: const TextStyle(
                color: Constant.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
