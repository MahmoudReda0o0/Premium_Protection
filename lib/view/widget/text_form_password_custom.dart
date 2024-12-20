import 'package:excp_training/constant/constant.dart';
import 'package:flutter/material.dart';

class TextFormPasswordCustom extends StatefulWidget {
  TextFormPasswordCustom({
    super.key,
    required this.lableText,
    required this.errorMessage,
    //required this.textFieldValue,
    this.onSaved = defaultOnSaved,
    required this.controller,
  });
  String lableText;
  String errorMessage;
  TextEditingController controller;
  //String textFieldValue;
  final Function(String?) onSaved;

  static void defaultOnSaved(String? value) {
    print('Default onSaved called with value: $value');
  }

  @override
  State<TextFormPasswordCustom> createState() => _TextFormPasswordCustomState();
}

class _TextFormPasswordCustomState extends State<TextFormPasswordCustom> {
  bool eyeIcon = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: !eyeIcon,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.lableText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                eyeIcon = !eyeIcon;
                print('eyeIcon: $eyeIcon');
              });
            },
            icon: eyeIcon
                ? const Icon(
                    Icons.visibility,
                    color: Constant.secondaryColor,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Constant.purpleAccent,
                  ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 6) {
            return widget.errorMessage;
          } else {
            return null;
          }
        },
        onSaved: widget.onSaved,
      ),
    );
  }
}
