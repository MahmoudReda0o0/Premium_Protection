import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key, required this.errorMessage, this.onTap});
  String errorMessage;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error : $errorMessage'),
          ElevatedButton.icon(
              onPressed: () {
                (onTap != null) ? onTap!() : (){};
              },
              label: Text('Reload'),
              icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
