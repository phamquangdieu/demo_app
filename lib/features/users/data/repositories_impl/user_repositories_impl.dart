import 'package:demo_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:demo_app/features/users/domain/entities/user.dart';
import 'package:demo_app/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<List<User>> getUsers(Map<String, dynamic>? params) async {
    final users = await userRemoteDataSource.getUsers(params);
    return users.map((model) => model.toEntity()).toList();
  }
}
