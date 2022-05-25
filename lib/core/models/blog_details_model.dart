import 'package:medical_empire_app/core/models/blog_model.dart';

class BLogDetailsModel {
  final int status;
  final Blog blog;

  BLogDetailsModel({
    required this.status,
    required this.blog,
  });

  factory BLogDetailsModel.fromJson(Map<String, dynamic> json) {
    return BLogDetailsModel(
      status: (json['status'] as num).toInt(),
      blog: Blog.fromJson(json['blog'] ?? 'empty'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blog': blog,
      'status': status,
    };
  }
}