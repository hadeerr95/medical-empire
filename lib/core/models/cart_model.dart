import 'package:medical_empire_app/core/util/language_model.dart';

class MainCartModel {
  final List<CartModel> data;

  MainCartModel({
    required this.data,
  });

  factory MainCartModel.fromJson(Map<String, dynamic> json) {
    return MainCartModel(
      data: List.from((json['data'] as List))
          .map((e) => CartModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CartModel {
  final int id;
  final LanguageModel slug;
  final String image;
  final String price;
  final LanguageModel name;
  late int quantity;
  final int stock;
  final int vendorId;

   int? attributeId;
  String? weight;
  LanguageModel? size;
  LanguageModel? color;
  String? attributeImage;

  CartModel({
    required this.id,
    required this.slug,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.vendorId,
    required this.weight,
    required this.size,
    required this.color,
    required this.attributeImage,
    required this.attributeId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      attributeId: json['attributeId'] != null? json['attributeId'] : null,
      slug:  LanguageModel.fromMap(json['slug']),
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      stock: json['stock'],
      vendorId: json['vendorId'],
      weight: json['weight'],
      size: json['size'] != null ? LanguageModel.fromMap(json['size']) : null,
      name:  LanguageModel.fromMap(json['name']),
      color:
          json['color'] != null ? LanguageModel.fromMap(json['color']) : null,
      attributeImage: json['attributeImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug.toJson(),
      'image': image,
      'price': price,
      'quantity': quantity,
      'stock': stock,
      'vendorId': vendorId,
      'weight': weight,
      'name': name.toJson(),
      'size': size != null ? size!.toJson() : null,
      'color': color != null ? color!.toJson() : null,
      'attributeImage': attributeImage,
      'attributeId':attributeId!= null? attributeId : null,
    };
  }
}
