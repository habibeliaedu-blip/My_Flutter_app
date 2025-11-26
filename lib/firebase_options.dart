import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

///
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    projectId: 'jokko-medapp',
    authDomain: 'jokko-medapp.firebaseapp.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    projectId: 'jokko-medapp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    projectId: 'jokko-medapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    projectId: 'jokko-medapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    projectId: 'jokko-medapp',
  );
}
