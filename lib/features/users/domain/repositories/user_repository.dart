import 'package:demo_app/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(Map<String, dynamic>? params);
}
