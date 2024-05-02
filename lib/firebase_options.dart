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
    apiKey: 'AIzaSyCsdxwpvjc-A1-fxCIrX8av0E_SAyuodX0',
    appId: '1:492037512529:web:5c3c5378a7f174f657c770',
    messagingSenderId: '492037512529',
    projectId: 'projects-sheet',
    authDomain: 'projects-sheet.firebaseapp.com',
    storageBucket: 'projects-sheet.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoCx2kfhUYHWhGO-rJL0rbP-Wd-tuH3w8',
    appId: '1:492037512529:android:62eaa3e88ff0747357c770',
    messagingSenderId: '492037512529',
    projectId: 'projects-sheet',
    storageBucket: 'projects-sheet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAG6iX9gEF5CH2UPaIfyEoE_qcy8FW8WZk',
    appId: '1:492037512529:ios:d9504e58084e448357c770',
    messagingSenderId: '492037512529',
    projectId: 'projects-sheet',
    storageBucket: 'projects-sheet.appspot.com',
    iosBundleId: 'com.example.chatWithUs',
  );
}
