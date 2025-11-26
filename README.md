# JOKKO DIMBALI

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Firebase

This app is preconfigured for the jokko-medapp Firebase project (Android Studio
project ID `com.example.untitled1`). The generated `lib/firebase_options.dart`
contains platform options for Android, iOS/macOS, Windows, Linux, and Web.

To verify the connection locally:

1. Run `flutter pub get` to install `firebase_core` and `firebase_auth`.
2. Ensure each platform directory includes the generated Google services files
   from Firebase console (e.g., `google-services.json`, `GoogleService-Info.plist`).
3. Launch the app; Firebase initialization occurs in `main()` via
   `DefaultFirebaseOptions.currentPlatform`.
