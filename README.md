# developers_hub_task2

Flutter app built with Firebase, Bloc, SharedPreferences, and an API demo screen.

## Overview

This project includes:

- Firebase Authentication for login and sign up
- Cloud Firestore for user profile data
- SharedPreferences for local note storage
- Bloc/Cubit state management
- A posts API example that fetches data from `https://jsonplaceholder.typicode.com/posts`

The app starts on the login screen, navigates through the auth flow, shows a home screen, and provides a local notes feature plus a separate posts API example screen.

## Setup

### 1. Install prerequisites

Make sure these are available on your machine:

- Flutter SDK
- Dart SDK that matches the version constraint in `pubspec.yaml`
- Android Studio, Xcode, or Visual Studio depending on the target platform
- Firebase CLI if you need to reconfigure Firebase

### 2. Get dependencies

Run:

```bash
flutter pub get
```

### 3. Configure Firebase

The app initializes Firebase in `lib/main.dart` before calling `runApp`.

You need a valid Firebase project and the generated `lib/firebase_options.dart` file.

Make sure the following services are enabled in Firebase:

- Authentication
- Cloud Firestore

If you need to regenerate the Firebase configuration, run:

```bash
flutterfire configure
```

### 4. Run the app

Use one of the following commands:

```bash
flutter run
```

Or target a specific platform:

```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

## Features

### Authentication

The auth feature is located under `lib/features/auth` and uses `AuthCubit`.

It includes:

- Login screen
- Sign up screen
- Forgot password screen
- User profile loading from Firestore

### Home screen

The home page shows the current user profile and a prominent action to open the notes feature.

### Notes feature

The notes feature is powered by `TodoCubit` in `lib/features/todo/presentation/cubits/todo_cubit`.

It supports:

- Add note
- Update note
- Delete note
- Loading notes from local storage

Notes are stored as a string list in SharedPreferences through `LocalDatabase`.

### Posts API example

The API demo lives under `lib/features/posts` and uses `PostsCubit`.

It:

- Fetches posts from `https://jsonplaceholder.typicode.com/posts`
- Shows loading and error states
- Provides a retry action when the request fails

## Project Structure

- `lib/main.dart` app bootstrap and Firebase initialization
- `lib/app.dart` application widget and theme setup
- `lib/features/auth` auth UI, cubit, and models
- `lib/features/home` home screen UI
- `lib/features/todo` local notes feature and posts API entry point
- `lib/features/posts` API example feature
- `lib/core/services` shared services such as Firebase and local storage

## Notes

- The app starts at the login screen by default.
- Firebase must be configured correctly before running on a device or emulator.
- The posts API example requires internet access.
- The notes feature uses local persistence, so saved notes remain after app restart.

