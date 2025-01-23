import 'package:excp_training/firebase_options.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view%20model/cubit/forget_password/forget_password_cubit.dart';

import 'package:excp_training/view%20model/cubit/login_cubit/login_cubit.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view%20model/cubit/register/register_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/hive/adapter/task_adapter.dart';
import 'model/hive/adapter/task_list_adapter.dart';
import 'model/hive/adapter/type_list_adapter.dart';
import 'model/hive/adapter/user_info_adapter.dart';
import 'view model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'view model/cubit/general_cubit/tasko_cubit.dart';
import 'view/widget/themeData.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// // ...

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    //await FirebaseAuth.instance.useAuthEmulator('localHost', 9099);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();
    // Hive.registerAdapter(HiveLocalDataAdapter());
    Hive.registerAdapter(UserInfoAdapter()); // id => 1
    Hive.registerAdapter(TypeListAdapter()); // id => 2
    Hive.registerAdapter(TaskModelListAdapter()); // id => 3
    Hive.registerAdapter(TaskModelAdapter()); // id => 4
    await Future.wait([
      Hive.openBox(HiveConstant.boxCheckLogin),
      Hive.openBox(HiveConstant.boxAndroidWidget),
      Hive.openBox(HiveConstant.boxlocalData),
    ]);

    runApp(const MyApp());
  } catch (e) {
    // Handle initialization errors gracefully
    print('Error initializing Hive: $e');
  }
  runApp(
    const MyApp(),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Close the Hive box when the app is paused or closed
      await Future.wait([
        Hive.box(HiveConstant.boxlocalData).close(),
        Hive.box(HiveConstant.boxCheckLogin).close(),
        Hive.box(HiveConstant.boxAndroidWidget).close()
      ]);

      print('Hive box closed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskoCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => TaskItemCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => TaskTypeCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
        BlocProvider(create: (context) => InternetCheckerCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Tasko',
        theme: ThemeDataCustom.build(),
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.routes,
        //home: SignUpScreenTEST(),
      ),
    );
  }
}
