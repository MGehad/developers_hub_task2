part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoaded extends PostsState {
  PostsLoaded(this.posts);

  final List<PostModel> posts;
}

final class PostsError extends PostsState {
  PostsError(this.message);

  final String message;
}
