import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  AuthRepo._();

  static final AuthRepo instance = AuthRepo._();

  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static String get uid {
    return currentUser!.uid;
  }

  static User? get currentUser {
    return auth.currentUser;
  }

  static Future<void> reloadUserData() async {
    await currentUser!.reload();
  }

  static Future<void> updateUserName(String displayName) async {
    await currentUser!.updateDisplayName(displayName);
  }

  static Future<bool> checkEmailVerification() async {
    return currentUser!.emailVerified == true;
  }

  static Future<void> logOut() async {
    // await FirebaseFirestore.instance.clearPersistence();
    await auth.signOut();
  }

  static Future<void> sendPasswordResetEmail(
    String email,
    BuildContext context,
  ) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static Future<bool> checkOldPassword(String email, String password) async {
    final AuthCredential authCredential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    final UserCredential credentialResult = await currentUser!
        .reauthenticateWithCredential(authCredential);
    return credentialResult.user != null;
  }

  static Future<void> updateUserPassword(String newPassword) async {
    await currentUser!.updatePassword(newPassword);
  }
}
