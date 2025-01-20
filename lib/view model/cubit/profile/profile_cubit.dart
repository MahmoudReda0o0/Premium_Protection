import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/model/firebase/FB_field_name.dart';
import 'package:excp_training/model/local/local_user.dart';
import 'package:excp_training/model/models/user_model.dart';

import '../../../main.dart';
import '../../../model/firebase/user_info.dart';
import '../../../utils/app_color.dart';
import '../../../view/widget/SnackBarCustom.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  late UserModel userDate;
  // LocalUser? localUser;

  // setUserInfo({

  //   required String fristName,
  //   required String secondName,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String country,
  //   required String email,
  //   //required String password,
  // }) async {
  //   emit(ProfileLoading());
  //   try {
  //     await FirebaseFireStoreUserInfoModel.setUserInfo(
  //       fristNameValue: fristName,
  //       secondNameValue: secondName,
  //       lastNameValue: lastName,
  //       phoneNumberValue: phoneNumber,
  //       countryValue: country,
  //       emailValue: email,
  //     ); // passwordValue: password;
  //     emit(ProfileInitial());
  //   } catch (e) {
  //     emit(ProfileError(errorMessage: 'Cubit Catch Error: $e'));
  //     print('👌👌👌👌cubit catch error $e');
  //   }
  // }

  Future<void> getUserInfo() async {
    emit(ProfileLoading());
    try {
      final response = await FirebaseFireStoreUserInfoModel.getUserInfo();
      if (response.userData != null) {
        userDate = response.userData!;
        emit(ProfileSuccess(userInfo: userDate));
      } else {
        emit(ProfileError(errorMessage: 'Error :${response.errorMessage}'));
      }
    } catch (e) {
      emit(ProfileError(errorMessage: 'Cubit Catch Error: $e'));
      print('cubit catch error $e');
    }
  }

  updateUserinfo({
    required String fristName,
    required String secondName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String country,
     required String password
  }) async {
    UserModel updatedInfo = UserModel(
      fristName: fristName,
      secondName: secondName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      country: country,
      password: password
    );
    try {
      emit(ProfileLoading());
      final response = await FirebaseFireStoreUserInfoModel.updateUserInfo(
          upDatedInfo: updatedInfo);
      if (response.hasData == true) {
        emit(ProfileUpdateSuccess());
        await Future.delayed(const Duration(milliseconds: 1500));
        getUserInfo();
      } else {
        emit(ProfileError(errorMessage: 'Error :${response.errorMessage}'));
      }
    } catch (e) {}
  }

  /// ------------------------------------------------------------------------\\\

  getLocalUserData() {
    emit(ProfileLoading());
    // localUser = LocalUser.getLocalUserData();
    // emit(ProfileSuccess(localUser: localUser!));
  }

  // editProfile({
  //   required String fristName,
  //   required String secondName,
  //   required String email,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String country,
  // }) {
  //   emit(ProfileLoading());
  //   // LocalUser.editLocalUserData(
  //   //   fristName: fristName,
  //   //   secondName: secondName,
  //   //   email: email,
  //   //   lastName: lastName,
  //   //   phoneNumber: phoneNumber,
  //   //   country: country,
  //   // );
  //   getLocalUserData();
  // }

  editPassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) {
    emit(ProfileLoading());
    // if (localUser!.password == oldPassword) {
    //   if (newPassword == confirmPassword) {
    //    // LocalUser.editPassword(newPassword: newPassword);
    //     getLocalUserData();
    //   } else {
    //     SnackBarCustom.build(
    //         message: 'Passwords do not match!',
    //         messageColor: AppColor.red,
    //         context: navigatorKey.currentState!.context);
    //   }
    // } else {
    //   SnackBarCustom.build(
    //       message: 'Incorrect Password',
    //       messageColor: AppColor.red,
    //       context: navigatorKey.currentState!.context);
    // }
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
