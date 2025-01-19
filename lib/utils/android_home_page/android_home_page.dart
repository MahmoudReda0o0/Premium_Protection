import 'package:excp_training/main.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const platform = MethodChannel('com.example.widgetnoteapp/update_widget');

class AndroidWidgetManager {
  static String tasks = ''; // Use a single string to store tasks
  static String sharedKeyAndroid = 'tasks';

  //method to update the widget
  static Future<void> updateAndroidWidget() async {
    try {
      // First save data using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sharedKeyAndroid, tasks);

      // Then notify the platform to update the widget
      await platform.invokeMethod('updateWidget');
    } catch (e) {
      print('Error updating widget: $e');
    }
  }

  static saveTask(String taskTitle) async {
    if (taskTitle.isNotEmpty) {
      // Append the new task to the existing tasks

      // setState(() {
      tasks = tasks.isEmpty ? taskTitle : '$tasks,$taskTitle';

      // });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sharedKeyAndroid, tasks);

      // Update the widget
      await updateAndroidWidget();

      // SnackBarCustom.build(
      //     message: 'Task added!', context: navigatorKey.currentState!.context);

      // _taskController.clear();
    }
  }

  static void loadSavedTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksString = prefs.getString('tasks') ?? '';
    if (tasksString.isNotEmpty) {
      // setState(() {
      tasks = tasksString;
      // });
      // Update widget when tasks are loaded
      await updateAndroidWidget();
    }
  }

  static void removeTask(int index) async {
    List<String> taskList = tasks.split(',');
    if (index < taskList.length) {
      taskList.removeAt(index);
      // setState(() {
      tasks = taskList.join(',');
      // });

      // Update the widget
      await updateAndroidWidget();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadSavedTasks();
  // }
}
