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
    apiKey: 'AIzaSyBkOZsSUmFB5sQb8ptgRwRHme0YDnZkdUs',
    appId: '1:862652244809:web:cccf65c3c60fa8cc913098',
    messagingSenderId: '862652244809',
    projectId: 'group7-artfolio',
    authDomain: 'group7-artfolio.firebaseapp.com',
    storageBucket: 'group7-artfolio.appspot.com',
    measurementId: 'G-79LM2KSP8X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJS0bQRgtsN-CWxOX-FQu6riQrJwDEN4U',
    appId: '1:862652244809:android:fbd3fbd390fbe6b4913098',
    messagingSenderId: '862652244809',
    projectId: 'group7-artfolio',
    storageBucket: 'group7-artfolio.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSmivHwtlFtQZeZbJWCffFPvdBsKIlJ6w',
    appId: '1:862652244809:ios:0821c79f256fe417913098',
    messagingSenderId: '862652244809',
    projectId: 'group7-artfolio',
    storageBucket: 'group7-artfolio.appspot.com',
    iosBundleId: 'com.example.group7Artfolio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSmivHwtlFtQZeZbJWCffFPvdBsKIlJ6w',
    appId: '1:862652244809:ios:0821c79f256fe417913098',
    messagingSenderId: '862652244809',
    projectId: 'group7-artfolio',
    storageBucket: 'group7-artfolio.appspot.com',
    iosBundleId: 'com.example.group7Artfolio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBkOZsSUmFB5sQb8ptgRwRHme0YDnZkdUs',
    appId: '1:862652244809:web:514bea23d7f8b510913098',
    messagingSenderId: '862652244809',
    projectId: 'group7-artfolio',
    authDomain: 'group7-artfolio.firebaseapp.com',
    storageBucket: 'group7-artfolio.appspot.com',
    measurementId: 'G-5F505CT6Z2',
  );
}
