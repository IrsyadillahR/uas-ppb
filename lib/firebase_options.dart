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
    apiKey: 'AIzaSyAY1NjfnMRXJGcGmvabWTPqFeXJC0Ly4Pk',
    appId: '1:745369902486:web:21689681214c8aea1151b7',
    messagingSenderId: '745369902486',
    projectId: 'uas-ppb-f3c13',
    authDomain: 'uas-ppb-f3c13.firebaseapp.com',
    storageBucket: 'uas-ppb-f3c13.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDawf9uL2yEqcwYtPnaW1gZld90DkLRgpU',
    appId: '1:745369902486:android:e05d1abc3f5b33f91151b7',
    messagingSenderId: '745369902486',
    projectId: 'uas-ppb-f3c13',
    storageBucket: 'uas-ppb-f3c13.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAF15ljzXR4Vq4Zv70O1ZYLjNoZHL3nJGc',
    appId: '1:745369902486:ios:c3ef8fd728286d651151b7',
    messagingSenderId: '745369902486',
    projectId: 'uas-ppb-f3c13',
    storageBucket: 'uas-ppb-f3c13.appspot.com',
    iosBundleId: 'com.example.uasPpb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAF15ljzXR4Vq4Zv70O1ZYLjNoZHL3nJGc',
    appId: '1:745369902486:ios:c3ef8fd728286d651151b7',
    messagingSenderId: '745369902486',
    projectId: 'uas-ppb-f3c13',
    storageBucket: 'uas-ppb-f3c13.appspot.com',
    iosBundleId: 'com.example.uasPpb',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAY1NjfnMRXJGcGmvabWTPqFeXJC0Ly4Pk',
    appId: '1:745369902486:web:d624d9febdac67311151b7',
    messagingSenderId: '745369902486',
    projectId: 'uas-ppb-f3c13',
    authDomain: 'uas-ppb-f3c13.firebaseapp.com',
    storageBucket: 'uas-ppb-f3c13.appspot.com',
  );
}
