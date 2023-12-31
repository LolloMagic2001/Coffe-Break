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
    apiKey: 'AIzaSyDZ4AB1k4IcIPPl-o49zh917rF_gnsVyqg',
    appId: '1:1007175375514:web:2b403d8089f423a2c21d23',
    messagingSenderId: '1007175375514',
    projectId: 'coffe-manage-d3a7e',
    authDomain: 'coffe-manage-d3a7e.firebaseapp.com',
    storageBucket: 'coffe-manage-d3a7e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAttB-PSDYMbSb-_n-gbfCbn0hA9h9mE7g',
    appId: '1:1007175375514:android:68263abf907855dbc21d23',
    messagingSenderId: '1007175375514',
    projectId: 'coffe-manage-d3a7e',
    storageBucket: 'coffe-manage-d3a7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFkHu9bg2qsa3aW2ZFu67sVdPb3o3CRjA',
    appId: '1:1007175375514:ios:819aa17c10aac72bc21d23',
    messagingSenderId: '1007175375514',
    projectId: 'coffe-manage-d3a7e',
    storageBucket: 'coffe-manage-d3a7e.appspot.com',
    iosClientId: '1007175375514-5bffvdbgbuhp49evuthn621gk2qjfab4.apps.googleusercontent.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFkHu9bg2qsa3aW2ZFu67sVdPb3o3CRjA',
    appId: '1:1007175375514:ios:6910d8e37581d4d5c21d23',
    messagingSenderId: '1007175375514',
    projectId: 'coffe-manage-d3a7e',
    storageBucket: 'coffe-manage-d3a7e.appspot.com',
    iosClientId: '1007175375514-k1216r29tbl0sgdin6edm8rovr1kobu9.apps.googleusercontent.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}
