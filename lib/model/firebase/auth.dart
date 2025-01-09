import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../main.dart';

class FirebaseAuthModel {
  final String? errorMessage;
  final UserCredential? userCredential;

  FirebaseAuthModel({required this.errorMessage, required this.userCredential});

  // static firebaseAuthResult(
  //     {required String errorMessageValue,
  //     required UserCredential userCredentialValue}) {
  //   userCredential = userCredentialValue;
  //   errorMessage = errorMessageValue;
  // }

//--------------------------- FireBase SignUp ------------------------//

  static Future<FirebaseAuthModel> registerWitEmailandPassword(
      {required String email, required String password}) async {
    UserCredential? response;
    try {
      response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('😁😁😁User created: ${response.user!.email}');
      return FirebaseAuthModel(
          userCredential: response, errorMessage: 'everything is ok');
    } catch (e) {
      response = null;
      return FirebaseAuthModel(
          userCredential: response, errorMessage: e.toString());
    }
  }

  //--------------------------- FireBase Login ------------------------//
  static Future<FirebaseAuthModel> loginWithEmailAndPassWord(
      {required String email, required String password}) async {
    UserCredential? response;
    try {
      response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('🤑🤑🤑User created: ${response.user!.email}');
      return FirebaseAuthModel(
          userCredential: response, errorMessage: 'everything is ok');
    } catch (e) {
      response = null;
      print('😭😭😭Error creating user: $e');
      return FirebaseAuthModel(
          userCredential: response, errorMessage: e.toString());
    }
  }

  /// Signs the user out of Firebase Authentication.
  ///
  /// If the user is currently signed in, this will clear their authentication
  /// state. If the user is not signed in, this is a no-op.
  ///
  /// Returns a [Future] that resolves when the sign out is complete.

  //--------------------------- FireBase Logout ------------------------//

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //--------------------------- FireBase Email Verification ------------------------//

  static Future<void> emailVerification() async {
    try {
      User? _user = FirebaseAuth.instance.currentUser;
      if (_user != null) {
        FirebaseAuth.instance.setLanguageCode('en');
        await _user.verifyBeforeUpdateEmail(_user.email ?? '');
        print('👌👌👌 user email : ${_user.email}');
        await _user.sendEmailVerification();
        SnackBarCustom.build(
          context: navigatorKey.currentContext!,
          message: 'Please check your email for verification',
        );
      }
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      print('👾👾👾 email verification error $e');
    }
  }

  //--------------------------- FireBase Forget Password ------------------------//

  static Future<void> resetPassword({required String email}) async {
    //   final actionCodeSettings = ActionCodeSettings(
    //   // Optional. URL you want to redirect back to after the user has successfully reset their password
    //   url: 'https://www.yourapp.com/reset-password',
    //   // This will ensure the link is opened only in the app
    //   handleCodeInApp: true,
    // );
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
