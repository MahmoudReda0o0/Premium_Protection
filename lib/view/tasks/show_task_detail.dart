import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view%20model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view/tasks/widget/offline_task_detail.dart';

//import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/widget/page_error_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../model/x/local_task_data.dart';
import '../../utils/constants.dart';
import '../../utils/route/app_route.dart';
import '../widget/page_loading_state.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/button_custom.dart';

import '../widget/delete_show_dialog.dart';
import '../widget/show_date_listTile.dart';
import 'edit_task_detail.dart';
import 'widget/text_isCompleted.dart';

class ShowTaskDetail extends StatefulWidget {
  const ShowTaskDetail({super.key});

  @override
  State<ShowTaskDetail> createState() => _ShowTaskDetailState();
}

class _ShowTaskDetailState extends State<ShowTaskDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // late String conDateTime;
  // late String conTaskName;
  // late String conTaskType;
  // late String conTaskDescription;
  // late bool isTaskNew;
  // String datetime = '';
  //late LocalTask selectedTask;
  @override
  void initState() {
    super.initState();
    //selectedTask = BlocProvider.of<TaskoCubit>(context).selectedTask!;
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
        builder: (context, internetState) {
      if (internetState.isConnected) {
        return BlocBuilder<TaskItemCubit, TaskItemState>(
          builder: (context, taskState) {
            if (taskState is TaskItemSuccess) {
              return showTaskDetailBuild(context, taskState);
            } else if (taskState is TaskItemLoading) {
              return const PageLoading();
            }else if(taskState is TaskItemError){
              return PageError(
                errorMessage: taskState.errorMessage,
                onTap: () {
                  Navigator.pop(context);
                },
              );
            } 
            else {
              return PageError(
                errorMessage: taskState.toString(),
                onTap: () {
                  Navigator.pop(context);
                },
              );
            }
          },
        );
      } else {
       TaskModel taskModel = HiveFun.getTaskModel();  // Hive Put Local Task Model
        return OfflineTaskDetail(taskModel: taskModel,);
      }
    });
  }

  Scaffold showTaskDetailBuild(BuildContext context, TaskItemSuccess state) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Show Task Detail ',
          style: TextStyle(
              color: AppColor.grayDark,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete,
                color: AppColor.red,
                size: 30,
              ),
              onPressed: () async {
                await DeleteShowDialog.build(
                    title: ' Delete this task !',
                    context: context,
                    onTapYes: () {
                      BlocProvider.of<TaskItemCubit>(context).deleteTask(
                        deletedTask: state.selectedTask,
                      );
                      BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
                    });
                Navigator.pushReplacementNamed(context, AppRoute.homePage);
              })
        ],
      ),
      body: Column(
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.only(bottom: 5, top: 10),
            decoration: BoxDecoration(
                color: AppColor.grayWhite,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowDateListTile(
                  listTileTitle: 'Task',
                  text: state.selectedTask.task!.name!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Type',
                  text: state.selectedTask.task!.type!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Des',
                  text: state.selectedTask.task!.description!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Date',
                  text: state.selectedTask.task!.dateAndTime!,
                ),
                TextIscompleted(isCompleted: state.selectedTask.task!.isNew!),
                const Gap(10),
              ],
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                finishTaskButton(context, state),
                const Gap(20),
                Expanded(
                  child: ButtonCustom.build(
                      title: 'Edit Task',
                      buttonColor: AppColor.buttonColor,
                      textColor: AppColor.white,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.editTaskDetail);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded finishTaskButton(BuildContext context, TaskItemSuccess state) {
    return Expanded(
      child: ButtonCustom.build(
        buttonColor: state.selectedTask.task!.isNew!
            ? AppColor.green
            : AppColor.orangeDark,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            alignment: Alignment.center,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            content: const Text(
              'Did you finish this task !',
              style: TextStyle(color: AppColor.grayDark, fontSize: 15),
            ),
            actions: [
              ButtonCustom.build(
                  buttonColor: AppColor.orangeDark,
                  onPressed: () {
                    Navigator.pop(context);
                    // SnackBarCustom.build(
                    //     message: 'Change Your Mind', context: context);
                  },
                  title: 'NO',
                  width: 120),
              ButtonCustom.build(
                  buttonColor: AppColor.green,
                  onPressed: () async {
                    //selectedTask.isNew = false;
                    await BlocProvider.of<TaskItemCubit>(context)
                        .editTaskComplete();
                    BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
                    setState(() {});
                    Navigator.pop(context);
                  },
                  title: 'YES',
                  width: 120),
            ],
          ),
        ),
        title: 'Finish Task',
        //title: state.selectedTask.task!.isNew! ? 'Finish Task' : 'Redo Task',
      ),
    );
  }

  
}
