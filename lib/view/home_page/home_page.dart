import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/model/local_data/local_task_data.dart';

import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';

import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/tasks/show_task_detail.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/route/app_route.dart';
import '../widget/SnackBarCustom.dart';
import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonColor,
        child: const Icon(
          Icons.add,
          size: 50,
          color: AppColor.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.addNewTask);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AddNewTask()));

          SnackBarCustom.build(message: 'list[1]', context: context);
        },
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      drawer: const HomeDrawer(),
      body: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return homePageBuild(context, state);
          } else {
            return Center(
              child: Text('Error :$state'),
            );
          }
        },
      ),
    );
  }

  Container homePageBuild(BuildContext context, SuccessState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColor.white,
      child: state.localTask.isEmpty
          ? noTaskList(context)
          : ListView.builder(
              itemCount: state.localTask.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Card(
                    elevation: 8.0, // Adjust the elevation for shadow intensity
                    shadowColor: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    child: Row(
                      children: [
                        Container(
                          height: 65,
                          width: 20,
                          decoration: BoxDecoration(
                            color: state.localTask[index].isNew
                                ? AppColor.orangeWhite
                                : AppColor.green,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              BlocProvider.of<TaskoCubit>(context)
                                  .getLocalTaskIndex(index: index);
                            },
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ShowTaskDetail(
                            //       taskInfo: state.localTask[index],
                            //     ),
                            //   ),
                            // ),
                            leading: Text(
                              state.localTask[index].taskName,
                              style: const TextStyle(
                                  color: AppColor.grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  state.localTask[index].isNew
                                      ? 'New Task'
                                      : 'Completed',
                                  style: TextStyle(
                                      color: state.localTask[index].isNew
                                          ? AppColor.orangeWhite
                                          : AppColor.green,
                                      fontSize: 12),
                                ),
                                Text(
                                  state.localTask[index].dateTime,
                                  style: TextStyle(
                                      color: AppColor.grayDark, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 60,
                //         width: 20,
                //         color: Constant.green,
                //       ),
                //       Expanded(
                //         child: Card(
                //           child: ListTile(
                //             onTap: () {
                //               BlocProvider.of<TaskoCubit>(context)
                //                 ..getLocalTaskIndex(index: index)
                //                 ..openShowTaskDetail();
                //             },
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => ShowTaskDetail(
                //             //       taskInfo: state.localTask[index],
                //             //     ),
                //             //   ),
                //             // ),
                //             leading: Text(state.localTask[index].taskName),
                //             trailing: Column(
                //               mainAxisAlignment:
                //                   MainAxisAlignment.spaceAround,
                //               children: [
                //                 Text(state.localTask[index].isNew
                //                     ? 'Not Completed'
                //                     : 'Completed'),
                //                 Text(state.localTask[index].dateTime),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
    );
  }

  Column noTaskList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(180),
        ContainerImageCustom(
          height: 300,
          width: MediaQuery.of(context).size.width,
          image: 'assets/working.gif',
          fit: BoxFit.fitHeight,
        ),
        const Text(
          'Do Task To Change Your Life',
          style: TextStyle(
              color: AppColor.orangeWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
