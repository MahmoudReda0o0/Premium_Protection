import 'package:excp_training/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:excp_training/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view model/cubit/tasko_cubit.dart';
import '../tasks/task_type.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constant
            .scaffoldBackgroundColor, // Use the constant for drawer background color
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Constant.blueGradientLight,
                child: Icon(
                  Icons.person,
                  color: Constant.whiteColor,
                ),
              ),
              decoration: BoxDecoration(
                color: Constant
                    .blueGradientLight, // Use the primary color from the constant class
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Constant.primaryColor,
              ),
              title: const Text('Profile'),
              onTap: () {
                BlocProvider.of<TaskoCubit>(context).openProfile();
              },
              onLongPress: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login())),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Constant.primaryColor,
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TaskType()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
