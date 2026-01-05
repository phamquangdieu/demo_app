import 'package:demo_app/core/network/dio_client.dart';
import 'package:demo_app/features/users/data/models/user.dart';
import 'package:dio/dio.dart';

class ForbiddenException implements Exception {
  final String message;

  const ForbiddenException(this.message);

  @override
  String toString() => 'ForbiddenException: $message';
}

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers(Map<String, dynamic>? params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<UserModel>> getUsers(Map<String, dynamic>? params) async {
    try {
      final response = await dioClient.get(
        '/search/users',
        queryParameters: params,
      );
      return (response.data['items'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw const ForbiddenException(
          'API rate limit exceeded. Please wait and try again.',
        );
      }
      rethrow;
    }
  }
}
