import 'package:demo_app/core/di/service_locator.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_cubit.dart';
import 'package:demo_app/features/posts/presentation/pages/list_post_page.dart';
import 'package:demo_app/features/users/presentation/bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (_) => sl<UserCubit>()..fetchUsers()),
        BlocProvider<PostCubit>(create: (_) => sl<PostCubit>()..getPosts()),
      ],
      child: MaterialApp(
        title: 'Demo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: const ListPostPage(),
      ),
    );
  }
}
