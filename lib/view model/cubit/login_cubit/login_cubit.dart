import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/model/firebase/auth.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../main.dart';
import '../../../model/x/local_data/shared_preference.dart';
import '../../../model/x/local_user.dart';
import '../../../view/widget/SnackBarCustom.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  late String email;
  late String password;
  FirebaseAuthModel? firebaseAuthModel;

  // LocalUser? localUser;
  String? token;

  setEmailAndPassword(
      {required String emailValue, required String passwordValue}) {
    email = emailValue;
    password = passwordValue;
  }

  Future<void> userLogin() async {
    emit(LoginLoading());
    try {
      firebaseAuthModel = await FirebaseAuthModel.loginWithEmailAndPassWord(
        email: email,
        password: password,
      );
      if (firebaseAuthModel!.userCredential != null) {
        emit(LoginSuccess(token: firebaseAuthModel!.userCredential!.user!.uid));
        print(
            '👾👾👾 User ID : ${firebaseAuthModel!.userCredential!.user!.uid}');
        SnackBarCustom.build(
          message: 'User ID : ${firebaseAuthModel!.userCredential!.user!.uid}',
          context: navigatorKey.currentState!.context,
        );
      } else {
        emit(LoginError(errorMessage: firebaseAuthModel!.errorMessage!));
      }
    } catch (e) {
      emit(LoginError(errorMessage: 'Cubit Catch Error: $e'));
      SnackBarCustom.build(
        message: e.toString(),
        context: navigatorKey.currentState!.context,
      );
    }
  }

  Future<void> logout() async {
    emit(LoginLoading());
    bool response = await FirebaseAuthModel.signOut();
    if (response == true) {
      Hive.box(HiveConstant.boxCheckLogin).put(HiveConstant.keyCheckBox, false);
      // SharedPreferenceCustom.setSharedSetDate(
      //     SharedPreferenceCustom.sharedCheckBoxKey, false);
      emit(LoginInitial());
    } else {
      emit(const LoginError(errorMessage: 'Logout Error'));
    }
  }

  resetLoginState() {
    Hive.box(HiveConstant.boxCheckLogin).put(HiveConstant.keyCheckBox, false);
    // SharedPreferenceCustom.setSharedSetDate(
    //     SharedPreferenceCustom.sharedCheckBoxKey, false);
    emit(LoginInitial());
  }

  // getLocalUserData() {
  //   if (localUser != null) {
  //     print('😘😁👍localUser is aloredy here');
  //     return;
  //   } else {
  //     localUser = LocalUser.getLocalUserData();
  //     print('👌💕❤️  initialize New LocalUser: ${localUser!.email}');
  //   }
  // }

  // userLogin({required String email, required String password}) async {
  //   emit(LoginLoading());
  //   await getLocalUserData();
  //   await Future.delayed(
  //     const Duration(seconds: 2),
  //   );
  //   if (localUser!.email == email && localUser!.password == password) {
  //     emit(
  //       LoginSuccess(token:token,loginStep: true),
  //     );
  //   } else {
  //     SnackBarCustom.build(
  //       message: 'Email or Password Was Wrong ',
  //       context: navigatorKey.currentState!.context,
  //     );
  //     emit(LoginInitial());
  //   }
  // }

  // await getLocalUserData();
  // await Future.delayed(
  //   const Duration(seconds: 2),
  // );
  // if (localUser!.email == email && localUser!.password == password) {
  //   emit(
  //     LoginSuccess(token: token, loginStep: true),
  //   );
  // } else {
  //   SnackBarCustom.build(
  //     message: 'Email or Password Was Wrong ',
  //     context: navigatorKey.currentState!.context,
  //   );
  //   emit(LoginInitial());
  // }
}
