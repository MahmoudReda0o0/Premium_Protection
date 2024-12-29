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
            .white, // Use the constant for drawer background color
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Constant.buttonColor,
                child: Icon(
                  Icons.person,
                  color: Constant.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Constant
                    .buttonColor, // Use the primary color from the constant class
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Constant.grayDark,
              ),
              title: const Text('Profile',style: TextStyle(color: Constant.grayDark,),),
              onTap: () {
                BlocProvider.of<TaskoCubit>(context).openProfile();
              },
              onLongPress: () => BlocProvider.of<TaskoCubit>(context).openLogin(),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Constant.grayDark,
              ), 
              title: const Text('Task Type',style: TextStyle(color: Constant.grayDark,),),
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
