import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../model/models/task_model.dart';
import '../../view model/cubit/task_type/task_type_cubit.dart';
import '../widget/LoadingPage.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/error_page.dart';
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
    conTaskType = TextEditingController(text: 'test type');
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
    //return _addNewTaskBuild(context);
    return BlocBuilder<TaskItemCubit, TaskItemState>(
      builder: (context, state) {
        if (state is TaskItemInitial || state is TaskItemSuccess) {
          return _addNewTaskBuild(context);
        } else if (state is TaskItemLoading) {
          return const LoadingPage();
        } else {
          return ErrorPage(
            errorMessage: state.toString(),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }

  Scaffold _addNewTaskBuild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Task'),
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
                    lableText: 'Task',
                    errorMessage: "Enter Task Name",
                  ),
                  BlocBuilder<TaskTypeCubit, TaskTypeState>(
                      builder: (context, state) {
                    if (state is TaskTypeSuccess) {
                      return TextFormCustom(
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
                            state.allTaskTypeList.length,
                            (index) => PopupMenuItem(
                              value: state.allTaskTypeList[index],
                              child: Text(state.allTaskTypeList[index]),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
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
                      
                      // FocusScope.of(context).unfocus();
                      setState(() {});

                      _selectDate();
                    },
                  ),
                  const SizedBox(height: 16),
                  FormSubmitButtonCustom.build(
                      context: context,
                      formKey: formKey,
                      onValidate: () async {
                        await BlocProvider.of<TaskItemCubit>(context)
                            .addNewTask(
                          newTask: TaskModel(
                              name: conTaskName.text,
                              type: conTaskType.text,
                              description: conTaskDescription.text,
                              dateAndTime: conDateTime.text,
                              isNew: true),
                        );
                        BlocProvider.of<TaskoCubit>(context)
                            .getFirestoreTasks();
                        setState(() {});
                        Navigator.pushReplacementNamed(
                            context, AppRoute.homePage);
                      })
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
