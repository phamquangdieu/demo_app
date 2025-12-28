import 'package:dio/dio.dart';

class DioClient {
  final apiClient = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  Future<Response> get(String path) async {
    try {
      final response = await apiClient.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
