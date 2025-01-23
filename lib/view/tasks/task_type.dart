import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view%20model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:excp_training/view/tasks/widget/offline_type.dart';
import 'package:excp_training/view/widget/delete_show_dialog.dart';
import 'package:excp_training/view/widget/form_submit_button.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../utils/constants.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../widget/page_loading_state.dart';
import '../widget/page_error_state.dart';
import '../widget/show_date_listTile.dart';

class TaskType extends StatefulWidget {
  const TaskType({super.key});

  @override
  State<TaskType> createState() => _TaskTypeState();
}

class _TaskTypeState extends State<TaskType> {
  TextEditingController conTaskType = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool addMode = false;
  @override
  void dispose() {
    conTaskType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
      builder: (context, internetState) {
        if (internetState.isConnected) {
          return BlocBuilder<TaskTypeCubit, TaskTypeState>(
            builder: (context, typeState) {
              if (typeState is TaskTypeInitial) {
                return PageError(
                    errorMessage: 'Restore Connection Login Again');
              } else if (typeState is TaskTypeSuccess) {
                return _taskTypeBuild(typeState);
              } else if (typeState is TaskTypeLoading) {
                return const PageLoading();
              } else if (typeState is TaskTypeError) {
                return PageError(
                  errorMessage: typeState.errorMessage,
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              } else {
                return PageError(errorMessage: typeState.toString());
              }
            },
          );
        } else {
          List<String> addedType = HiveFun.getTypeInfo();
          return OfflineType(addedType: addedType);
        }
      },
    );
  }

  Scaffold _taskTypeBuild(TaskTypeSuccess state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Type',
          style: TextStyle(
            color: AppColor.grayDark,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonColor,
        child: const Icon(
          Icons.add,
          size: 50,
          color: AppColor.white,
        ),
        onPressed: () {
          setState(() {
            conTaskType.clear();
            addMode = !addMode;
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add New Task Type'),
              content: Container(
                height: mediaHeight * 0.3,
                width: mediaHeight,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormCustom(
                        lableText: 'New Task Type',
                        errorMessage: 'Enter Task Type',
                        controller: conTaskType,
                      ),
                      FormSubmitButtonCustom.build(
                        width: mediaWidth * 0.5,
                        context: context,
                        formKey: formKey,
                        onValidate: () async {
                          Navigator.pop(context);
                          await BlocProvider.of<TaskTypeCubit>(context)
                              .addNewType(newTaskType: conTaskType.text);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Container(
        height: mediaHeight * 0.9,
        width: mediaWidth,
        color: AppColor.grayWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('fixed Task Type'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                color: AppColor.grayWhite,
                child: ListView.builder(
                  itemCount: state.fixedTaskTypeList.length,
                  itemBuilder: (context, index) {
                    return ShowDateListTile(
                      listTileTitle: '${index + 1} ',
                      text: state.fixedTaskTypeList[index],
                    );
                  },
                ),
              ),
            ),
            const Divider(
              color: AppColor.grayDark,
            ),
            const Text('Added Task Type'),
            Expanded(
              child: Container(
                color: AppColor.grayWhite,
                child: state.addedTaskTypeList.isEmpty
                    ? const Center(
                        child: Text(
                        'No Added Task Type',
                      ))
                    : ListView.builder(
                        itemCount: state.addedTaskTypeList.length,
                        itemBuilder: (context, index) {
                          return ShowDateListTile(
                            trailing: IconButton(
                              onPressed: () async {
                                await DeleteShowDialog.build(
                                  title: 'Delete this Task Type!',
                                  content:
                                      'All Completed Task with this Type will be deleted',
                                  context: context,
                                  onTapYes: () async {
                                    await BlocProvider.of<TaskoCubit>(context)
                                        .deleteTasksWithType(
                                            type:
                                                state.addedTaskTypeList[index]);
                                    var taskoState =
                                        BlocProvider.of<TaskoCubit>(context)
                                            .state;
                                    if (taskoState is SuccessState) {
                                      if (taskoState.deleteTaskWithType) {
                                        await BlocProvider.of<TaskoCubit>(
                                                context)
                                            .getFirestoreTasks();
                                        await BlocProvider.of<TaskTypeCubit>(
                                                context)
                                            .deleteType(
                                          deletedType:
                                              state.addedTaskTypeList[index],
                                        );
                                      } else {
                                        return;
                                      }
                                    }
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete_forever_outlined,
                                color: AppColor.red,
                                size: 30,
                              ),
                            ),
                            listTileTitle: '${index + 1} ',
                            text: state.addedTaskTypeList[index],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
