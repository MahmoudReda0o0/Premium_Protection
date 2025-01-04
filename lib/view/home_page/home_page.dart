import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/profile/change_password.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/widget/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/app_color.dart';
import '../../utils/route/app_route.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/container_image.dart';
import 'home_drawer.dart';
import 'widget/show_task_list.dart';
import 'widget/sort_popup_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Widget> taskList = [
  //   const AllTaskList(),
  //   const AllTaskList(),
  //   const AllTaskList(),
  // ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskoCubit, TaskoState>(builder: (context, state) {
      return pageBuild(context);
    });
  }

  Scaffold pageBuild(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.grayWhite,
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
          actions:const [
            Text('Sort '),
            SortPopupMenu(),
            Gap(5),
          ],
        ),
        drawer: const HomeDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColor.buttonColor,
          child: const Icon(
            Icons.add,
            size: 50,
            color: AppColor.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.addNewTask);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              barItem(icon: Icons.list, title: 'All Tasks', index: 0),
              barItem(icon: Icons.work, title: 'New Tasks', index: 1),
              barItem(icon: Icons.done, title: 'Completed ', index: 2),
              Gap(10),
            ],
          ),
        ),
        body: TaskList(
          index: selectedIndex,
        ));
  }

  Widget barItem(
      {required String title, required IconData icon, required int index}) {
    return InkWell(
      onTap: () => setState(() {
        selectedIndex = index;
      }),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColor.buttonColor,
          ),
          Text(
            title,
            style: TextStyle(color: AppColor.buttonColor),
          ),
        ],
      ),
    );
  }

  Column noTaskList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(180),
        ContainerImageCustom(
          height: 300,
          width: MediaQuery.of(context).size.width,
          image: 'assets/working.gif',
          fit: BoxFit.fitHeight,
        ),
        const Text(
          'Do Task To Change Your Life',
          style: TextStyle(
              color: AppColor.orangeWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
