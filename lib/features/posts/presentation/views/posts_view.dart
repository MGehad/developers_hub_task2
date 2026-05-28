import 'package:developers_hub_task2/features/posts/presentation/cubits/posts_cubit/posts_cubit.dart';
import 'package:developers_hub_task2/features/posts/presentation/widgets/posts_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..fetchPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts API Example'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: const SafeArea(child: PostsViewBody()),
      ),
    );
  }
}
