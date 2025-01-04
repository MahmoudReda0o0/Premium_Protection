import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/local_data/local_task_data.dart';

part 'task_type_state.dart';

class TaskTypeCubit extends Cubit<TaskTypeState> {
  TaskTypeCubit() : super(TaskTypeInitial());

  List<String>? fixedTaskType;
  List<String>? addedTaskType;
  List<String>? allTaskType;

  getTaskTypeList() {
    emit(TaskTypeLoading());
    List<String> fixedTaskType = [];
    List<String> addedTaskType = [];
    //List<String> allTaskType = [];
    fixedTaskType = LocalTask.fixedTaskTypeList;
    addedTaskType = LocalTask.addedTaskTypeList;
    // allTaskType = [...fixedTaskType, ...addedTaskType];
    emit(
      TaskTypeSuccess(
        fixedTaskTypeList: fixedTaskType,
        addedTaskTypeList: addedTaskType,
      ),
    );
  }

  addNewTaskType(String newTaskType) {
    emit(TaskTypeLoading());
    LocalTask.addNewTaskType(newTaskType);
    // Future.delayed(const Duration(seconds: 1));
    getTaskTypeList();
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
