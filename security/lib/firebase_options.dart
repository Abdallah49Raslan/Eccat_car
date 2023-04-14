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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTnts4da0M1t4G7HQLioKTN7s0H61O5CQ',
    appId: '1:437756449159:android:80d3ee06c646ca90ea0322',
    messagingSenderId: '437756449159',
    projectId: 'security-d956d',
    databaseURL: 'https://security-d956d-default-rtdb.firebaseio.com',
    storageBucket: 'security-d956d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGcf-3HGs4ZSWWDgHMeyLerulbDwD1c6Q',
    appId: '1:437756449159:ios:73d4a9f66226b068ea0322',
    messagingSenderId: '437756449159',
    projectId: 'security-d956d',
    databaseURL: 'https://security-d956d-default-rtdb.firebaseio.com',
    storageBucket: 'security-d956d.appspot.com',
    iosClientId: '437756449159-ej6pf50s4stnr14lbb7lg82nses1mn3b.apps.googleusercontent.com',
    iosBundleId: 'com.example.security',
  );
}