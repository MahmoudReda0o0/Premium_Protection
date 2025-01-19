import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view%20model/cubit/task_type/task_type_cubit.dart';
import 'package:excp_training/view/widget/delete_show_dialog.dart';
import 'package:excp_training/view/widget/form_submit_button.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../widget/LoadingPage.dart';
import '../widget/error_page.dart';
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
    return BlocBuilder<TaskTypeCubit, TaskTypeState>(
      builder: (context, state) {
        if (state is TaskTypeSuccess) {
          return _taskTypeBuild(state);
        } else if (state is TaskTypeLoading) {
          return const LoadingPage();
        } else if (state is TaskTypeError) {
          return ErrorPage(
            errorMessage: state.errorMessage,
            onTap: () {
              Navigator.pop(context);
            },
          );
        } else {
          return ErrorPage(errorMessage: state.toString());
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

                            // ElevatedButton(
                            //   onPressed: () {
                            //     if (conTaskType.text.isEmpty) return;
                            //     BlocProvider.of<TaskTypeCubit>(context)
                            //         .addNewTaskType(conTaskType.text);
                            //     Navigator.pop(context);
                            //   },
                            //   child: const Text('take'),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ));
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) => SizedBox(
          //     height: mediaHeight * 0.3,
          //     width: mediaWidth,
          //     child: Form(
          //       key: formKey,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           TextFormCustom(
          //             lableText: 'New Task Type',
          //             errorMessage: 'Enter Task Type',
          //             controller: conTaskType,
          //           ),
          //           FormSubmitButtonCustom.build(
          //             context: context,
          //             formKey: formKey,
          //             onValidate: () {
          //               BlocProvider.of<TaskTypeCubit>(context)
          //                   .addNewTaskType(conTaskType.text);
          //               Navigator.pop(context);
          //             },
          //           ),
          //           Gap(keyBoardHeight),
          //           // ElevatedButton(
          //           //   onPressed: () {
          //           //     if (conTaskType.text.isEmpty) return;
          //           //     BlocProvider.of<TaskTypeCubit>(context)
          //           //         .addNewTaskType(conTaskType.text);
          //           //     Navigator.pop(context);
          //           //   },
          //           //   child: const Text('take'),
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
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
                                      // await BlocProvider.of<TaskTypeCubit>(
                                      //         context)
                                      //     .deleteType(
                                      //         deletedType: state
                                      //             .addedTaskTypeList[index]);
                                      //---------------------------------------------------------------\\
                                      await BlocProvider.of<TaskoCubit>(context)
                                          .deleteTasksWithType(
                                              type: state
                                                  .addedTaskTypeList[index]);
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
                                      // BlocProvider.of<TaskoCubit>(context)
                                      //     .getFirestoreTasks();
                                    });
                                // BlocProvider.of<TaskTypeCubit>(context)
                                //     .deleteTasktype(
                                //         state.addedTaskTypeList[index]);
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
              // addMode
              //     ? SizedBox(
              //         height: 100,
              //         width: mediaWidth,
              //         //color: Colors.amber,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             TextFormCustom(
              //               lableText: 'New Task Type',
              //               errorMessage: 'Enter Task Type',
              //               controller: conTaskType,
              //             ),
              //             TextButton(
              //               style: ButtonStyle(
              //                 backgroundColor: WidgetStateProperty.all(
              //                     AppColor.buttonColor),
              //               ),
              //               onPressed: () {
              //                 // BlocProvider.of<TaskoCubit>(context)
              //                 //     .addNewTaskType(conTaskType.text);
              //                 setState(() {
              //                   addMode = false;
              //                 });
              //               },
              //               child: const Text(
              //                 'Submit',
              //                 style: TextStyle(
              //                     color: AppColor.white,
              //                     fontSize: 30,
              //                     fontWeight: FontWeight.bold),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(
              //         color: AppColor.grayWhite,
              //         child: state.addedTaskTypeList.isEmpty
              //             ? const Center(
              //                 child: Text(
              //                 'No Added Task Type',
              //               ))
              //             : ListView.builder(
              //                 itemCount: state.addedTaskTypeList.length,
              //                 itemBuilder: (context, index) {
              //                   return ShowDateListTile(
              //                     listTileTitle: '${index + 1} ',
              //                     text: state.addedTaskTypeList[index],
              //                   );
              //                 },
              //               ),
              //       ),
            ),
          ],
        ),
      ),
    );
  }
}
