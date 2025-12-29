import 'package:demo_app/core/network/dio_client.dart';
import 'package:demo_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;
  static const int _defaultLimit = 20;

  PostRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await dioClient.get(
      '/posts',
      // queryParameters: {'_limit': _defaultLimit},
    );

    return (response.data as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }
}
