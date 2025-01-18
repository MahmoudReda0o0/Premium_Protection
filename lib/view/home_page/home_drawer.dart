import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/route/app_route.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../view model/cubit/login_cubit/login_cubit.dart';
import '../../view model/cubit/task_type/task_type_cubit.dart';
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
            _drawerHeaderItem(
                context: context,
                title: 'Profile',
                iconData: Icons.person,
                onTap: () {
                  BlocProvider.of<ProfileCubit>(context).getUserInfo();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoute.profile);
                }),
            _drawerHeaderItem(
                context: context,
                title: 'Task Type',
                iconData: Icons.settings,
                onTap: () {
                  BlocProvider.of<TaskTypeCubit>(context).getTaskTypeList();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoute.taskType);
                }),
            _drawerHeaderItem(
              context: context,
              title: 'open login ',
              iconData: Icons.settings_backup_restore_rounded,
              onTap: () {
                BlocProvider.of<LoginCubit>(context).resetLoginState();
                Navigator.pushReplacementNamed(context, AppRoute.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _drawerHeaderItem(
      {required BuildContext context,
      required String title,
      required IconData iconData,
      required Function onTap}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: AppColor.grayDark,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColor.grayDark,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
