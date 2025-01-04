import 'package:excp_training/utils/constants.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:excp_training/view/widget/LoadingPage.dart';
import 'package:excp_training/view/widget/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/local_data/local_task_data.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route/app_route.dart';
import '../../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../widget/SnackBarCustom.dart';
import '../../widget/button_custom.dart';
import '../../widget/delete_show_dialog.dart';
import 'no_task_image.dart';

class TaskList extends StatefulWidget {
  TaskList({
    super.key,
    required this.index,
  });
  int index = 0;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskoCubit, TaskoState>(builder: (context, state) {
      if (state is SuccessState) {
        List<LocalTask> taskList = [];
        switch (widget.index) {
          case 0:
            taskList = state.localNewTask;
            break;
          case 1:
            taskList = state.localCompletedTask;
            break;
          case 2:
            taskList = state.localAllTask;
            break;
        }
        return Container(
          padding: const EdgeInsets.only(bottom: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColor.white,
          child: taskList.isEmpty
              ? NoTaskImage.build()
              : ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: Card(
                        elevation:
                            8.0, // Adjust the elevation for shadow intensity
                        shadowColor: Colors.grey
                            .withOpacity(0.5), // Shadow color with opacity
                        child: Row(
                          children: [
                            Container(
                              height: 65,
                              width: 20,
                              decoration: BoxDecoration(
                                color: taskList[index].isNew
                                    ? AppColor.orangeWhite
                                    : AppColor.green,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                onLongPress: () {
                                  DeleteShowDialog.build(
                                    title: 'Do you want to delete this Task Type !',
                                      context: context,
                                      onTapYes: () {
                                        BlocProvider.of<TaskItemCubit>(context)
                                            .deleteTask(
                                          deletedTask:  taskList[index],
                                        );
                                        BlocProvider.of<TaskoCubit>(context)
                                            .getAllLocalTask();
                                      });
                                  // deleteShowDialog(context, taskList, index);
                                },
                                onTap: () {
                                  BlocProvider.of<TaskItemCubit>(context)
                                      .getLocalTask(
                                    selectedTask: taskList[index],
                                  );
                                  BlocProvider.of<TaskTypeCubit>(context)
                                      .getTaskTypeList();
                                  Navigator.pushNamed(
                                      context, AppRoute.taskDetail);
                                },
                                leading: Text(
                                  taskList[index].taskName,
                                  style: const TextStyle(
                                      color: AppColor.grayDark,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      taskList[index].isNew
                                          ? 'New Task'
                                          : 'Completed',
                                      style: TextStyle(
                                          color: taskList[index].isNew
                                              ? AppColor.orangeWhite
                                              : AppColor.green,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      taskList[index].dateTime,
                                      style: const TextStyle(
                                          color: AppColor.grayDark,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      } else if (state is LoadingState) {
        return const LoadingPage();
      } else {
        return ErrorPage(
          errorMessage: 'Something went wrong State : $state',
        );
      }
    });
  }

  // Future<dynamic> deleteShowDialog(
  //     BuildContext context, List<LocalTask> taskList, int index) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       alignment: Alignment.center,
  //       actionsOverflowAlignment: OverflowBarAlignment.center,
  //       content: const Text(
  //         'Do you want to delete this task !',
  //         style: TextStyle(color: AppColor.grayDark, fontSize: 15),
  //       ),
  //       actions: [
  //         ButtonCustom.build(
  //             buttonColor: AppColor.orangeDark,
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             title: 'NO',
  //             width: 120),
  //         ButtonCustom.build(
  //             buttonColor: AppColor.green,
  //             onPressed: () {
  //               BlocProvider.of<TaskItemCubit>(context).deleteTask(
  //                 deletedTask: taskList[index],
  //               );
  //               Navigator.pop(context);
  //               BlocProvider.of<TaskoCubit>(context).getAllLocalTask();
  //             },
  //             title: 'YES',
  //             width: 120),
  //       ],
  //     ),
  //   );
  // }
}
