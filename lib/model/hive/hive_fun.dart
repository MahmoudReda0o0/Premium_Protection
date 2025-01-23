import 'dart:io';

import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/model/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/type_model.dart';
import 'hive_constant.dart';

class HiveFun {
  // -------------------  User Data -------------------

  static Future<void> putUserInfo(UserModel userModel) async {
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    await hivebox.put(HiveConstant.keyUserInfo, userModel);
  }

  static UserModel getUserInfo() {
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    UserModel usermodel = hivebox.get(HiveConstant.keyUserInfo) ??
        UserModel(
          fristName: 'New',
          secondName: 'User',
          lastName: '',
          phoneNumber: '',
          country: '',
          email: '',
          password: '',
        );
    return usermodel;
  }

  //-----------------------  Type Data -------------------
  static Future<void> putTypeInfo(List<String> typeList) async {
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    await hivebox.put(HiveConstant.keyTypeList, typeList);
  }

  static List<String> getTypeInfo() {
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    List<String> typeList = hivebox.get(HiveConstant.keyTypeList) ?? [];
    return typeList;
  }

//---------------------------  Task List Data -------------------

  static Future<void> putTaskModelList(List<TaskModelID> taskIdlist) async {
    List<TaskModel> taskList = [];
    for (var e in taskIdlist) {
      taskList.add(e.task!);
    }
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    await hivebox.put(HiveConstant.keyTaskList, taskList);
  }

  static List<TaskModel> getTaskModelList() {
    final hivebox = Hive.box(HiveConstant.boxlocalData);
    final dynamic data = hivebox.get(HiveConstant.keyTaskList);

    if (data is List<dynamic>) {
      // Explicitly cast each item to TaskModel
      return data.cast<TaskModel>().toList();
    } else {
      return []; // Return an empty list if data is null or not a list
    }
  }

  // --------------------------- Task Data -------------------
  static Future<void> putTaskModel({required TaskModel taskModel}) async {
    final hiveBox = Hive.box(HiveConstant.boxlocalData);
    await hiveBox.put(HiveConstant.keyOnlyTask, taskModel);
  }

  static TaskModel getTaskModel() {
    final hiveBox = Hive.box(HiveConstant.boxlocalData);
    TaskModel taskModel = hiveBox.get(HiveConstant.keyOnlyTask) ??
        TaskModel(
            name: 'No Tasks Added',
            type: '',
            description: '',
            dateAndTime: '',
            isNew: true);
    return taskModel;
  }

  //-------------------------- Delete Box ----------------------------
  Future<void> deleteHiveFile(String boxName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$boxName.hive');
    if (await file.exists()) {
      await file.delete();
      print('😱😱😱Deleted Hive file: ${file.path}');
    }
  }
}
