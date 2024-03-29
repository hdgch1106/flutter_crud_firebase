// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCChgWMrYfvpsJIovV7CPmJvBe5DC3WNqs',
    appId: '1:111321757072:web:a890b11a44d5022a42ef15',
    messagingSenderId: '111321757072',
    projectId: 'test-crud-68bc1',
    authDomain: 'test-crud-68bc1.firebaseapp.com',
    storageBucket: 'test-crud-68bc1.appspot.com',
    measurementId: 'G-Z865R6GRJZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8N41BVTpDtXix-CWMczMv38JcJEqteB4',
    appId: '1:111321757072:android:72914052e38bf69c42ef15',
    messagingSenderId: '111321757072',
    projectId: 'test-crud-68bc1',
    storageBucket: 'test-crud-68bc1.appspot.com',
  );
}
