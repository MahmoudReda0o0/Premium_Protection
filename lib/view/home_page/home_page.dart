import 'package:excp_training/constant/constant.dart';
import 'package:excp_training/model/local_data/local_task_data.dart';
import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/tasks/show_task_detail.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widget/SnackBarCustom.dart';
import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.orangeGradientLight,
        child: const Icon(
          Icons.add,
          size: 50,
          color: Constant.whiteColor,
        ),
        onPressed: () {
          BlocProvider.of<TaskoCubit>(context).openAddNewTask();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AddNewTask()));

          SnackBarCustom.build(message: 'list[1]', context: context);
        },
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      drawer: const HomeDrawer(),
      body: BlocBuilder<TaskoCubit, TaskoState>(builder: (context, state) {
        if (state is HomeState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Constant.whiteColor,
            child: state.localTask.isEmpty
                ? noTaskList(context)
                : ListView.builder(
                    itemCount: state.localTask.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                            child: ListTile(
                          onTap: () {
                            BlocProvider.of<TaskoCubit>(context)
                              ..getLocalTaskIndex(index: index)
                              ..openShowTaskDetail();
                          },
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ShowTaskDetail(
                          //       taskInfo: state.localTask[index],
                          //     ),
                          //   ),
                          // ),
                          leading: Text(state.localTask[index].taskName),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(state.localTask[index].isNew
                                  ? 'Not Completed'
                                  : 'Completed'),
                              Text(state.localTask[index].dateTime),
                            ],
                          ),
                        )),
                      );
                    },
                  ),
          );
        } else {
          return Center(
            child: Text('Error '),
          );
        }
      }),
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
              color: Constant.pinkAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
