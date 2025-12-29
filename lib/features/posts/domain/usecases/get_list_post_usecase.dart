import 'package:demo_app/features/posts/domain/entities/post.dart';
import 'package:demo_app/features/posts/domain/repositories/post_repository.dart';

class GetListPostUsecase {
  final PostRepository repository;

  GetListPostUsecase(this.repository);

  Future<List<Post>> call() {
    return repository.getListPosts();
  }
}
