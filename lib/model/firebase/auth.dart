import 'package:firebase_auth/firebase_auth.dart';

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
      return FirebaseAuthModel(userCredential: response, errorMessage: e.toString());
      
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
}
