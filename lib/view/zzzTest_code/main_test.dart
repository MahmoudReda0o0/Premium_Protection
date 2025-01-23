import 'dart:io';

import 'package:excp_training/model/hive/adapter/task_list_adapter.dart';
import 'package:excp_training/model/hive/adapter/user_info_adapter.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/view/zzzTest_code/test_screen/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/hive/adapter/task_adapter.dart';
import '../../model/hive/adapter/type_list_adapter.dart';
import '../../view model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'test_screen/test1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());      // id => 1
  Hive.registerAdapter(TypeListAdapter());      // id => 2
  Hive.registerAdapter(TaskModelListAdapter()); // id => 3
  Hive.registerAdapter(TaskModelAdapter());     // id => 4
  await Future.wait([
    Hive.openBox(HiveConstant.boxCheckLogin),
    Hive.openBox(HiveConstant.boxAndroidWidget),
    Hive.openBox(HiveConstant.boxlocalData),
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCheckerCubit()),
      ],
      child: MaterialApp(
        title: 'Tasko Widget App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Test2(),
      ),
    );
  }
}
