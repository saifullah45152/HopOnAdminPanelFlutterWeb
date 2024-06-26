// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBGhmEZRI81g1Mf0DTMH-Mj2zVIPkM2bUg',
    appId: '1:1020227698379:web:c4b39e75fae0dd7ae9654e',
    messagingSenderId: '1020227698379',
    projectId: 'hop-on-85d9b',
    authDomain: 'hop-on-85d9b.firebaseapp.com',
    databaseURL: 'https://hop-on-85d9b-default-rtdb.firebaseio.com',
    storageBucket: 'hop-on-85d9b.appspot.com',
    measurementId: 'G-5BCFMKK7BK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDy3OyHCm-apki8-TVz806SzQ9mHihDuOE',
    appId: '1:1020227698379:android:a5527895f4f72e23e9654e',
    messagingSenderId: '1020227698379',
    projectId: 'hop-on-85d9b',
    databaseURL: 'https://hop-on-85d9b-default-rtdb.firebaseio.com',
    storageBucket: 'hop-on-85d9b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWFIN7hHAj8wVwZxXwTTFX6hON3QQ71hw',
    appId: '1:1020227698379:ios:870d9a38208fe3eae9654e',
    messagingSenderId: '1020227698379',
    projectId: 'hop-on-85d9b',
    databaseURL: 'https://hop-on-85d9b-default-rtdb.firebaseio.com',
    storageBucket: 'hop-on-85d9b.appspot.com',
    androidClientId: '1020227698379-c1equp801dnb1b2fvlcqa24la489h3at.apps.googleusercontent.com',
    iosClientId: '1020227698379-kjptkmcf46kbo3fo587qncq0uodld9ka.apps.googleusercontent.com',
    iosBundleId: 'com.santosenoque.flutterWebDashboard',
  );
}
