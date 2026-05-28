import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_hub_task2/core/services/Firebase/auth_service.dart';
import 'package:developers_hub_task2/core/services/Firebase/firestore_service.dart';
import 'package:developers_hub_task2/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await AuthRepo.signInWithEmailAndPassword(email, password);

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
      await AuthRepo.signUpWithEmailAndPassword(user.email, user.password);

      await _addUser(user: user);
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

  Future<void> _addUser({required UserModel user}) async {
    emit(AuthLoading());
    await FirestoreRepo.createCollection(
      collectionName: "users",
      data: user.toJson(),
    );
  }

  Future<void> getUserData() async {
    emit(AuthLoading());
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirestoreRepo.getData(collectionName: "users");
      final List<UserModel> users = snapshot.docs
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
      emit(GetUserDataSuccess(users.first));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
