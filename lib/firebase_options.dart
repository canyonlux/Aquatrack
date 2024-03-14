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
    apiKey: 'AIzaSyA4L0clyBTDl2TrweFWA0EeFIn5Z_Sr1zM',
    appId: '1:772928444351:web:d34c69e3d6ac7cd727730a',
    messagingSenderId: '772928444351',
    projectId: 'aquatrack-a9b48',
    authDomain: 'aquatrack-a9b48.firebaseapp.com',
    storageBucket: 'aquatrack-a9b48.appspot.com',
    measurementId: 'G-B4W676EKXJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaxfjfKWoPeqmwn9XwX5c2jj_mZztPCx4',
    appId: '1:772928444351:android:c17797763eecd6b427730a',
    messagingSenderId: '772928444351',
    projectId: 'aquatrack-a9b48',
    storageBucket: 'aquatrack-a9b48.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6247pm5DXauXibRkXsjkPqWYVSUkPSW8',
    appId: '1:772928444351:ios:6379c88d6992edd727730a',
    messagingSenderId: '772928444351',
    projectId: 'aquatrack-a9b48',
    storageBucket: 'aquatrack-a9b48.appspot.com',
    iosBundleId: 'com.example.h2orienta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6247pm5DXauXibRkXsjkPqWYVSUkPSW8',
    appId: '1:772928444351:ios:9d67acc9edb4ae0627730a',
    messagingSenderId: '772928444351',
    projectId: 'aquatrack-a9b48',
    storageBucket: 'aquatrack-a9b48.appspot.com',
    iosBundleId: 'com.example.h2orienta.RunnerTests',
  );
}