import 'package:flutter/material.dart';

import '../../utils/android_home_page/android_home_page.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  List<String> task = [];
  TextEditingController conTask = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final Student student =
    //     ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: TextField(
                controller: conTask,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    AndroidWidgetManager.saveTask(conTask.text);
                    setState(() {
                      task.add(conTask.text);
                    });
                    conTask.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: task.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(task[index]),
          );
        },
      ),
    );
  }
}
