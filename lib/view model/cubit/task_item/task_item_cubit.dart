import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/model/local_data/local_task_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general_cubit/tasko_cubit.dart';

part 'task_item_state.dart';

class TaskItemCubit extends Cubit<TaskItemState> {
  TaskItemCubit() : super(TaskItemInitial());

  LocalTask? selectedTask;
  // int? localTaskIndex;

  getLocalTask({required LocalTask selectedTask}) {
    emit(TaskItemLoading());
    this.selectedTask = selectedTask;
    print('👀👀👀  selectedTask: ${selectedTask.taskName}');
    emit(TaskItemSuccess(selectedTask: selectedTask));
  }

  editTaskComplete() {
    emit(TaskItemLoading());
    selectedTask!.isNew = false;
    LocalTask.editTaskDetail(selectedTask!);
    emit(TaskItemSuccess(selectedTask: selectedTask!));
  }

  editTaskDetail(LocalTask updatedTask) {
    emit(TaskItemLoading());
    selectedTask = updatedTask;
    LocalTask.editTaskDetail(updatedTask);
    emit(TaskItemSuccess(selectedTask: selectedTask!));
  }

  deleteTask({required LocalTask deletedTask}) {
    emit(TaskItemLoading());
    LocalTask.deleteTask(deletedTask: deletedTask!);
    emit(TaskItemSuccess(selectedTask: LocalTask.taskList.last));
  }

  addNewTask(
      {required String taskName,
      required String taskType,
      required String taskDescription,
      required String dateTime}) async {
    emit(TaskItemLoading());
    await Future.delayed(const Duration(seconds: 1));
    LocalTask.addNewTask(
        taskName: taskName,
        taskType: taskType,
        taskDescription: taskDescription,
        dateTime: dateTime);
    emit(TaskItemSuccess(selectedTask: LocalTask.taskList.last));
  }
}
