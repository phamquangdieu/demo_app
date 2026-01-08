import 'dart:async';

import 'package:demo_app/features/posts/presentation/pages/list_post_page.dart';
import 'package:demo_app/features/users/domain/entities/user.dart';
import 'package:demo_app/features/users/presentation/bloc/user_cubit.dart';
import 'package:demo_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});
  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  static const _pageSize = 20;
  Timer? _debounceTimer;
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  late final PagingController<int, User> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, User>(
      getNextPageKey: (state) {
        if (state.keys?.isEmpty ?? true) return 1;
        final lastPage = state.keys!.last;
        if ((state.pages?.last.length ?? 0) < _pageSize) return null;
        return lastPage + 1;
      },
      fetchPage: (pageKey) => _fetchPage(pageKey),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<User>> _fetchPage(int pageKey) async {
    if (_searchQuery.isEmpty) return [];
    return context.read<UserCubit>().fetchPage(pageKey, _searchQuery);
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = query;
      });
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
      _pagingController.refresh();
    });
  }

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
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Please enter a search query',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : PagingListener(
                    controller: _pagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedListView<int, User>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          scrollController: _scrollController,
                          builderDelegate: PagedChildBuilderDelegate<User>(
                            itemBuilder: (context, user, index) => Card(
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
                            ),
                            firstPageProgressIndicatorBuilder: (_) =>
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            newPageProgressIndicatorBuilder: (_) =>
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            noItemsFoundIndicatorBuilder: (_) =>
                                const Center(child: Text('No users found')),
                            firstPageErrorIndicatorBuilder: (context) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Error: ${state.error}'),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _pagingController.refresh(),
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  ),
          ),
        ],
      ),
    );
  }
}
