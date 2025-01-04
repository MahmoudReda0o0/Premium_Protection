part of 'tasko_cubit.dart';

sealed class TaskoState extends Equatable {
  const TaskoState();

  @override
  List<Object> get props => [];
}

final class InitialState extends TaskoState {}

final class LoadingState extends TaskoState {}

final class ErrorState extends TaskoState {}
final class SuccessState extends TaskoState {
  List<LocalTask> localAllTask;
  List<LocalTask> localNewTask;
  List<LocalTask> localCompletedTask;
  SuccessState(
      {required this.localAllTask,
      required this.localNewTask,
      required this.localCompletedTask,
     });
}







