import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'FB_field_name.dart';

class FirebaseFireStoreUserInfoModel {
  // String userID;

  UserModel? userData;
  String errorMessage;
  bool hasData;

  FirebaseFireStoreUserInfoModel(
      {this.userData, required this.errorMessage, required this.hasData});

  // saveLocalUserInfo({
  //   required String userID,
  //   required String email,
  //   required String password,
  //   required String fristName,
  //   required String secondName,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String country,
  // }) {
  //   this.fristName = fristName;
  // }

  static Future<FirebaseFireStoreUserInfoModel> setUserInfo({
    required UserModel userModel,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('User ID: \${user.uid}');

        await FirebaseFirestore.instance
            .collection('User Info')
            .doc(user.uid)
            .set(userModel.toFirebase());

        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'Everything is OK', hasData: true);
      } else {
        print('User is null');
        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'User is null', hasData: false);
      }
    } catch (e) {
      print('Firebase catch error: \$e');
      return FirebaseFireStoreUserInfoModel(
          errorMessage: 'Firebase Catch Error: \$e', hasData: false);
    }
  }

  static Future<FirebaseFireStoreUserInfoModel> getUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('User ID: ${user.uid}');
        final doc = await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .get();
        if (doc.exists) {
          
          // fristName = doc.get('first name');
          // secondName = doc.get('second name');
          // lastName = doc.get('last name');
          // phoneNumber = doc.get('phone number');
          // country = doc.get('country');
          // email = doc.get('email');
          // password = doc.get('password');
          return FirebaseFireStoreUserInfoModel(
              errorMessage: 'Everything is ok',
              userData: UserModel.fromFirebase(doc.data() as Map<String, dynamic>),
              hasData: true);
        }
        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'doc is null', userData: null, hasData: false);
      } else {
        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'User is null', userData: null, hasData: false);
      }
    } catch (e) {
      print(e);
      return FirebaseFireStoreUserInfoModel(
          errorMessage: 'Firebase Catch  Error: $e',
          userData: null,
          hasData: false);
    }
  }

  static Future<FirebaseFireStoreUserInfoModel> updateUserInfo(
      {required UserModel upDatedInfo}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .update(upDatedInfo.toFirebase());
        return FirebaseFireStoreUserInfoModel(
          errorMessage: 'everything is ok',
          hasData: true,
        );
      } else {
        print('user is null');
        return FirebaseFireStoreUserInfoModel(
          errorMessage: 'User is null',
          hasData: false,
        );
      }
    } catch (e) {
      print('firebase catch error: $e');
      return FirebaseFireStoreUserInfoModel(
        errorMessage: 'Firebase Catch  Error: $e',
        hasData: false,
      );
    }
  }
}
