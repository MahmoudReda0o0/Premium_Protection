import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AndroidWidgetManager {
  static const MethodChannel platform =
      MethodChannel("com.example.excp_training/update_widget");
  static String tasks = '';

  static Future<void> updateAndroidWidget(List<String> tasks) async {
    try {
      final tasksString = tasks.join(',');

      // Write tasks to a file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/tasks.txt');
      await file.writeAsString(tasksString);

      // Log the file path
      print('👽👽👽Tasks written to file: ${file.path}');

      // Notify the Android widget to update
      print('Calling updateWidget method...');
      await platform.invokeMethod('updateWidget');
      print('🤩🤩🤩updateWidget method called successfully');
    } catch (e) {
      print('Error updating widget: $e');
    }
  }
}
