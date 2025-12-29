import 'package:demo_app/features/posts/domain/usecases/get_list_post_usecase.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostsState> {
  final GetListPostUsecase getPostsUseCase;

  PostCubit(this.getPostsUseCase) : super(PostsInitial());

  Future<void> getPosts() async {
    emit(PostsLoading());
    try {
      final posts = await getPostsUseCase();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
