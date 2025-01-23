import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/model/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../model/hive/adapter/user_info_adapter.dart';
import '../../../model/models/type_model.dart';
import 'test2.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  late bool connection;

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<InternetConnectionStatus>(
      stream: InternetConnectionChecker.instance.onStatusChange,
      builder: (context, snapshot) {
        if (snapshot.requireData == InternetConnectionStatus.connected) {
          return const Scaffold(
            body: Center(child: Text('Connected')),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Not Connected')),
          );
        }
      },
    );
   // InternetConnectionChecker.instance.onStatusChange.listen(
      // (status) {
      //   switch (status) {
      //     case InternetConnectionStatus.connected:
      //     case InternetConnectionStatus.disconnected:
      //       // TODO: Handle this case.
      //       throw UnimplementedError();
      //     case InternetConnectionStatus.slow:
      //       // TODO: Handle this case.
      //       throw UnimplementedError();
      //   }
      // },
    //);
   
  }
}
