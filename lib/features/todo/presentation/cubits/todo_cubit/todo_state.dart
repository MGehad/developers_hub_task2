part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  TodoLoaded(this.tasks);

  final List<String> tasks;
}

final class TodoError extends TodoState {
  TodoError(this.message);

  final String message;
}
