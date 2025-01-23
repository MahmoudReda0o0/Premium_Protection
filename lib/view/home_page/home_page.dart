import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/view%20model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/home_page/widget/offline_task_list.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';

import 'package:excp_training/view/zzzTest_code/test_screen/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../model/models/task_model.dart';
import '../../utils/app_color.dart';

import '../../utils/route/app_route.dart';
import '../../view model/cubit/task_type/task_type_cubit.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: InkWell(
          child: const Text('Home Page'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Test2()));
          },
        ),
        centerTitle: true,
        actions: const [
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
        onPressed: () async {
          bool isConnected =
              await InternetConnectionChecker.instance.hasConnection;
          if (isConnected) {
            BlocProvider.of<TaskTypeCubit>(context).getTaskTypeList();
            Navigator.pushNamed(context, AppRoute.addNewTask);
          } else {
            SnackBarCustom.build(message: 'Connect to internet to add task', context: context);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            barItem(
                icon: Icons.work_history_outlined,
                title: 'New Tasks',
                index: 0),
            barItem(icon: Icons.done, title: 'Completed', index: 1),
            barItem(icon: Icons.list, title: 'All Tasks ', index: 2),
            Gap(10),
          ],
        ),
      ),
      body: BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
        builder: (context, state) {
          if (state.isConnected) {
            return OnlineTaskList(
              index: selectedIndex,
            );
          } else {
            List<TaskModel> taskList = HiveFun.getTaskModelList();
            return OfflineTaskList(taskList: taskList);
          }
        },
      ),
    );
  }

  Widget barItem(
      {required String title, required IconData icon, required int index}) {
    return InkWell(
      onTap: () => setState(() {
        selectedIndex = index;
      }),
      child: Container(
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: selectedIndex == index ? AppColor.grayWhite : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          'Add Task To improve Your Life',
          style: TextStyle(
              color: AppColor.orangeWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
