import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class CreateCheckoutItemModel {
  CreateCheckoutItemModel({
    required this.id,
    required this.price,
    required this.quantity,
    required this.attributes,
  });

  late final int id;
  late final int price;
  late final int quantity;
  CreateCheckoutItemModelAttributes? attributes;

  CreateCheckoutItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    quantity = json['quantity'] ?? 0;
    attributes = json['attributes'] != null ? CreateCheckoutItemModelAttributes.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['attributes'] = attributes != null ? attributes!.toJson() : null;
    return _data;
  }
}

class CreateCheckoutItemModelAttributes {
  CreateCheckoutItemModelAttributes({
    required this.size,
    required this.color,
    required this.type,
    required this.image,
  });

  // late final LanguageModel size;
  // late final LanguageModel color;

  LanguageModel? size;
  LanguageModel? color;
  String? type;
  String? image;

  CreateCheckoutItemModelAttributes.fromJson(Map<String, dynamic> json) {
    size = json['size'] != null ? LanguageModel.fromMap(parseMapFromServer(json['size'])) : null;
    color = json['color'] != null ? LanguageModel.fromMap(parseMapFromServer(json['color'])) : null;
    type = json['type'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['size'] = size != null ? size!.toJson() : null;
    _data['color'] = color != null ? color!.toJson() : null;
    _data['type'] = type;
    _data['image'] = image;
    return _data;
  }
}
