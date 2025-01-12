part of 'tasko_cubit.dart';

sealed class TaskoState extends Equatable {
  const TaskoState();

  @override
  List<Object> get props => [];
}

final class InitialState extends TaskoState {}

final class LoadingState extends TaskoState {}

final class ErrorState extends TaskoState {
  String errorMessage;
  ErrorState({required this.errorMessage});
}

final class SuccessState extends TaskoState {
  List<TaskModelID> allTask;
  List<TaskModelID> newTask;
  List<TaskModelID> completedTask;
  SuccessState({
    required this.allTask,
    required this.newTask,
    required this.completedTask,
  });
}
