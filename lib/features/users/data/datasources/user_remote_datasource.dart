import 'package:demo_app/core/network/dio_client.dart';
import 'package:demo_app/features/users/data/models/user.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await dioClient.get('/users');

    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }
}
