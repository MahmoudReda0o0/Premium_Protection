import 'package:excp_training/model/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/hive/hive_fun.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route/app_route.dart';
import 'no_task_image.dart';

class OfflineTaskList extends StatelessWidget {
  OfflineTaskList({super.key, required this.taskList});
  List<TaskModel> taskList;

  @override
  Widget build(BuildContext context) {
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
                    shadowColor: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    child: Row(
                      children: [
                        Container(
                          height: 65,
                          width: 20,
                          decoration: BoxDecoration(
                            color: taskList[index].isNew!
                                ? AppColor.orangeWhite
                                : AppColor.green,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            // onLongPress: () {
                            //   DeleteShowDialog.build(
                            //       title:
                            //           'Do you want to delete this Task Type !',
                            //       context: context,
                            //       onTapYes: () {
                            //         BlocProvider.of<TaskItemCubit>(context)
                            //             .deleteTask(
                            //           deletedTask: taskList[index],
                            //         );
                            //         BlocProvider.of<TaskoCubit>(context)
                            //             .getFirestoreTasks();
                            //       });
                            //   // deleteShowDialog(context, taskList, index);
                            // },
                            onTap: () async {
                              // BlocProvider.of<TaskItemCubit>(context)
                              //     .getTaskItemInfo(
                              //   selectedTask: taskList[index],
                              // );
                              // BlocProvider.of<TaskTypeCubit>(context)
                              //     .getTaskTypeList();
                              await HiveFun.putTaskModel(taskModel:taskList[index]);  // Hive Put Local Task Model
                              Navigator.pushNamed(context, AppRoute.taskDetail);
                            },
                            leading: Text(
                              taskList[index].name!,
                              style: const TextStyle(
                                  color: AppColor.grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  taskList[index].isNew!
                                      ? 'New Task'
                                      : 'Completed',
                                  style: TextStyle(
                                      color: taskList[index].isNew!
                                          ? AppColor.orangeWhite
                                          : AppColor.green,
                                      fontSize: 12),
                                ),
                                Text(
                                  taskList[index].dateAndTime!,
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
    ;
  }
}
