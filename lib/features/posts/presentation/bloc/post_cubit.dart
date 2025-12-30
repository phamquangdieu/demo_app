import 'package:demo_app/features/posts/domain/usecases/get_list_post_usecase.dart';
import 'package:demo_app/features/posts/domain/usecases/get_post_by_user_usecase.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostsState> {
  final GetListPostUsecase getPostsUseCase;
  final GetPostByUserUsecase getPostByUserUseCase;

  PostCubit(this.getPostsUseCase, this.getPostByUserUseCase)
    : super(PostsInitial());

  Future<void> getPosts({int? userId}) async {
    emit(PostsLoading());
    try {
      final posts = userId == null
          ? await getPostsUseCase()
          : await getPostByUserUseCase(userId);
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
