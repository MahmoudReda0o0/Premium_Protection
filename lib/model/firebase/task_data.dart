import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/model/firebase/FB_field_name.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

class FB_FirestoreTaskData {
  bool? success;
  List<TaskModelID>? tasks;
  String? errorMessage;

  static Future<FB_FirestoreTaskData> addNewTask(
      {required TaskModel newTask}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskData)
            .doc()
            .set(newTask.toFirestore());
        print("Task added successfully");
        return FB_FirestoreTaskData(
            success: true, errorMessage: 'everything is ok');
      } else {
        return FB_FirestoreTaskData(
            success: false, errorMessage: 'User is null');
      }
    } catch (e) {
      return FB_FirestoreTaskData(
          success: false, errorMessage: 'firestore catch error: $e');
    }
  }
  FB_FirestoreTaskData({this.errorMessage, this.tasks, this.success});
  static Future<FB_FirestoreTaskData> getTasksListData() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
        final response = await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskData)
            .get();
        List<TaskModelID> taskModelID = [];
        for (var doc in response.docs) {
          taskModelID.add(
            TaskModelID(
              id: doc.id,
              task: TaskModel.fromFirestore(doc.data() as Map<String, dynamic>),
            ),
          );
        }
        // List<TaskModel> tasks = response.docs
        //     .map((doc) =>
        //         TaskModel.fromFirestore(doc.data() as Map<String, dynamic>))
        //     .toList();
        return FB_FirestoreTaskData(
            tasks: taskModelID,
            success: true,
            errorMessage: 'everything is ok');
      } else {
        return FB_FirestoreTaskData(
            errorMessage: 'User is null', success: false, tasks: []);
      }
    } catch (e) {
      return FB_FirestoreTaskData(
          errorMessage: 'firestore catch error: $e', success: false, tasks: []);
    }
  }

  static Future<FB_FirestoreTaskData> editTaskDetail(
      {required TaskModelID updatedTask}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskData)
            .doc(updatedTask.id)
            .update(updatedTask.task!.toFirestore());

        return FB_FirestoreTaskData(
            success: true, errorMessage: 'everything is ok');
      } else {
        return FB_FirestoreTaskData(
            success: false, errorMessage: 'User is null');
      }
    } catch (e) {
      return FB_FirestoreTaskData(
          success: false, errorMessage: 'firestore catch error: $e');
    }
  }


  static Future<FB_FirestoreTaskData> deleteTask(
      {required String taskId}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskData)
            .doc(taskId)
            .delete();
        return FB_FirestoreTaskData(
            success: true, errorMessage: 'task deleted successfully');
      } else {
        return FB_FirestoreTaskData(
            success: false, errorMessage: 'User is null');
      }
    } catch (e) {
      print('firestore catch error: $e');
      return FB_FirestoreTaskData(
          success: false, errorMessage: 'firestore catch error: $e');
    }
  }

  // Future<void> editTaskdetail() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await FirebaseFirestore.instance
  //           .collection(FB.collectionUserInfo)
  //           .doc(user.uid)
  //           .collection(FB.collectionTaskData)
  //           .where(fieldName, isEqualTo: fieldValue)
  //           .get();
  //     }
  //   } catch (e) {}
  // }
}
