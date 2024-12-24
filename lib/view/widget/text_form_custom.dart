import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormCustom extends StatefulWidget {
  TextFormCustom(
      {super.key,
      required this.lableText,
      required this.errorMessage,
      this.onSaved = defaultOnSaved,
      this.readOnly = false,
      required this.controller,
      this.iconDate,
      this.numberOnly = false,
      this.iconOnTap = defaultIconOnTap});
  String lableText;
  String errorMessage;
  bool readOnly;
  bool numberOnly;
  TextEditingController controller;
  IconData? iconDate;
  final Function iconOnTap;
  final Function(String?) onSaved;

  static void defaultOnSaved(String? value) {
    print('Default onSaved called with value: $value');
  }

  static void defaultIconOnTap() => {};

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        keyboardType: widget.numberOnly ? TextInputType.number : null,
        inputFormatters: widget.numberOnly
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          suffixIcon: (widget.iconDate != null)
              ? IconButton(
                  onPressed: () {
                    widget.iconOnTap();
                  },
                  icon: Icon(widget.iconDate))
              : null,
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
