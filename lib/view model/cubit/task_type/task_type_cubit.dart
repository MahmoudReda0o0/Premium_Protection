import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/model/firebase/task_type.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../model/local/local_task_data.dart';
import '../task_item/task_item_cubit.dart';

part 'task_type_state.dart';

class TaskTypeCubit extends Cubit<TaskTypeState> {
  TaskTypeCubit() : super(TaskTypeInitial());

  List<String> allTypeList = [];
  List<String> addedTypeList = [];
  List<String> fixedTypeList = [
    'Work',
    'Study',
    'Chores',
    'Fitness',
    'Shopping',
    'Travel',
    'Health',
    'Events',
    'Hobbies',
    'Finance',
  ];

  addNewType({required String newTaskType}) async {
    emit(TaskTypeLoading());
    addedTypeList.add(newTaskType);
    allTypeList = [...allTypeList, ...addedTypeList];
    final response =
        await FB_FirestoreTaskType.addTypeList(typeList: addedTypeList);
    if (response.success! == true) {
      await HiveFun.putTypeInfo(addedTypeList);
      emit(TaskTypeSuccess(
          fixedTaskTypeList: fixedTypeList,
          addedTaskTypeList: addedTypeList,
          allTaskTypeList: allTypeList));
    } else {
      emit(TaskTypeError(errorMessage: response.message!));
    }
  }

  getTaskTypeList() async {
    emit(TaskTypeLoading());
    addedTypeList = [];
    allTypeList = [];
    try {
      emit(TaskTypeLoading());
      final response = await FB_FirestoreTaskType.getTypeList();
      if (response.success! == true) {
        addedTypeList = response.addedTypeList!;
        allTypeList = [...fixedTypeList, ...addedTypeList];
       await HiveFun.putTypeInfo(addedTypeList);
        emit(
          TaskTypeSuccess(
            fixedTaskTypeList: fixedTypeList,
            addedTaskTypeList: addedTypeList,
            allTaskTypeList: allTypeList,
          ),
        );
      } else {
        emit(TaskTypeError(errorMessage: response.message!));
      }
    } catch (e) {
      emit(TaskTypeError(errorMessage: e.toString()));
    }
  }

  deleteType({required String deletedType}) async {
    emit(TaskTypeLoading());
    try {
      addedTypeList.remove(deletedType);
      allTypeList = [...fixedTypeList, ...addedTypeList];
      final response = await FB_FirestoreTaskType.updateTypeList(
          updatedTypeList: addedTypeList);
      if (response.success! == true) {
        await HiveFun.putTypeInfo(addedTypeList);
        await Hive.box(HiveConstant.boxlocalData)
            .put(HiveConstant.keyTypeList, addedTypeList);
        emit(TaskTypeSuccess(
            fixedTaskTypeList: fixedTypeList,
            addedTaskTypeList: addedTypeList,
            allTaskTypeList: allTypeList));
      } else {
        emit(TaskTypeError(errorMessage: response.message!));
      }
    } catch (e) {
      emit(TaskTypeError(errorMessage: e.toString()));
    }
  }

  // updateTypeList({required String newTaskType}) async {
  //   emit(TaskTypeLoading());
  //   addedTypeList!.add(newTaskType);
  //   allTypeList = [...fixedTypeList, ...addedTypeList!];
  //   try {
  //     final response = await FB_FirestoreTaskType.updateTypeList(
  //         addNewTypeList: addedTypeList!);
  //     if (response.success! == true) {
  //       emit(
  //         TaskTypeSuccess(
  //           fixedTaskTypeList: fixedTypeList,
  //           addedTaskTypeList: addedTypeList!,
  //           allTaskTypeList: allTypeList!,
  //         ),
  //       );
  //     } else {
  //       emit(TaskTypeError(errorMessage: response.message!));
  //     }
  //   } catch (e) {
  //     emit(TaskTypeError(errorMessage: e.toString()));
  //   }
  // }

  // getTaskTypeList() {
  //   emit(TaskTypeLoading());
  //   fixedTaskType = [];
  //   addedTaskType = [];
  //   allTaskType = [];
  //  // fixedTaskType = List.from(LocalTask.fixedTaskTypeList);
  //   addedTaskType = List.from(LocalTask.addedTaskTypeList);
  //   allTaskType = [...fixedTaskType!, ...addedTaskType!];
  //   emit(
  //     TaskTypeSuccess(
  //       fixedTaskTypeList: fixedTaskType!,
  //       addedTaskTypeList: addedTaskType!,
  //       allTaskTypeList: allTaskType!,
  //     ),
  //   );
  // }

  // addN5ewTaskType(String newTaskType) {
  //   emit(TaskTypeLoading());
  //   LocalTask.addNewTaskType(newTaskType);
  //   // Future.delayed(const Duration(seconds: 1));
  //   getTaskTypeList();
  // }

  // deleteTasktype(
  //     {required String taskType, required List<LocalTask> taskList}) async {
  //   {
  //     bool typeExist = false;
  //     List<LocalTask> deletedTaskType = [];
  //     for (var e in taskList) {
  //       if (e.taskType == taskType && e.isNew == true) {
  //         typeExist = false;
  //         break;
  //       } else if (e.taskType == taskType && e.isNew == false) {
  //         typeExist = true;
  //         deletedTaskType.add(e);
  //         continue;
  //       } else {
  //         typeExist = true;
  //         continue;
  //       }
  //     }
  //     if (typeExist) {
  //       emit(TaskTypeLoading());
  //       if (deletedTaskType.isNotEmpty) {
  //         for (var e in deletedTaskType) {
  //           //LocalTask.deleteTask(deletedTask: e);
  //         }
  //       }
  //       LocalTask.deletaTaskType(taskType);

  //       // Future.delayed(const Duration(seconds: 1));
  //       getTaskTypeList();
  //       SnackBarCustom.build(
  //           message:
  //               'All tasks with this type deleted : ${deletedTaskType.length}',
  //           context: navigatorKey.currentContext!);
  //       BlocProvider.of<TaskoCubit>(navigatorKey.currentContext!)
  //           .getFirestoreTasks();
  //     } else {
  //       SnackBarCustom.build(
  //           message: 'there are Unfinished tasks with this type',
  //           context: navigatorKey.currentContext!);
  //     }
  //   }
  // openTaskType() {
  //   getTaskTypeList();
  //   print('👾👿😈${addedTaskType}');
  //   emit(TaskTypeState(
  //     fixedTaskType: fixedTaskType!,
  //     addedTaskType: addedTaskType!,
  //   ));
  // }

  // addNewTaskType(String newTaskType) {
  //   emit(LoadingState());
  //   LocalTask.addNewTaskType(newTaskType);
  //   Future.delayed(const Duration(seconds: 1));
  //   openTaskType();
  // }
  // }
}
