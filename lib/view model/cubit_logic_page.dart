import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';
import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/profile/change_password.dart';
import 'package:excp_training/view/profile/edit_profile.dart';
import 'package:excp_training/view/profile/profile.dart';
import 'package:excp_training/view/register/register.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/tasks/show_task_detail.dart';
import 'package:excp_training/view/tasks/task_type.dart';
import 'package:excp_training/view/widget/LoadingPage.dart';
import 'package:excp_training/view/zzzTest_code/test1.dart';
import 'package:excp_training/view/zzzTest_code/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/login/login.dart';
import '../view/tasks/edit_task_detail.dart';

class CubitLogicPage extends StatelessWidget {
  const CubitLogicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is TaskoInitial) {
            return const Login();
          } else if (state is RegisterState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openLogin();
                },
                child: const Register());
          } else if (state is HomeState) {
            return const HomePage();
          } else if (state is ProfileState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openHome();
                },
                child: const Profile());
          } else if (state is TaskTypeState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openHome();
                },
                child: const TaskType());
          } else if (state is TaskTypeState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openHome();
                },
                child: const TaskType());
          } else if (state is ShowTaskDetailState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openHome();
                },
                child: const ShowTaskDetail());
          } else if (state is EditTaskDetailState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context)
                      .openShowTaskDetail();
                },
                child: const EditTaskDetail());
          } else if (state is AddNewTaskState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openHome();
                },
                child: const AddNewTask());
          } else if (state is EditProfileState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openProfile();
                },
                child: const EditProfile());
          } else if (state is EditPasswordState) {
            return WillPopScope(
                onWillPop: () {
                  return BlocProvider.of<TaskoCubit>(context).openProfile();
                },
                child: const ChangePassword());
          } else if (state is LoadingState) {
            return const LoadingPage();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
