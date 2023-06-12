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
    apiKey: 'AIzaSyDBrajZilXKzSPy2VHUdzBdTgQ45ge6TzQ',
    appId: '1:713996855958:web:6ab6c1450f0adef7db70b7',
    messagingSenderId: '713996855958',
    projectId: 'fast-kcal',
    authDomain: 'fast-kcal.firebaseapp.com',
    storageBucket: 'fast-kcal.appspot.com',
    measurementId: 'G-SBZG3J327F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBApIwtSSfLWiHNV24OFv_VN122pBQDLeU',
    appId: '1:713996855958:android:ab01411c0f5e0031db70b7',
    messagingSenderId: '713996855958',
    projectId: 'fast-kcal',
    storageBucket: 'fast-kcal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY8oVdgDs0khRLx0HWTIBDA5HrP4e0HQU',
    appId: '1:713996855958:ios:9791af3b8c880a37db70b7',
    messagingSenderId: '713996855958',
    projectId: 'fast-kcal',
    storageBucket: 'fast-kcal.appspot.com',
    iosClientId: '713996855958-kdfad19gdc51rsql4et1jgmb1bj3vkkq.apps.googleusercontent.com',
    iosBundleId: 'com.example.fastKcal',
  );
}
