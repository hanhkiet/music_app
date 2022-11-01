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
    apiKey: 'AIzaSyCkOqCUDERERvTvuFqW6QWJypz3aE6VN1s',
    appId: '1:744546502525:web:bc5f0a6b94a1743f0cae14',
    messagingSenderId: '744546502525',
    projectId: 'music-app-6681a',
    authDomain: 'music-app-6681a.firebaseapp.com',
    storageBucket: 'music-app-6681a.appspot.com',
    measurementId: 'G-DP4PJFMQTL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQh4ejUH4I7rYivKBUSR9iiYW0X8D_2fc',
    appId: '1:744546502525:android:5df77ebf834b4c820cae14',
    messagingSenderId: '744546502525',
    projectId: 'music-app-6681a',
    storageBucket: 'music-app-6681a.appspot.com',
  );
}