// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCIKirdHFSH77fYa6keCl35fdhQDmeSHHI',
    appId: '1:575663963087:web:798500fa1f17d808eff0ba',
    messagingSenderId: '575663963087',
    projectId: 'tasko-7bd39',
    authDomain: 'tasko-7bd39.firebaseapp.com',
    storageBucket: 'tasko-7bd39.firebasestorage.app',
    measurementId: 'G-JX79S3TLGF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC08OiJkJSNt6I1nmGK6VvXyTvWo4QBlzE',
    appId: '1:575663963087:android:06e0f82abd4e038ceff0ba',
    messagingSenderId: '575663963087',
    projectId: 'tasko-7bd39',
    storageBucket: 'tasko-7bd39.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2i_rqquvAiGd4ra_u012w6kGXbjDS1mE',
    appId: '1:575663963087:ios:5824aa1c8f53085feff0ba',
    messagingSenderId: '575663963087',
    projectId: 'tasko-7bd39',
    storageBucket: 'tasko-7bd39.firebasestorage.app',
    iosBundleId: 'com.example.excpTraining',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2i_rqquvAiGd4ra_u012w6kGXbjDS1mE',
    appId: '1:575663963087:ios:5824aa1c8f53085feff0ba',
    messagingSenderId: '575663963087',
    projectId: 'tasko-7bd39',
    storageBucket: 'tasko-7bd39.firebasestorage.app',
    iosBundleId: 'com.example.excpTraining',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIKirdHFSH77fYa6keCl35fdhQDmeSHHI',
    appId: '1:575663963087:web:d2701d88aae99515eff0ba',
    messagingSenderId: '575663963087',
    projectId: 'tasko-7bd39',
    authDomain: 'tasko-7bd39.firebaseapp.com',
    storageBucket: 'tasko-7bd39.firebasestorage.app',
    measurementId: 'G-NGSF0X6KRW',
  );
}