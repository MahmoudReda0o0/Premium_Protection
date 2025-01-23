import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:excp_training/view/widget/page_initial_state.dart';
import 'package:excp_training/view/widget/page_loading_state.dart';
import 'package:excp_training/view/widget/page_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route/app_route.dart';
import '../../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../widget/delete_show_dialog.dart';
import 'no_task_image.dart';

class OnlineTaskList extends StatefulWidget {
  OnlineTaskList({
    super.key,
    required this.index,
  });
  int index = 0;

  @override
  State<OnlineTaskList> createState() => _OnlineTaskListState();
}

class _OnlineTaskListState extends State<OnlineTaskList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskoCubit, TaskoState>(
      builder: (context, state) {
        if (state is InitialState) {
          return const PageInitial();
        } else if (state is SuccessState) {
          List<TaskModelID> taskList = [];
          switch (widget.index) {
            case 0:
              taskList = state.newTask;
              break;
            case 1:
              taskList = state.completedTask;
              break;
            case 2:
              taskList = state.allTask;
              break;
          }
          return _buildScreen(context, taskList);
        } else if (state is LoadingState) {
          return const PageLoading();
        } else if (state is ErrorState) {
          return PageError(
            errorMessage: state.errorMessage,
            onTap: () {
              Navigator.pop(context);
            },
          );
        } else {
          return PageError(
            errorMessage: 'Something went wrong State : $state',
          );
        }
      },
    );
  }
}

Container _buildScreen(BuildContext context, List<TaskModelID> taskList) {
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
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Card(
                  elevation: 8.0, // Adjust the elevation for shadow intensity
                  shadowColor:
                      Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  child: Row(
                    children: [
                      Container(
                        height: 65,
                        width: 20,
                        decoration: BoxDecoration(
                          color: taskList[index].task!.isNew!
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
                                    deletedTask: taskList[index],
                                  );
                                  BlocProvider.of<TaskoCubit>(context)
                                      .getFirestoreTasks();
                                });
                            // deleteShowDialog(context, taskList, index);
                          },
                          onTap: () {
                            BlocProvider.of<TaskItemCubit>(context)
                                .getTaskItemInfo(
                              selectedTask: taskList[index],
                            );
                            BlocProvider.of<TaskTypeCubit>(context)
                                .getTaskTypeList();
                            Navigator.pushNamed(context, AppRoute.taskDetail);
                          },
                          leading: Text(
                            taskList[index].task!.name!,
                            style: const TextStyle(
                                color: AppColor.grayDark,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                taskList[index].task!.isNew!
                                    ? 'New Task'
                                    : 'Completed',
                                style: TextStyle(
                                    color: taskList[index].task!.isNew!
                                        ? AppColor.orangeWhite
                                        : AppColor.green,
                                    fontSize: 12),
                              ),
                              Text(
                                taskList[index].task!.dateAndTime!,
                                style: const TextStyle(
                                    color: AppColor.grayDark, fontSize: 12),
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

