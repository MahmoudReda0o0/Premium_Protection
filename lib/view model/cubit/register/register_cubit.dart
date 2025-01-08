import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../main.dart';
import '../../../model/firebase/auth.dart';
import '../../../view/widget/SnackBarCustom.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  FirebaseAuthModel? firebaseAuthModel;

resetRegisterState(){
  emit(RegisterInitial());
}

  Future<void> userRegister(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      firebaseAuthModel = await FirebaseAuthModel.registerWitEmailandPassword(
          email: email, password: password);
      if (firebaseAuthModel!.userCredential != null) {
        emit(RegisterSuccess(
            token: firebaseAuthModel!.userCredential!.user!.uid));
        SnackBarCustom.build(
          message: '''User ID : ${firebaseAuthModel!.userCredential!.user!.uid}
          User email : ${firebaseAuthModel!.userCredential!.user!.email}''',
          context: navigatorKey.currentState!.context,
        );
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
