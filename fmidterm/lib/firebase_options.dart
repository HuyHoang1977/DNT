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
    apiKey: 'AIzaSyBpr1BTkLBGULfrWGUoKlUBs4ROU6oykHA',
    appId: '1:944330309366:web:9fb06a073282d24c20b6d7',
    messagingSenderId: '944330309366',
    projectId: 'fmidterm-4db05',
    authDomain: 'fmidterm-4db05.firebaseapp.com',
    databaseURL: 'https://fmidterm-4db05-default-rtdb.firebaseio.com',
    storageBucket: 'fmidterm-4db05.firebasestorage.app',
    measurementId: 'G-T1DK96LCQN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGS-_oc01rPNCs16M60B57kBF5rq0VF6s',
    appId: '1:944330309366:android:f36d03e3b5dde3d120b6d7',
    messagingSenderId: '944330309366',
    projectId: 'fmidterm-4db05',
    databaseURL: 'https://fmidterm-4db05-default-rtdb.firebaseio.com',
    storageBucket: 'fmidterm-4db05.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCp-I8pmepdGPT6kbNPSBTg_Lm4O3YmahA',
    appId: '1:944330309366:ios:d8cb24b8490cf9d120b6d7',
    messagingSenderId: '944330309366',
    projectId: 'fmidterm-4db05',
    databaseURL: 'https://fmidterm-4db05-default-rtdb.firebaseio.com',
    storageBucket: 'fmidterm-4db05.firebasestorage.app',
    iosBundleId: 'com.example.fmidterm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCp-I8pmepdGPT6kbNPSBTg_Lm4O3YmahA',
    appId: '1:944330309366:ios:d8cb24b8490cf9d120b6d7',
    messagingSenderId: '944330309366',
    projectId: 'fmidterm-4db05',
    databaseURL: 'https://fmidterm-4db05-default-rtdb.firebaseio.com',
    storageBucket: 'fmidterm-4db05.firebasestorage.app',
    iosBundleId: 'com.example.fmidterm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBpr1BTkLBGULfrWGUoKlUBs4ROU6oykHA',
    appId: '1:944330309366:web:0659d62199bdd30920b6d7',
    messagingSenderId: '944330309366',
    projectId: 'fmidterm-4db05',
    authDomain: 'fmidterm-4db05.firebaseapp.com',
    databaseURL: 'https://fmidterm-4db05-default-rtdb.firebaseio.com',
    storageBucket: 'fmidterm-4db05.firebasestorage.app',
    measurementId: 'G-KCG4ZJZ238',
  );

}