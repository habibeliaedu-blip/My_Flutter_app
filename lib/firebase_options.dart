import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for the Firebase project jokko-medapp / com.example.untitled1.
///
/// These values mirror the output of `flutterfire configure` for the registered
/// Android Studio project "untitled1" that targets the jokko-medapp Firebase
/// project across Android, iOS, macOS, Windows, Linux, and Web.
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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0r05HCX_CaZTd1_NfZQuzGf2MT7w6YAo',
    appId: '1:105729638505:web:9a9d381c07701e00c5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    authDomain: 'jokko-medapp.firebaseapp.com',
    storageBucket: 'jokko-medapp.appspot.com',
    measurementId: 'G-4LJHD5EFS8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3PfyOavJB0qjaPL09-iSu1L8q_S3taQA',
    appId: '1:105729638505:android:a7a63b4a284d6a8ec5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    storageBucket: 'jokko-medapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPIDz62jI1E5JbCfJiFvUk4pC8d_skn5E',
    appId: '1:105729638505:ios:9f31743d7d1d49a0c5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    storageBucket: 'jokko-medapp.appspot.com',
    iosBundleId: 'com.example.untitled1',
    iosClientId: '105729638505-fl9d413l34n9449qdb5q8vr26qmfo4up.apps.googleusercontent.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnwxMx_5W6uFO5S14FVQJZaAmPj0Eo5cQ',
    appId: '1:105729638505:ios:e4d6b7c9566dd8b6c5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    storageBucket: 'jokko-medapp.appspot.com',
    iosBundleId: 'com.example.untitled1',
    iosClientId: '105729638505-pv8uj5r0kv6bfrdu2p2m0lcnihshbmdf.apps.googleusercontent.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBTSD7su3l7osL77H-pFe7zuHsPLzYn4Ng',
    appId: '1:105729638505:web:1a889700c86cbadbcc5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    storageBucket: 'jokko-medapp.appspot.com',
    measurementId: 'G-0EQEP41QEQ',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyD20nKifIpPO2bt5POjFvM5kbkQxa4VA5Y',
    appId: '1:105729638505:web:e2ad3e935af7b8bfcc5165c',
    messagingSenderId: '105729638505',
    projectId: 'jokko-medapp',
    storageBucket: 'jokko-medapp.appspot.com',
    measurementId: 'G-L4X79QW3XR',
  );
}
