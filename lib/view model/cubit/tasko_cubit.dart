import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'tasko_state.dart';

class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(TaskoInitial());

  userLogin() {
    emit(LoadingState());

    Future.delayed(const Duration(seconds: 2), () {
      emit(HomeState());
    });
  }
}
