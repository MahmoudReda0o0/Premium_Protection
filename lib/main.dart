import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view%20model/cubit/login_cubit/login_cubit.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:excp_training/view/zzzTest_code/test1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view model/cubit/general_cubit/tasko_cubit.dart';
import 'view model/cubit_logic_page.dart';
import 'view/widget/themeData.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskoCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => TaskItemCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => TaskTypeCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Tasko',
        theme: ThemeDataCustom.build(),
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.routes,
      ),
    );
  }
}
