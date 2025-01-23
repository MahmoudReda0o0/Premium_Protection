import 'package:excp_training/utils/constants.dart';
import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  PageError({super.key, required this.errorMessage, this.onTap});
  String errorMessage;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: mediaWidth * 0.9, child: Text('Error : $errorMessage')),
          ElevatedButton.icon(
              onPressed: () {
                (onTap != null) ? onTap!() : () {};
              },
              label: Text('Reload'),
              icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
