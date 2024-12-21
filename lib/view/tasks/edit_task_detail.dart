import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';

// ignore: must_be_immutable
class EditTaskDetail extends StatefulWidget {
  EditTaskDetail({super.key, required this.taskInfo});

  LocalTask taskInfo;
  @override
  State<EditTaskDetail> createState() => _EditTaskDetailState();
}

class _EditTaskDetailState extends State<EditTaskDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController conDateTime;
  late TextEditingController conTaskName;
  late TextEditingController conTaskType;
  late TextEditingController conTaskDescription;
  late bool isTaskNew;
  String date = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    conTaskName = TextEditingController(text: widget.taskInfo.taskName);
    conTaskType = TextEditingController(text: widget.taskInfo.taskType);
    conTaskDescription =
        TextEditingController(text: widget.taskInfo.taskDescription);
    conDateTime = TextEditingController(text: widget.taskInfo.dateTime);
    isTaskNew = widget.taskInfo.isNew;
  }

  @override
  void dispose() {
    conTaskName.dispose();
    conTaskType.dispose();
    conTaskDescription.dispose();
    conDateTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Task Detail '),
      ),
      body: Column(
        children: [
          const Gap(20),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormCustom(
                  controller: conTaskName,
                  lableText: 'task name',
                  errorMessage: "Enter Task Name",
                  // onSaved: (value) => taskName = value!,
                ),
                TextFormCustom(
                    controller: conTaskType,
                    lableText: 'Type',
                    errorMessage: "Enter Task Type"),
                TextFormCustom(
                    controller: conTaskDescription,
                    lableText: 'Description',
                    errorMessage: "Enter Task Description"),
                TextFormCustom(
                  controller: conDateTime,
                  lableText: ' Date and Time',
                  errorMessage: 'Enter Date and Time',
                  readOnly: true,
                  iconDate: Icons.calendar_today,
                  iconOnTap: () {
                    _selectDate();
                  },
                ),
                const Gap(20),

                // Container(
                //   height: 50,
                //   width: mediaWidth * 0.9,
                //   child: Row(
                //     children: [
                //       taskIsDoneButton(
                //         isNew: isTaskNew,
                //         title: 'New Task',
                //         activeColor: Constant.brightGreent,
                //         secondColor: Constant.cardColor,
                //       ),
                //       Gap(8),
                //       taskIsDoneButton(isNew: !isTaskNew,
                //           title: 'Done Task',
                //           activeColor: Constant.softBlue,
                //           secondColor: Constant.cardColor),
                //     ],
                //   ),
                // ),
                FormSubmitButtonCustom.build(
                    context: context, formKey: formKey, onTap: () {})
              ],
            ),
          ),
        ],
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

  _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null && pickedTime != null) {
      setState(() {
        date = DateFormat('yyyy-MM-dd').format(pickedDate);
        time = pickedTime.format(context);
        conDateTime.text = '$date  /  $time';
      });
    } else {
      setState(() {
        date = '';
        time = '';
        conDateTime.text = '';
        SnackBarCustom.showSnackBar(
            message: 'Enter date and time correctly', context: context);
      });
    }
  }
}
