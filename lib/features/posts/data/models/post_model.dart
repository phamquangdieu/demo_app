import 'package:demo_app/features/posts/domain/entities/post.dart';

class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Post toEntity() {
    return Post(id: id, title: title, body: body);
  }
}
