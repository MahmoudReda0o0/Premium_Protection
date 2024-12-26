import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import 'SnackBarCustom.dart';

class FormSubmitButtonCustom {
  static build(
      {String snakBarMessage = 'form submitted successfully',
      required BuildContext context,
      required GlobalKey<FormState> formKey,
      Function? onTap,
      Function? onValidate}) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          (onTap ?? () {})();
          FocusScope.of(context).unfocus();
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            // SnackBarCustom.build(
            //   message: snakBarMessage,
            //   context: context,
            // );
            (onValidate ?? () {})();

            // Process the form data
          }
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.red),
            ),
          ),
          backgroundColor:
              WidgetStateProperty.all<Color>(Constant.orangeGradientLight),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Constant.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
