import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';

import '../../model/local_data/local_user.dart';
part 'tasko_state.dart';

class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(TaskoInitial());

  late LocalUser localUser;
  userLogin({required String email, required String password}) {
    emit(LoadingState());
    Future.delayed(
      const Duration(seconds: 2),
    );
    localUser = LocalUser.getLocalUserData();
    if (localUser.email == email && localUser.password == password) {
      emit(HomeState());
    }
    SnackBarCustom.build(
      message: 'Email or Password Was Wrong ',
      context: navigatorKey.currentState!.context,
    );
    emit(TaskoInitial());
  }
}
