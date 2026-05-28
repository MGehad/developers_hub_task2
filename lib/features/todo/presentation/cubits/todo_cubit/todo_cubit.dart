import 'package:bloc/bloc.dart';
import 'package:developers_hub_task2/core/services/local_database/local_database.dart';
import 'package:flutter/foundation.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  Future<void> loadTasks() async {
    emit(TodoLoading());
    try {
      emit(TodoLoaded(LocalDatabase.getTasksList()));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> addTask(String task) async {
    emit(TodoLoading());
    try {
      await LocalDatabase.addTask(task);
      emit(TodoLoaded(LocalDatabase.getTasksList()));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> updateTask({required int index, required String task}) async {
    emit(TodoLoading());
    try {
      await LocalDatabase.updateTask(index: index, task: task);
      emit(TodoLoaded(LocalDatabase.getTasksList()));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> deleteTask(int index) async {
    emit(TodoLoading());
    try {
      await LocalDatabase.deleteTask(index);
      emit(TodoLoaded(LocalDatabase.getTasksList()));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
