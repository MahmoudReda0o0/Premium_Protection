import 'package:excp_training/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/route/app_route.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../tasks/task_type.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColor.white, // Use the constant for drawer background color
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColor.buttonColor,
                child: Icon(
                  Icons.person,
                  color: AppColor.white,
                ),
              ),
              decoration: BoxDecoration(
                color: AppColor
                    .buttonColor, // Use the primary color from the constant class
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: AppColor.grayDark,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: AppColor.grayDark,
                ),
              ),
              onTap: () {
                BlocProvider.of<TaskoCubit>(context).openProfile();
              },
              onLongPress: () => Navigator.pushNamed(context, AppRoute.login),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: AppColor.grayDark,
              ),
              title: const Text(
                'Task Type',
                style: TextStyle(
                  color: AppColor.grayDark,
                ),
              ),
              onTap: () {
                BlocProvider.of<TaskoCubit>(context).openTaskType();
              },
            ),
          ],
        ),
      ),
    );
  }
}
