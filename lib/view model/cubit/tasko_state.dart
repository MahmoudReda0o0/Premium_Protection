part of 'tasko_cubit.dart';

sealed class TaskoState extends Equatable {
  const TaskoState();

  @override
  List<Object> get props => [];
}


final class TaskoInitial extends TaskoState {}

final class LoadingState extends TaskoState {}

final class LoadedState extends TaskoState {}

final class HomeState extends TaskoState {}

final class ErrorState extends TaskoState {}  

final class SuccessState extends TaskoState {}


