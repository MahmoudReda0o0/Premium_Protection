part of 'task_item_cubit.dart';

sealed class TaskItemState extends Equatable {
  const TaskItemState();

  @override
  List<Object> get props => [];
}

final class TaskItemInitial extends TaskItemState {}

final class TaskItemLoading extends TaskItemState {}

final class TaskItemSuccess extends TaskItemState {
  LocalTask selectedTask;
  TaskItemSuccess({required this.selectedTask});
}

final class TaskItemError extends TaskItemState {
  final String message;
  const TaskItemError({required this.message});
}
