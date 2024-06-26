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
    apiKey: 'AIzaSyAyO6_8FG-nJH3AxoqIwsyy5muo8v-b7eo',
    appId: '1:58425596466:web:727d1b7697069972bdfa2b',
    messagingSenderId: '58425596466',
    projectId: 'twitch-a5998',
    authDomain: 'twitch-a5998.firebaseapp.com',
    storageBucket: 'twitch-a5998.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQq2pPCF5O5a0i9hN4NWkbHf1mN2YTZow',
    appId: '1:58425596466:android:320907cb4d6b5b88bdfa2b',
    messagingSenderId: '58425596466',
    projectId: 'twitch-a5998',
    storageBucket: 'twitch-a5998.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6nVvfCbnMNkLwn553qcdENgfA2_8AX8g',
    appId: '1:58425596466:ios:9485c81234db104cbdfa2b',
    messagingSenderId: '58425596466',
    projectId: 'twitch-a5998',
    storageBucket: 'twitch-a5998.appspot.com',
    iosBundleId: 'com.example.twitchClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6nVvfCbnMNkLwn553qcdENgfA2_8AX8g',
    appId: '1:58425596466:ios:2bf1a78a01ba3aecbdfa2b',
    messagingSenderId: '58425596466',
    projectId: 'twitch-a5998',
    storageBucket: 'twitch-a5998.appspot.com',
    iosBundleId: 'com.example.twitchClone.RunnerTests',
  );
}
