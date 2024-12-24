import 'package:flutter/material.dart';

class WillPopScopeCustom {}

Future<bool> build(BuildContext context) async {
  // Your custom logic here
  final shouldPop = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to go back?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  return shouldPop ?? false;
}
