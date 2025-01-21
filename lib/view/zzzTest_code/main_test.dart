import 'dart:io';

import 'package:excp_training/model/hive/adapter/task_list_adapter.dart';
import 'package:excp_training/model/hive/adapter/user_info_adapter.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/hive/adapter/task_adapter.dart';
import '../../model/hive/adapter/type_list_adapter.dart';
import 'test_screen/test1.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await deleteHiveFile(HiveConstant.boxlocalData);

  await Hive.initFlutter();

  Hive.registerAdapter(UserInfoAdapter());      // id => 1 
  Hive.registerAdapter(TypeListAdapter());      // id => 2
  Hive.registerAdapter(TaskModelListAdapter()); // id => 3
  Hive.registerAdapter(TaskModelAdapter());     // id => 4

  await Future.wait([
    Hive.openBox(HiveConstant.boxlocalData),
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Add the observer to listen for app lifecycle events
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer when the app is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Close the Hive box when the app is paused or closed
      Hive.box(HiveConstant.boxlocalData).close();
      print('Hive box closed');
    }
  }

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
