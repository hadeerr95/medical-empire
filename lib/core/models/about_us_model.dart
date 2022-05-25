import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class AboutUsModel {
  final int status;
  final AboutUsDataModel data;

  AboutUsModel({
    required this.status,
    required this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      status: (json['status'] as num).toInt(),
      data: AboutUsDataModel.fromJson(json['about_us'] ?? 'empty'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'about_us': data,
      'status': status,
    };
  }
}

class AboutUsDataModel {
  AboutUsDataModel({
    required this.id,
    required this.name,
    // required this.description,
  });

  late final int id;
  late final LanguageModel name;
  // late final LanguageModel description;

  AboutUsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    // description = LanguageModel.fromMap(parseMapFromServer(json['desc']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    // _data['desc'] = description;
    return _data;
  }
}