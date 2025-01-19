import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view/tasks/task_type.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../model/local_data/local_task_data.dart';
import '../../view model/cubit/task_type/task_type_cubit.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';

// ignore: must_be_immutable
class EditTaskDetail extends StatefulWidget {
  const EditTaskDetail({super.key});

  @override
  State<EditTaskDetail> createState() => _EditTaskDetailState();
}

class _EditTaskDetailState extends State<EditTaskDetail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int selectedTaskID;
  late bool selectedTaskisNew;
  late TextEditingController conDateTime;
  late TextEditingController conTaskName;
  late TextEditingController conTaskType;
  late TextEditingController conTaskDescription;

  List<String> taskTypeList = [];

  String date = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    TaskModelID selectedTask =
        BlocProvider.of<TaskItemCubit>(context).selectedTask!;
    taskTypeList = BlocProvider.of<TaskTypeCubit>(context).allTypeList!;
    //selectedTaskID = selectedTask.id!;
    selectedTaskisNew = selectedTask.task!.isNew!;
    conTaskName = TextEditingController(text: selectedTask.task!.name);
    conTaskType = TextEditingController(text: selectedTask.task!.type);
    conTaskDescription =
        TextEditingController(text: selectedTask.task!.description);
    conDateTime = TextEditingController(text: selectedTask.task!.dateAndTime);
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
      body: SingleChildScrollView(
        child: Column(
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
                    readOnly: true,
                    controller: conTaskType,
                    lableText: 'Type',
                    errorMessage: "Enter Task Type",
                    suffixWidget: PopupMenuButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 35,
                      onSelected: (String value) {
                        setState(() {
                          conTaskType.text = value;
                        });
                      },
                      itemBuilder: (context) => List.generate(
                        taskTypeList.length,
                        (index) => PopupMenuItem(
                          value: taskTypeList[index],
                          child: Text(taskTypeList[index]),
                        ),
                      ),
                    ),
                  ),
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
                  FormSubmitButtonCustom.build(
                    context: context,
                    formKey: formKey,
                    onValidate: () {
                      BlocProvider.of<TaskItemCubit>(context).editTaskDetail(
                        TaskModel(
                            name: conTaskName.text,
                            type: conTaskType.text,
                            description: conTaskDescription.text,
                            dateAndTime: conDateTime.text,
                            isNew: selectedTaskisNew),
                      );
                      BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

        SnackBarCustom.build(
            message: 'Enter date and time correctly', context: context);
      });
    }
  }
}
