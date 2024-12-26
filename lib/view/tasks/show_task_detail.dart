import 'package:excp_training/constant/constant.dart';
import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/button_custom.dart';

import '../widget/show_date_listTile.dart';
import 'edit_task_detail.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Show Task Detail '),
      ),
      body: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is ShowTaskDetailState) {
            return Column(
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  decoration: BoxDecoration(
                      color: Constant.darkGray,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShowDateListTile(
                        listTileTitle: 'Task',
                        text: state.localTaskItem.taskName,
                      ),
                      ShowDateListTile(
                        listTileTitle: 'Type',
                        text: state.localTaskItem.taskType,
                      ),
                      ShowDateListTile(
                        listTileTitle: 'Des',
                        text: state.localTaskItem.taskDescription,
                      ),
                      ShowDateListTile(
                        listTileTitle: 'Date',
                        text: state.localTaskItem.dateTime,
                      ),
                      isCompletedTask(),
                      const Gap(10),
                      // showTaskDetailListTile(listTileTitle: 'Time', text: widget.taskInfo.taskTime!),
                    ],
                  ),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonCustom.build(
                          title: 'Finish Task',
                          buttonColor: Constant.brightGreent,
                          textColor: Constant.whiteColor,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              alignment: Alignment.center,
                              actionsOverflowAlignment:
                                  OverflowBarAlignment.center,
                              content:
                                  const Text('Did you want finish this task?'),
                              actions: [
                                ButtonCustom.build(
                                    buttonColor: Constant.pinkAccent,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      SnackBarCustom.build(
                                          message: 'Change Your Mind',
                                          context: context);
                                    },
                                    title: 'NO',
                                    width: 120),
                                ButtonCustom.build(
                                    buttonColor: Constant.brightGreent,
                                    onPressed: () {
                                      state.localTaskItem.isNew = false;
                                      setState(() {});
                                      Navigator.pop(context);
                                      BlocProvider.of<TaskoCubit>(context)
                                          .editTaskComplete();
                                    },
                                    title: 'YES',
                                    width: 120),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: ButtonCustom.build(
                            title: 'Edit Task',
                            buttonColor: Constant.orangeGradientLight,
                            textColor: Constant.whiteColor,
                            onPressed: () {
                              BlocProvider.of<TaskoCubit>(context)
                                  .openEditTaskDetail(
                                      localTask: state.localTaskItem);
                            }
                            //  Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditTaskDetail(
                            //       taskInfo: state.localTaskItem,
                            //     ),
                            //   ),
                            // ),
                            ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }

  Container isCompletedTask() {
    return Container(
      height: 50,
      width: mediaWidth * 0.5,
      decoration: BoxDecoration(
        color: Constant.whiteGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is ShowTaskDetailState) {
            return Center(
              child: Text(
                state.localTaskItem.isNew ? 'Not Completed' : 'Completed ',
                style: TextStyle(
                  color: state.localTaskItem.isNew
                      ? Constant.pinkAccent
                      : Constant.brightGreent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Center(
              child: Text('error'),
            );
          }
        },
      ),
    );
  }

  // Widget taskIsDoneButton(
  //     {required bool taskBoolValue,
  //     required bool buttonBoolValue,
  //     // required String title,
  //     // required Color activeColor,
  //     // required Color secondColor,
  //     }) {
  //   return Expanded(
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             //side: const BorderSide(color: Colors.red),
  //           ),
  //         ),
  //         backgroundColor:
  //             WidgetStateProperty.all<Color>(isNew ? activeColor : secondColor),
  //       ),
  //       onPressed: () {
  //         setState(() {
  //           isTaskNew = !isNew;
  //         });
  //       },
  //       child: Center(
  //         child: Text(title, style: const TextStyle(color: Colors.white),),
  //       ),
  //     ),
  //   );
  // }
}
