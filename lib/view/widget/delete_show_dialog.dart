import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/local_data/local_task_data.dart';
import '../../utils/app_color.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../view model/cubit/task_item/task_item_cubit.dart';
import 'button_custom.dart';

class DeleteShowDialog {
  static Future<dynamic> build({
    required BuildContext context,
    required LocalTask selectedTask,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        content: const Text(
          'Do you want to delete this task !',
          style: TextStyle(color: AppColor.grayDark, fontSize: 15),
        ),
        actions: [
          ButtonCustom.build(
              buttonColor: AppColor.orangeDark,
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'NO',
              width: 120),
          ButtonCustom.build(
              buttonColor: AppColor.green,
              onPressed: () {
                BlocProvider.of<TaskItemCubit>(context).deleteTask(
                  deletedTask: selectedTask,
                );
                BlocProvider.of<TaskoCubit>(context).getAllLocalTask();
                Navigator.pop(context);
              },
              title: 'YES',
              width: 120),
        ],
      ),
    );
  }
}
