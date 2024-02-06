// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAO9fmymtVVZ2xr3l6c3OZKTPTgpSuRphU',
    appId: '1:956355807440:android:f7901b2a10a6935f5676d5',
    messagingSenderId: '956355807440',
    projectId: 'recychamp',
    storageBucket: 'recychamp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '1:956355807440:ios:80594df4a7d0cea05676d5',
    appId: '1:956355807440:ios:6d8b0255efdc01485676d5',
    messagingSenderId: '956355807440',
    projectId: 'recychamp',
    storageBucket: 'recychamp.appspot.com',
    iosBundleId: 'com.y311.recychamp',
  );
}
