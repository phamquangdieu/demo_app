import 'package:demo_app/features/posts/domain/entities/post.dart';
import 'package:demo_app/features/posts/domain/repositories/post_repository.dart';

class GetPostByUserUsecase {
  final PostRepository repository;

  GetPostByUserUsecase(this.repository);

  Future<List<Post>> call(int userId) {
    return repository.getPostsByUserId(userId);
  }
}
