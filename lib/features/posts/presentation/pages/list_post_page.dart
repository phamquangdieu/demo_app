import 'package:demo_app/features/posts/presentation/bloc/post_cubit.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPostPage extends StatefulWidget {
  const ListPostPage({super.key, this.userId});

  final int? userId;

  @override
  State<ListPostPage> createState() => _ListPostPageState();
}

class _ListPostPageState extends State<ListPostPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getPosts(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.userId == null
        ? 'Post List'
        : 'Posts of User ${widget.userId}';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                      '${post.id}. ${post.title}',
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
        onPressed: () =>
            context.read<PostCubit>().getPosts(userId: widget.userId),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
