import 'package:bloc/bloc.dart';
import 'package:developers_hub_task2/core/services/Firebase/auth_service.dart';
import 'package:developers_hub_task2/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final credential = await AuthRepo.signInWithEmailAndPassword(
        email,
        password,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError('Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({required UserModel user}) async {
    emit(AuthLoading());
    try {
      final credential = await AuthRepo.signUpWithEmailAndPassword(
        user.email,
        user.password,
      );

      await AuthRepo.updateUserName(user.name);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError('The account already exists for that email.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _addUserData({required UserModel user}) async {
    final db = FirebaseStorage.instance;
    final ref = db.ref().child('users/${user.email}.json');
    await ref.putString(user.toJson().toString());
  }
}
