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
        return macos;
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
    apiKey: 'AIzaSyAGGiGLfSQM59MZRxBnsjpZ0NiDiJmRkx4',
    appId: '1:459842677939:web:039395aa62ab59c7e194c6',
    messagingSenderId: '459842677939',
    projectId: 'mchs-kr',
    authDomain: 'mchs-kr.firebaseapp.com',
    storageBucket: 'mchs-kr.appspot.com',
    measurementId: 'G-0G74J9H194',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArlI1I0ROIqHbrcRK1KlgNkmWic5l4ZWs',
    appId: '1:459842677939:android:f6b31c3a74944998e194c6',
    messagingSenderId: '459842677939',
    projectId: 'mchs-kr',
    storageBucket: 'mchs-kr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWZPdzDH9pnV5SVAJD24UoN6nMoMo15WU',
    appId: '1:459842677939:ios:c86a5cd0e2c7fcffe194c6',
    messagingSenderId: '459842677939',
    projectId: 'mchs-kr',
    storageBucket: 'mchs-kr.appspot.com',
    iosBundleId: 'com.example.burkutApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWZPdzDH9pnV5SVAJD24UoN6nMoMo15WU',
    appId: '1:459842677939:ios:70639fc7395dfe44e194c6',
    messagingSenderId: '459842677939',
    projectId: 'mchs-kr',
    storageBucket: 'mchs-kr.appspot.com',
    iosBundleId: 'com.example.burkutApp.RunnerTests',
  );
}