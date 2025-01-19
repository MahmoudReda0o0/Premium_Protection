import 'dart:developer';

import 'package:excp_training/model/firebase/FB_field_name.dart';

class TaskModelID {
  String? id;
  TaskModel? task;

  TaskModelID({required this.id,required this.task});
  // TaskModelID.fromFirebase(Map<String,dynamic> data) {
  //   id = data['FB.taskID'];
  //   task = data['task']!=null?;
  // }
}

class TaskModel {
  String? name;
  String? type;
  String? description;
  String? dateAndTime;
  bool? isNew;

  TaskModel({
    this.name,
    this.type,
    this.description,
    this.dateAndTime,
    this.isNew,
  });

  TaskModel.fromFirestore(Map<String, dynamic> data) {
    name = data[FB.taskName];
    type = data[FB.taskType];
    description = data[FB.taskDescription];
    dateAndTime = data[FB.taskDateAndTime];
    isNew = data[FB.taskIsNew];
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> data = <String, dynamic>{};
    data[FB.taskName] = name;
    data[FB.taskType] = type;
    data[FB.taskDescription] = description;
    data[FB.taskDateAndTime] = dateAndTime;
    data[FB.taskIsNew] = isNew;
    return data;
  }
}
