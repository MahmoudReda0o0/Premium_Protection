import 'package:excp_training/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

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
      this.iconOnTap = defaultIconOnTap,
      this.suffixWidget
      });
  String lableText;
  String errorMessage;
  bool readOnly;
  bool numberOnly;
  TextEditingController controller;
  IconData? iconDate;
  Widget? suffixWidget;
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
          labelText: widget.lableText,
          labelStyle: const TextStyle(color: Constant.grayDark),
          suffix: widget.suffixWidget??null,
          suffixIcon: (widget.iconDate != null)
              ? IconButton(
                  onPressed: () {
                    widget.iconOnTap();
                  },
                  icon: Icon(widget.iconDate),
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Constant.buttonColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Constant.buttonColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Constant.buttonColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Constant.red),
          ),
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
