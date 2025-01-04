import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/model/local_data/local_user.dart';

import '../../../main.dart';
import '../../../utils/app_color.dart';
import '../../../view/widget/SnackBarCustom.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  LocalUser? localUser;

  getLocalUserData() {
    emit(ProfileLoading());
    localUser = LocalUser.getLocalUserData();
    emit(ProfileSuccess(localUser: localUser!));
  }

  editProfile({
    required String fristName,
    required String secondName,
    required String email,
    required String lastName,
    required String phoneNumber,
    required String country,
  }) {
    emit(ProfileLoading());
    LocalUser.editLocalUserData(
      fristName: fristName,
      secondName: secondName,
      email: email,
      lastName: lastName,
      phoneNumber: phoneNumber,
      country: country,
    );
    getLocalUserData();
  }

  editPassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) {
    emit(ProfileLoading());
    if (localUser!.password == oldPassword) {
      if (newPassword == confirmPassword) {
        LocalUser.editPassword(newPassword: newPassword);
        getLocalUserData();
      } else {
        SnackBarCustom.build(
            message: 'Passwords do not match!',
            messageColor: AppColor.red,
            context: navigatorKey.currentState!.context);
      }
    } else {
      SnackBarCustom.build(
          message: 'Incorrect Password',
          messageColor: AppColor.red,
          context: navigatorKey.currentState!.context);
    }
  }

  // openProfile() async {
  //   emit(LoadingState());
  //   getLocalUserData();
  //   await Future.delayed(const Duration(seconds: 1));
  //   emit(ProfileState(localUser: localUser!));
  // }

  // openEditPassword() {
  //   emit(EditPasswordState());
  // }

  // openEditProfile({required LocalUser localUser}) {
  //   emit(EditProfileState(localUser: localUser));
  // }

  // submitEditPassword(
  //     {required String oldPassword,
  //     required String newPassword,
  //     required String confirmPassword}) {
  //   getLocalUserData();
  //   if (localUser!.password == oldPassword) {
  //     if (newPassword == confirmPassword) {
  //       LocalUser.editPassword(newPassword: newPassword);
  //       openProfile();
  //     } else {
  //       SnackBarCustom.build(
  //           message: 'Passwords do not match!',
  //           messageColor: AppColor.red,
  //           context: navigatorKey.currentState!.context);
  //     }
  //   } else {
  //     SnackBarCustom.build(
  //         message: 'Incorrect Password',
  //         messageColor: AppColor.red,
  //         context: navigatorKey.currentState!.context);
  //   }
  // }

  // submitEditProfile({
  //   required String fristName,
  //   required String secondName,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String country,
  //   required String email,
  // }) {
  //   LocalUser.editLocalUserData(
  //     fristName: fristName,
  //     secondName: secondName,
  //     lastName: lastName,
  //     phoneNumber: phoneNumber,
  //     country: country,
  //     email: email,
  //   );
  // }
}
