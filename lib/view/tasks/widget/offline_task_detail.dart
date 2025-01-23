import 'package:excp_training/model/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/app_color.dart';
import '../../widget/show_date_listTile.dart';
import 'text_isCompleted.dart';

class OfflineTaskDetail extends StatelessWidget {
   OfflineTaskDetail({super.key,required this.taskModel});
  TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Show Task Detail ',
          style: TextStyle(
              color: AppColor.grayDark,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.only(bottom: 5, top: 10),
            decoration: BoxDecoration(
                color: AppColor.grayWhite,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowDateListTile(
                  listTileTitle: 'Task',
                  text: taskModel.name!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Type',
                  text: taskModel.type!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Des',
                  text: taskModel.description!,
                ),
                ShowDateListTile(
                  listTileTitle: 'Date',
                  text: taskModel.dateAndTime!,
                ),
                TextIscompleted(isCompleted: taskModel.isNew!,),
                const Gap(10),
              ],
            ),
          ),
          const Gap(30),
          const Center(
            child: Text('No Internet Connection'),
          ),
        ],
      ),
    );
  }
}
