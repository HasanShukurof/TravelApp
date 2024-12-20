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
    apiKey: 'AIzaSyBHywndvKh5pUsUVkQVSsc8-p3VsDW6fIs',
    appId: '1:439722351876:web:1dc5937b085fce77db8451',
    messagingSenderId: '439722351876',
    projectId: 'tripaz',
    authDomain: 'tripaz.firebaseapp.com',
    storageBucket: 'tripaz.firebasestorage.app',
    measurementId: 'G-V0HRPPNZS2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZ4jfJg4EbygtkUbzaDnyBTOJzQYgR0e8',
    appId: '1:439722351876:android:3f21332a0c5ec9e9db8451',
    messagingSenderId: '439722351876',
    projectId: 'tripaz',
    storageBucket: 'tripaz.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGe6eLfHkdtYl8sfik-16XsBq9u1C6PAs',
    appId: '1:439722351876:ios:685cbe693c8a265bdb8451',
    messagingSenderId: '439722351876',
    projectId: 'tripaz',
    storageBucket: 'tripaz.firebasestorage.app',
    iosBundleId: 'com.hasanshukurov.tripaz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGe6eLfHkdtYl8sfik-16XsBq9u1C6PAs',
    appId: '1:439722351876:ios:53113aca0c85e7fedb8451',
    messagingSenderId: '439722351876',
    projectId: 'tripaz',
    storageBucket: 'tripaz.firebasestorage.app',
    iosBundleId: 'com.hasanshukurov.tripaz',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHywndvKh5pUsUVkQVSsc8-p3VsDW6fIs',
    appId: '1:439722351876:web:69566b5fe66f4794db8451',
    messagingSenderId: '439722351876',
    projectId: 'tripaz',
    authDomain: 'tripaz.firebaseapp.com',
    storageBucket: 'tripaz.firebasestorage.app',
    measurementId: 'G-12DWJ690HZ',
  );
}
