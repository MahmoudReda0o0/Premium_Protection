import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constant/constant.dart';

class RichTextCustom extends StatelessWidget {
   const RichTextCustom({super.key, required this.action});
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(
        children: <TextSpan>[
         const TextSpan(
            text: 'Don\'t have an account ?',
            style: TextStyle(color: Constant.blackColor),
          ),
          TextSpan(
            recognizer:  TapGestureRecognizer()..onTap = action,
            text: '  Sign Up',
            style:const TextStyle(color: Constant.secondaryColor,fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
