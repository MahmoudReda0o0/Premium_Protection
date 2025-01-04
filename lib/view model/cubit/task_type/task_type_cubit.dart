import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/local_data/local_task_data.dart';
import '../task_item/task_item_cubit.dart';

part 'task_type_state.dart';

class TaskTypeCubit extends Cubit<TaskTypeState> {
  TaskTypeCubit() : super(TaskTypeInitial());

  List<String>? fixedTaskType;
  List<String>? addedTaskType;
  List<String>? allTaskType;

  getTaskTypeList() {
    emit(TaskTypeLoading());
    fixedTaskType = [];
    addedTaskType = [];
    allTaskType = [];
    fixedTaskType = List.from(LocalTask.fixedTaskTypeList);
    addedTaskType = List.from(LocalTask.addedTaskTypeList);
    allTaskType = [...fixedTaskType!, ...addedTaskType!];
    emit(
      TaskTypeSuccess(
        fixedTaskTypeList: fixedTaskType!,
        addedTaskTypeList: addedTaskType!,
        allTaskTypeList: allTaskType!,
      ),
    );
  }

  addNewTaskType(String newTaskType) {
    emit(TaskTypeLoading());
    LocalTask.addNewTaskType(newTaskType);
    // Future.delayed(const Duration(seconds: 1));
    getTaskTypeList();
  }

  deleteTasktype(
      {required String taskType, required List<LocalTask> taskList}) async {
    {
      bool typeExist = false;
      List<LocalTask> deletedTaskType = [];
      for (var e in taskList) {
        if (e.taskType == taskType && e.isNew == true) {
          typeExist = false;
          break;
        } else if (e.taskType == taskType && e.isNew == false) {
          typeExist = true;
          deletedTaskType.add(e);
          continue;
        } else {
          typeExist = true;
          continue;
        }
      }
      if (typeExist) {
        emit(TaskTypeLoading());
        if (deletedTaskType.isNotEmpty) {
          for (var e in deletedTaskType) {
            LocalTask.deleteTask(deletedTask: e);
          }
        }
        LocalTask.deletaTaskType(taskType);

        // Future.delayed(const Duration(seconds: 1));
        getTaskTypeList();
        SnackBarCustom.build(
            message:
                'All tasks with this type deleted : ${deletedTaskType.length}',
            context: navigatorKey.currentContext!);
        BlocProvider.of<TaskoCubit>(navigatorKey.currentContext!)
            .getAllLocalTask();
      } else {
        SnackBarCustom.build(
            message: 'there are Unfinished tasks with this type',
            context: navigatorKey.currentContext!);
      }
    }
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
  }
}