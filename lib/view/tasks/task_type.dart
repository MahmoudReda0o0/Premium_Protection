import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view/widget/button_custom.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/constants.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../widget/show_date_listTile.dart';

class TaskType extends StatefulWidget {
  const TaskType({super.key});

  @override
  State<TaskType> createState() => _TaskTypeState();
}

class _TaskTypeState extends State<TaskType> {
  TextEditingController conTaskType = TextEditingController();
  bool addMode = false;
  @override
  void dispose() {
    conTaskType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) => SizedBox(
          //     height: mediaHeight * 0.3,
          //     width: mediaWidth,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         TextFormCustom(
          //           lableText: 'New Task Type',
          //           errorMessage: 'Enter Task Type',
          //           controller: conTaskType,
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
          //             BlocProvider.of<TaskoCubit>(context)
          //                 .addNewTaskType(conTaskType.text);
          //             Navigator.pop(context);
          //           },
          //           child: const Text('take'),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        },
      ),
      body: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is TaskTypeState) {
            return Container(
              height: mediaHeight * 0.9,
              width: mediaWidth,
              color: AppColor.grayWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Fixed Task Type'),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 15),
                      color: AppColor.grayWhite,
                      child: ListView.builder(
                        itemCount: state.fixedTaskType.length,
                        itemBuilder: (context, index) {
                          return ShowDateListTile(
                            listTileTitle: '${index + 1} ',
                            text: '${state.fixedTaskType[index]}',
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
                    child: addMode
                        ? SizedBox(
                            height: 100,
                            width: mediaWidth,
                            //color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormCustom(
                                  lableText: 'New Task Type',
                                  errorMessage: 'Enter Task Type',
                                  controller: conTaskType,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        AppColor.buttonColor),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<TaskoCubit>(context)
                                        .addNewTaskType(conTaskType.text);
                                    setState(() {
                                      addMode = false;
                                    });
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            color: AppColor.grayWhite,
                            child: state.addedTaskType.isEmpty
                                ? const Center(
                                    child: Text(
                                    'No Added Task Type',
                                  ))
                                : ListView.builder(
                                    itemCount: state.addedTaskType.length,
                                    itemBuilder: (context, index) {
                                      return ShowDateListTile(
                                        listTileTitle: '${index + 1} ',
                                        text: '${state.addedTaskType[index]}',
                                      );
                                    },
                                  ),
                          ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
