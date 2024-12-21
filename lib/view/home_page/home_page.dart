import 'package:excp_training/constant/constant.dart';
import 'package:excp_training/model/local_data/local_task_data.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/tasks/show_task_detail.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


import '../widget/SnackBarCustom.dart';
import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.orangeGradientLight,
        child: const Icon(
          Icons.add,
          size: 50,
          color: Constant.whiteColor,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewTask()));
          setState(() {
            list.add('mahmoud');
          });

          SnackBarCustom.showSnackBar(message: 'list[1]', context: context);
        },
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      drawer: const HomeDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Constant.whiteColor,
        child: LocalTask.list.isEmpty
            ? noTaskList(context)
            : ListView.builder(
                itemCount: LocalTask.list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                        child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowTaskDetail(
                            taskInfo: LocalTask.list[index],
                          ),
                        ),
                      ),
                      leading: Text(LocalTask.list[index].taskName),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(LocalTask.list[index].isNew
                              ? 'Not Completed'
                              : 'Completed'),
                          Text(LocalTask.list[index].dateTime),
                        ],
                      ),
                    )),
                  );
                },
              ),
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
              color: Constant.pinkAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
