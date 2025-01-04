import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../main.dart';
import '../../../model/local_data/local_user.dart';
import '../../../view/widget/SnackBarCustom.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LocalUser? localUser;
  String token = 'seg64rseg16regesrg4erb61es68r4yrgvs1e6g4rg';
  getLocalUserData() {
    if (localUser != null) {
      print('😘😁👍localUser is aloredy here');
      return;
    } else {
      localUser = LocalUser.getLocalUserData();
      print('👌💕❤️  initialize New LocalUser: ${localUser!.email}');
    }
  }

  userLogin({required String email, required String password}) async {
    emit(LoginLoading());
    await getLocalUserData();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (localUser!.email == email && localUser!.password == password) {
      emit(
        LoginSuccess(token:token,loginStep: true),
      );
    } else {
      SnackBarCustom.build(
        message: 'Email or Password Was Wrong ',
        context: navigatorKey.currentState!.context,
      );
      emit(LoginInitial());
    }
  }
}
