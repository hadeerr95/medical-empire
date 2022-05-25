import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class BrandsModel {
  final List<Brand> brands;
  final int status;

  const BrandsModel({
    required this.brands,
    required this.status,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      brands: List.from(json['brands']).map((e) => Brand.fromJson(e)).toList(),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brands': brands,
      'status': status,
    };
  }
}

// class BrandsDataModel {
//   BrandsDataModel({
//     required this.brands,
//   });
//
//   late final List<Brand> brands;
//
//   BrandsDataModel.fromJson(Map<String, dynamic> json) {
//     if (json['brands'] != null) {
//       brands = List.from(json['brands']).map((e) => Brand.fromJson(e)).toList();
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['brands'] = brands.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.image,
  });

  late final int id;
  late final LanguageModel name;
  late final String image;

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    if(json['name'] != null){
      name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    }
    image = json['image']??'empty';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}
