import 'package:excp_training/model/hive/hive_user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'test_screen/test1.dart';

void main() async {
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasko Widget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Test1(),
    );
  }
}
