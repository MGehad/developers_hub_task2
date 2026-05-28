import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:developers_hub_task2/features/posts/data/models/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  Future<void> fetchPosts() async {
    emit(PostsLoading());
    try {
      final response = await _fetch();
      final List<dynamic> decoded = jsonDecode(response.body) as List<dynamic>;
      final posts = decoded
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList();

      emit(PostsLoaded(posts));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching posts: $e');
      }
      emit(
        PostsError(
          'Network connection was interrupted. Please check your internet and retry.',
        ),
      );
    }
  }

  Future<http.Response> _fetch() async {
    const String url = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http
        .get(Uri.parse(url), headers: const {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw http.ClientException(
        'Unexpected status code ${response.statusCode}',
        Uri.parse(url),
      );
    }

    return response;
  }
}
