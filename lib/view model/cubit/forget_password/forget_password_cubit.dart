import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';

import '../../../main.dart';
import '../../../model/firebase/auth.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  resetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuthModel.resetPassword(email: email);
      SnackBarCustom.build(
        context: navigatorKey.currentState!.context,
        message: 'Please check your email for reset password',
        duration: 3,
        messageColor: AppColor.green

      );
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordError(errorMessage: e.toString()));
    }
  }

  void resetState() => emit(ForgetPasswordInitial());
}
