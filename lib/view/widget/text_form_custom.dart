import 'package:flutter/material.dart';

class TextFormCustom extends StatefulWidget {
  TextFormCustom(
      {super.key,
      required this.lableText,
      required this.errorMessage,
      required this.textFieldValue,
      this.onSaved =defaultOnSaved});
  String lableText;
  String errorMessage;
  String textFieldValue;
  final Function(String?) onSaved;
  static void defaultOnSaved(String? value) {
    print('Default onSaved called with value: $value');
  }

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.lableText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMessage;
          } else {
            return null;
          }
        },
        //onEditingComplete: () => print(''),
        onSaved: widget.onSaved,
      ),
    );
  }
}
