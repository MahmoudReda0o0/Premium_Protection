import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/model/firebase/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../../model/firebase/auth.dart';
import '../../../view/widget/SnackBarCustom.dart';
import '../profile/profile_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  FirebaseAuthModel? firebaseAuthModel;

  resetRegisterState() {
    emit(RegisterInitial());
  }

  Future<void> userRegister({
    required String fristName,
    required String secondName,
    required String lastName,
    required String phoneNumber,
    required String country,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      firebaseAuthModel = await FirebaseAuthModel.registerWitEmailandPassword(
        email: email,
        password: password,
      );
      if (firebaseAuthModel!.userCredential != null) {
        FirebaseFireStoreUserInfoModel response =
            await FirebaseFireStoreUserInfoModel.setUserInfo(
          firstNameValue: fristName,
          secondNameValue: secondName,
          lastNameValue: lastName,
          phoneNumberValue: phoneNumber,
          countryValue: country,
          emailValue: email,
        );
        if (response.hasData == true) {
          await FirebaseAuthModel.emailVerification();
          emit(RegisterSuccess(
              token: firebaseAuthModel!.userCredential!.user!.uid));
          SnackBarCustom.build(
            message:
                '''User ID : ${firebaseAuthModel!.userCredential!.user!.uid}
          User email : ${firebaseAuthModel!.userCredential!.user!.email}''',
            context: navigatorKey.currentState!.context,
          );
        } else {
          emit(RegisterError(errorMessage: response.errorMessage));
        }
      } else {
        emit(RegisterError(errorMessage: firebaseAuthModel!.errorMessage!));
      }
    } catch (e) {
      emit(
        RegisterError(errorMessage: 'Cubit Catch Error: $e'),
      );
    }
  }
}
