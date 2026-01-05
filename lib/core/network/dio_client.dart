import 'package:dio/dio.dart';

class DioClient {
  final apiClient = Dio(
    BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },
    ),
  );

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await apiClient.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
