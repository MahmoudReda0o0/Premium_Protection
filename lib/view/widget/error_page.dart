import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
   ErrorPage({super.key,required this.errorMessage});
  String errorMessage ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Center(child: Text('Error : $errorMessage'),),);
  }
}