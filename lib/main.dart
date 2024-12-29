import 'package:excp_training/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view model/cubit/tasko_cubit.dart';
import 'view model/cubit_logic_page.dart';
import 'view/widget/themeData.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Tasko',
      theme: ThemeDataCustom.build(),
      home: BlocProvider<TaskoCubit>(
        create: (context) => TaskoCubit(),
        child: const CubitLogicPage(),
      ),
    );
  }
}
