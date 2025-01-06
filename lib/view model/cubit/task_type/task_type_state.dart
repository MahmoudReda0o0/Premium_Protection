part of 'task_type_cubit.dart';

sealed class TaskTypeState extends Equatable {
  const TaskTypeState();

  @override
  List<Object> get props => [];
}

final class TaskTypeInitial extends TaskTypeState {}

final class TaskTypeLoading extends TaskTypeState {}

final class TaskTypeError extends TaskTypeState {}

final class TaskTypeSuccess extends TaskTypeState {
  List<String> fixedTaskTypeList;
  List<String> addedTaskTypeList;
  List<String>  allTaskTypeList ;
  TaskTypeSuccess({
    required this.fixedTaskTypeList,
    required this.addedTaskTypeList,
    required this.allTaskTypeList,
    
  });
}
