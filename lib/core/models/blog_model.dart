import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class BlogModel {
  final int status;
  final BlogDataModel data;

  BlogModel({
    required this.status,
    required this.data,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      status: (json['status'] as num).toInt(),
      data: BlogDataModel.fromJson(json['blogs'] ?? 'empty'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blogs': data,
      'status': status,
    };
  }
}

class BlogDataModel {
  BlogDataModel({
    required this.blog,
  });

  late final List<Blog> blog;

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      blog = List.from(json['data']).map((e) => Blog.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = blog.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Blog {
  Blog({
    required this.id,
    required this.title,
    required this.image,
    // required this.desc,
  });

  late final int id;
  late final LanguageModel title;
  late final String image;
  // late final LanguageModel desc;

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = LanguageModel.fromMap(parseMapFromServer(json['title']));
    // desc = LanguageModel.fromMap(parseMapFromServer(json['desc']));
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    // _data['desc'] = desc;
    return _data;
  }
}
