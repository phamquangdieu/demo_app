import 'package:demo_app/features/posts/presentation/pages/list_post_page.dart';
import 'package:demo_app/features/users/presentation/bloc/user_cubit.dart';
import 'package:demo_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<UserCubit>().searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<UserCubit, UsersState>(
              builder: (context, state) {
                if (state is UsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersLoaded) {
                  return ListView.builder(
                    itemCount: state.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = state.filteredUsers[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          title: Text('${user.id}. ${user.login}'),
                          subtitle: Text(user.url),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListPostPage(userId: user.id),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is UsersError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('No users found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
