import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/task_item/task_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_color.dart';

class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Normal'),
          onTap: () {
            BlocProvider.of<TaskoCubit>(context).getAllLocalTask();
            //Navigator.pushNamed(context, AppRoute.changePassword);
          },
        ),
        PopupMenuItem(
          child: const Text('Time'),
          onTap: () {
            BlocProvider.of<TaskoCubit>(context).sortLocalTaskByTime();
          },
        )
      ],
      child: const Icon(Icons.sort_outlined, color: AppColor.buttonColor),
    );
  }
}
