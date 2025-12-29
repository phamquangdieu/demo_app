import 'package:demo_app/features/posts/presentation/bloc/post_cubit.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPostPage extends StatelessWidget {
  const ListPostPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post List')),
      body: BlocBuilder<PostCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      '${index + 1}. ${post.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      post.body,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          } else if (state is PostsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press button to load posts'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostCubit>().getPosts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
