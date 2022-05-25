import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

// class FAQsModel {
//   final BrandsDataModel brands;
//   final int status;
//
//   const FAQsModel({
//     required this.brands,
//     required this.status,
//   });
//
//   factory FAQsModel.fromJson(Map<String, dynamic> json) {
//     return FAQsModel(
//       brands: BrandsDataModel.fromJson(json['brands'] ?? 'empty'),
//       status: (json['status'] as num).toInt(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'brands': brands,
//       'status': status,
//     };
//   }
// }

class FAQsModel {
  FAQsModel({
    required this.faqs,
    required this.status,
  });

  late final List<FAQ> faqs;
  late final int status;

  FAQsModel.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = List.from(json['faqs']).map((e) => FAQ.fromJson(e)).toList();
    }
    if(json['status'] != null){
      status = (json['status'] as num).toInt();
    }

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['faqs'] = faqs.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class FAQ {
  FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });

  late final int id;
  late final LanguageModel question;
  late final LanguageModel answer;

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = LanguageModel.fromMap(parseMapFromServer(json['question']));
    answer = LanguageModel.fromMap(parseMapFromServer(json['answer']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['answer'] = answer;
    return _data;
  }
}
