import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController conDateTime;
  late TextEditingController conTaskName;
  late TextEditingController conTaskType;
  late TextEditingController conTaskDescription;
  String? date;
  String? time;
  String? taskName;

  @override
  void initState() {
    super.initState();
    conTaskName = TextEditingController();
    conTaskType = TextEditingController();
    conTaskDescription = TextEditingController();
    conDateTime = TextEditingController();
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
        title: const Text('Add New Task'),
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
                  lableText: 'Task',
                  errorMessage: "Enter Task Name",
                  onSaved: (value) => taskName = value!,
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
                const SizedBox(height: 16),
                FormSubmitButtonCustom.build(
                    context: context,
                    formKey: formKey,
                    onValidate: () {
                      setState(() {
                        LocalTask.addNewTask(
                            taskName: conTaskName.text,
                            taskType: conTaskType.text,
                            taskDescription: conTaskDescription.text,
                            dateTime: conDateTime.text);
                      }
                     
                      );
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    })
              ],
            ),
          ),
        ],
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
        SnackBarCustom.showSnackBar(
            message: 'Enter date and time correctly', context: context);
      });
    }
  }
}
