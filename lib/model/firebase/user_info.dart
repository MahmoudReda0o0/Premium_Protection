import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'collection_name.dart';

class FirebaseFireStoreUserInfoModel {
  // String userID;

  static String collectionName = 'User Info';

  String errorMessage;
  bool? hasData;
  final Map<String, dynamic>? userDate;

  FirebaseFireStoreUserInfoModel(
      {required this.userDate, required this.errorMessage});

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

  static Future<void> setUserInfo({
    required String fristNameValue,
    required String secondNameValue,
    required String lastNameValue,
    required String phoneNumberValue,
    required String countryValue,
    required String emailValue,
    //required String passwordValue,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('User ID: ${user.uid}');
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .set({
          FBCollectionName.userFristName: fristNameValue,
          FBCollectionName.userSecondName: secondNameValue,
          FBCollectionName.userLastName: lastNameValue,
          FBCollectionName.userPhoneNumber: phoneNumberValue,
          FBCollectionName.userCountry: countryValue,
          FBCollectionName.userEmail: emailValue,
          //password: password,
        });
      } else {
        print('user is null');
      }
    } catch (e) {
      print('firebase catch error: $e');
    }
  }

  static Future<FirebaseFireStoreUserInfoModel> getUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('User ID: ${user.uid}');
        final doc = await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(user.uid)
            .get();
        if (doc.exists) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          // fristName = doc.get('first name');
          // secondName = doc.get('second name');
          // lastName = doc.get('last name');
          // phoneNumber = doc.get('phone number');
          // country = doc.get('country');
          // email = doc.get('email');
          // password = doc.get('password');
           return FirebaseFireStoreUserInfoModel(
            errorMessage: 'Everything is ok', userDate: userData);
        }
        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'doc is null', userDate: null);
      } else {
        return FirebaseFireStoreUserInfoModel(
            errorMessage: 'User is null', userDate: null);
      }
    } catch (e) {
      print(e);
      return FirebaseFireStoreUserInfoModel(
          errorMessage: 'Firebase Catch  Error: $e', userDate: null);
    }
  }
}
