import 'package:demo_app/features/users/domain/entities/user.dart';

class UserModel {
  final int id;
  final String login;
  final String avatarUrl;
  final String url;

  UserModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.url,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
    );
  }

  User toEntity() {
    return User(id: id, login: login, avatarUrl: avatarUrl, url: url);
  }
}
