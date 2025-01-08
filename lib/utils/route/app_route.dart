import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/login/login.dart';
import 'package:excp_training/view/profile/change_password.dart';
import 'package:excp_training/view/profile/edit_profile.dart';
import 'package:excp_training/view/profile/profile.dart';
import 'package:excp_training/view/register/register.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/tasks/edit_task_detail.dart';
import 'package:excp_training/view/tasks/show_task_detail.dart';
import 'package:excp_training/view/tasks/task_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view/zzzTest_code/home_test.dart';
import '../../view/zzzTest_code/test1.dart';
import '../../view/zzzTest_code/test2.dart';

class AppRoute {
  static const String login = '/',
      register = '/register',
      navigationHome = '/navigationHome',
      homePage = '/homePage',
      addNewTask = '/addNewTask',
      taskDetail = '/TaskDetail',
      editTaskDetail = '/editTaskDetail',
      profile = '/profile',
      editProfile = '/editProfile',
      editPassword = '/editPassword',
      taskType = '/taskType',
      signUpScreenTEST = '/SignUpScreenTEST';

  static String test1 = '/test1', test2 = '/test2';

  static String initialRoute = login;

  static Map<String, Widget Function(BuildContext)> routes = {
    login: (context) => const Login(),
    register: (context) => const Register(),
    
    homePage: (context) => const HomePage(),
    addNewTask: (context) => const AddNewTask(),
    taskDetail: (context) => const ShowTaskDetail(),
    editTaskDetail: (context) => const EditTaskDetail(),
    profile: (context) => const Profile(),
    editProfile: (context) => const EditProfile(),
    editPassword: (context) => const EditPassword(),
    taskType: (context) => const TaskType(),
    test1: (context) => const Test1(),
    test2: (context) => const Test2(),
    //signUpScreenTEST: (context) =>  SignUpScreenTEST(),
  };
  // login: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const Login(),
  //     ),
  // homePage: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const HomePage(),
  //     ),
  // taskDetail: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const ShowTaskDetail(),
  //     ),
  // editTaskDetail: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const EditTaskDetail(),
  //     ),
  // profile: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const Profile(),
  //     ),
  // editProfile: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const EditProfile(),
  //     ),
  // editPassword: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const EditPassword(),
  //     ),
  // taskType: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const TaskType(),
  //     ),
  // test1: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const Test1(),
  //     ),
  // test2: (context) => BlocProvider(
  //       create: (context) => TaskoCubit(),
  //       child: const Test2(),
  //     ),

  // Route generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case home:
  //       return MaterialPageRoute(
  //         builder: (_) => const HomePage(),
  //       );
  //     case profile:
  //       return MaterialPageRoute(
  //         builder: (_) => const Profile(),
  //       );
  //     case changePassword:
  //       return MaterialPageRoute(
  //         builder: (_) => const ChangePassword(),
  //       );
  //     case editProfile:
  //       return MaterialPageRoute(
  //         builder: (_) => const EditProfile(),
  //       );
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Login(),
  //       );
  //   }
  // }
}
