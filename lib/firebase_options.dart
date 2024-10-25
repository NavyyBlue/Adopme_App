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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAI-juFct7M8aTAG4xCMmgxSdyGGdrKUac',
    appId: '1:541730914036:android:b1a894b2d404e6fbb7a8a1',
    messagingSenderId: '541730914036',
    projectId: 'adoptme-648f1',
    databaseURL: 'https://adoptme-648f1-default-rtdb.firebaseio.com',
    storageBucket: 'adoptme-648f1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqLd4oL49mMooo-yvZgtRBoYJhU5fv7qU',
    appId: '1:541730914036:ios:037790abc8f5059db7a8a1',
    messagingSenderId: '541730914036',
    projectId: 'adoptme-648f1',
    databaseURL: 'https://adoptme-648f1-default-rtdb.firebaseio.com',
    storageBucket: 'adoptme-648f1.appspot.com',
    androidClientId: '541730914036-7iur40l6jnl6reelu6oj5f8rcmg7c947.apps.googleusercontent.com',
    iosClientId: '541730914036-7s6r1ihu2717lnspcrl78int8lmtjga1.apps.googleusercontent.com',
    iosBundleId: 'com.coderamigos.adopme.adopmeFrontend',
  );
}
