import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

import 'home_feed_model.dart';

class WishlistModel {

  WishlistModel({
    required this.products,
    required this.status,
  });

  late final List<ProductModel> products;
  late final int status;

  WishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(json['products'] != null) {
      products = List.from(json['products'])
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }

}

// class ProductsDataModel {
//   late final int id;
//   late final LanguageModel name;
//   late final String price;
//   late final String image;
//
//   ProductsDataModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.image,
//
//   });
//
//
//   ProductsDataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = LanguageModel.fromMap(parseMapFromServer(json['name']));
//     price = json['price'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['price'] = price;
//     _data['image'] = image;
//     return _data;
//   }
//
// }