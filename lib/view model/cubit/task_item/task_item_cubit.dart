import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/model/firebase/task_data.dart';
import 'package:excp_training/model/local/local_task_data.dart';
import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general_cubit/tasko_cubit.dart';

part 'task_item_state.dart';

class TaskItemCubit extends Cubit<TaskItemState> {
  TaskItemCubit() : super(TaskItemInitial());

  TaskModelID? selectedTask;
  // int? localTaskIndex;

  getTaskItemInfo({required TaskModelID selectedTask}) {
    emit(TaskItemLoading());
    this.selectedTask = selectedTask;
    print('👀👀👀  selectedTask: ${selectedTask.task!.name}');
    emit(TaskItemSuccess(selectedTask: selectedTask));
  }

  

  editTaskComplete() async {
    emit(TaskItemLoading());
    selectedTask!.task!.isNew = false;
    final response =
        await FB_FirestoreTaskData.editTaskDetail(updatedTask: selectedTask!);
    if (response.success! == true) {
      emit(TaskItemSuccess(selectedTask: selectedTask!));
    } else {
      emit(TaskItemError(errorMessage: response.errorMessage!));
    }
    emit(TaskItemSuccess(selectedTask: selectedTask!));
  }

  editTaskDetail(TaskModel updatedTaskData) async {
    emit(TaskItemLoading());
    selectedTask!.task = updatedTaskData;
    final response =
        await FB_FirestoreTaskData.editTaskDetail(updatedTask: selectedTask!);
    if (response.success! == true) {
      emit(TaskItemSuccess(selectedTask: selectedTask!));
    } else {
      emit(TaskItemError(errorMessage: response.errorMessage!));
    }
  }


  addNewTask({required TaskModel newTask}) async {
    emit(TaskItemLoading());
    final response = await FB_FirestoreTaskData.addNewTask(newTask: newTask);
    if (response.success! == true) {
      emit(TaskItemInitial());
    } else {
      emit(TaskItemError(errorMessage: response.errorMessage!));
    }
    //emit(TaskItemSuccess(selectedTask: newTask));
  }

  

  deleteTask({required TaskModelID deletedTask}) async {
    emit(TaskItemLoading());
    if (deletedTask.task!.isNew!) {
      SnackBarCustom.build(
        message: 'Task Is Still New',
        context: navigatorKey.currentContext!,
      );
      emit(TaskItemInitial());
    } else {
      final response =await FB_FirestoreTaskData.deleteTask(taskId: deletedTask.id!);
      if (response.success! == true) {
        emit(TaskItemInitial());
      } else {
        emit(TaskItemError(errorMessage: response.errorMessage!));
      }

    }

    //emit(TaskItemSuccess(selectedTask: LocalTask.taskList.last));
  }



}
