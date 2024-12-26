part of 'tasko_cubit.dart';

sealed class TaskoState extends Equatable {
  const TaskoState();

  @override
  List<Object> get props => [];
}

final class Test1State extends TaskoState {}

final class Test2State extends TaskoState {}

final class TaskoInitial extends TaskoState {}

final class LoadingState extends TaskoState {}

final class ErrorState extends TaskoState {}

final class SuccessState extends TaskoState {}

final class LoadedState extends TaskoState {}

final class AddNewTaskState extends TaskoState {}

final class ShowTaskDetailState extends TaskoState {
  ShowTaskDetailState({required this.localTaskItem});
  LocalTask localTaskItem;
}

final class EditTaskDetailState extends TaskoState {
  LocalTask localTaskItem;
  EditTaskDetailState({required this.localTaskItem});
}

final class HomeState extends TaskoState {
  List<LocalTask> localTask;
  HomeState({required this.localTask});
}

final class EditProfileState extends TaskoState {
  LocalUser localUser;
  EditProfileState({required this.localUser});
}

final class EditPasswordState extends TaskoState {}

final class ProfileState extends TaskoState {
  ProfileState({required this.localUser});
  LocalUser localUser;
}

final class TaskTypeState extends TaskoState {}
