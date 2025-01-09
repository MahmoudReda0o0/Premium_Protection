import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/firebase/auth.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  resetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuthModel.resetPassword(email: email);
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordError(errorMessage: e.toString()));
    }
  }

  void resetState() => emit(ForgetPasswordInitial());
}
