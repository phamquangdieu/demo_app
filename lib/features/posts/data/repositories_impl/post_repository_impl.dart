import 'package:demo_app/features/posts/data/datasource/post_remote_datasource.dart';
import 'package:demo_app/features/posts/domain/entities/post.dart';
import 'package:demo_app/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getListPosts() async {
    final postModels = await remoteDataSource.getPosts();
    return postModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    final postModels = await remoteDataSource.getPostsByUserId(userId);
    return postModels.map((model) => model.toEntity()).toList();
  }
}
