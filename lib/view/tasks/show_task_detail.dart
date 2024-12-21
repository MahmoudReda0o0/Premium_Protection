import 'package:excp_training/constant/constant.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';



import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/button_custom.dart';

import 'edit_task_detail.dart';

class ShowTaskDetail extends StatefulWidget {
  ShowTaskDetail({super.key, required this.taskInfo});

  TaskInfo taskInfo;
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
      body: Column(
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
                showTaskDetailListTile(
                  listTileTitle: 'Task',
                  text: widget.taskInfo.taskName,
                ),
                showTaskDetailListTile(
                  listTileTitle: 'Type',
                  text: widget.taskInfo.taskType,
                ),
                showTaskDetailListTile(
                  listTileTitle: 'Des',
                  text: widget.taskInfo.taskDescription,
                ),
                showTaskDetailListTile(
                  listTileTitle: 'Date',
                  text: widget.taskInfo.dateTime,
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
                        actionsOverflowAlignment: OverflowBarAlignment.center,
                        content: const Text('Did you want finish this task?'),
                        actions: [
                          ButtonCustom.build(
                              buttonColor: Constant.pinkAccent,
                              onPressed: () {
                                Navigator.pop(context);
                                SnackBarCustom.showSnackBar(
                                    message: 'Change Your Mind',
                                    context: context);
                              },
                              title: 'NO',
                              width: 120),
                          ButtonCustom.build(
                              buttonColor: Constant.brightGreent,
                              onPressed: () {
                                widget.taskInfo.isNew = false;
                                setState(() {});
                                Navigator.pop(context);
                                SnackBarCustom.showSnackBar(
                                    message: 'Go Do Your Task Lazy Boy',
                                    context: context);
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskDetail(
                          taskInfo: widget.taskInfo,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
      child: Center(
        child: Text(
          widget.taskInfo.isNew ? 'Not Completed' : 'Completed ',
          style: TextStyle(
            color: widget.taskInfo.isNew
                ? Constant.pinkAccent
                : Constant.brightGreent,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container showTaskDetailListTile(
      {required String listTileTitle, required String text}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Constant.whiteGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: Constant.blackColor,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
        leading: Text(
          '$listTileTitle : ',
          style: const TextStyle(
            color: Constant.darkGray,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
