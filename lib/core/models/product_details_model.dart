import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

import 'home_feed_model.dart';

class ProductFeedModel {
  final ProductDetailsModel data;
  final int status;

  const ProductFeedModel({
    required this.data,
    required this.status,
  });

  factory ProductFeedModel.fromJson(Map<String, dynamic> json) {
    return ProductFeedModel(
      data: ProductDetailsModel.fromJson(json['data'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'status': status,
    };
  }
}

class ProductDetailsModel {
  ProductDetailsModel({
    required this.product,
    required this.related_products,
  });

  late final ProductModel product;
  late final List<ProductModel> related_products;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json['product']);

    if (json['related_products'] != null) {
      related_products = List.from(json['related_products'])
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product;
    _data['related_products'] =
        related_products.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductModel {
  ProductModel({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.slug,
    required this.short_desc,
    required this.brandId,
    required this.price,
    required this.oldPrice,
    required this.special,
    required this.status,
    required this.freeShipping,
    required this.countryOrigin,
    required this.quantityInStock,
    required this.image,
    required this.gallery,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.categories,
    required this.brand,
    required this.reviews,
    required this.size_attributes,
    required this.color_attributes,
    //required this.full_desc,
  });

  late final int id;
  late final int vendorId;
  late final LanguageModel name;
  late final LanguageModel slug;
  late final LanguageModel short_desc;

  //late final LanguageModel full_desc;
  late final int brandId;
  late String price;
  String? oldPrice;
  late final int special;
  late final int status;
  late final int freeShipping;
  late final String countryOrigin;
  late final int quantityInStock;
  late String image;
  List<String>? gallery;
  String? length;
  String? width;
  String? height;
  String? weight;
  late final List<CategoryModel> categories;
  late final BrandModel brand;
  List<ReviewsModel>? reviews;
  List<SizeModel>? size_attributes;
  List<ColorModel>? color_attributes;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    debugPrint('Parsed => id');

    vendorId = json['vendor_id'];
    print('Parsed => vendorId');

    if (json['name'] != null) {
      name = LanguageModel.fromMap(parseMapFromServer(json['name']));

      print('Parsed => name');
    }

    if (json['slug'] != null) {
      slug = LanguageModel.fromMap(parseMapFromServer(json['slug']));

      print('Parsed => slug');
    }

    if (json['short_desc'] != null) {
      short_desc =
          LanguageModel.fromMap(parseMapFromServer(json['short_desc']));

      debugPrint('Parsed => short_desc');
    }

    // if(json['full_desc'] != null){
    //   full_desc = LanguageModel.fromMap(parseMapFromServer(json['full_desc'].toString().replaceAll(exp, '')));
    //
    //   debugPrint('Parsed => full_desc');
    // }

    brandId = json['brand_id'];
    print('Parsed => brandId');

    price = json['price'] ?? 'empty';
    print('Parsed => price');

    oldPrice = json['old_price'];
    print('Parsed => oldPrice');

    special = json['special'];
    print('Parsed => special');

    status = json['status'];
    print('Parsed => status');

    freeShipping = json['free_shipping'];
    print('Parsed => freeShipping');

    countryOrigin = json['country_origin'] ?? 'empty';
    print('Parsed => countryOrigin');

    quantityInStock = json['quantity_in_stock'] ?? 0;
    print('Parsed => quantityInStock');

    image = json['image'] != null ? '$productsUrl${json['image']}' : 'empty';
    print('Parsed => image');

    if (json['gallery'] != null) {
      gallery = List.from(parseMapFromServer(json['gallery']))
          .map((e) => '$productsUrl${e.toString()}')
          .toList();

      print('Parsed => gallery');
    }

    length = json['length'];
    print('Parsed => length');

    width = json['width'];
    print('Parsed => width');

    height = json['height'];
    print('Parsed => height');

    weight = json['weight'];
    print('Parsed => weight');

    if (json['brand'] != null) {
      brand = BrandModel.fromJson(json['brand']);
      print('Parsed => brand');
    }

    if (json['reviews'] != null && (json['reviews'] as List).isNotEmpty) {
      reviews = List.from(json['reviews'])
          .map((e) => ReviewsModel.fromJson(e))
          .toList();

      print('Parsed => reviews');
    }

    if (json['size_attributes'] != null &&
        (json['size_attributes'] as List).isNotEmpty) {
      size_attributes = List.from(json['size_attributes'])
          .map((e) => SizeModel.fromJson(e))
          .toList();

      print('Parsed => size_attributes');
    }

    if (json['color_attributes'] != null &&
        (json['color_attributes'] as List).isNotEmpty) {
      color_attributes = List.from(json['color_attributes'])
          .map((e) => ColorModel.fromJson(e))
          .toList();

      print('Parsed => color_attributes');
    }

    if (json['categories'] != null) {
      categories = List.from(json['categories'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      print('Parsed => categories');
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['vendor_id'] = vendorId;
    _data['name'] = name.toJson();
    //_data['full_desc'] = full_desc.toJson();
    _data['slug'] = slug.toJson();
    _data['short_desc'] = short_desc.toJson();
    _data['brand_id'] = brandId;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['special'] = special;
    _data['status'] = status;
    _data['free_shipping'] = freeShipping;
    _data['country_origin'] = countryOrigin;
    _data['quantity_in_stock'] = quantityInStock;
    _data['image'] = image;
    _data['length'] = length;
    _data['width'] = width;
    _data['height'] = height;
    _data['weight'] = weight;
    _data['reviews'] = reviews;
    _data['brand'] = brand;
    _data['size_attributes'] = size_attributes!.map((e) => e.toJson()).toList();
    _data['color_attributes'] =
        color_attributes!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ReviewsModel {
  ReviewsModel({
    required this.id,
  });

  late final int id;
  late final num rating;
  late final String body;
  late final String created_at;
  late final String updated_at;

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'] ?? 0;
    body = json['body'] ?? 'empty';
    created_at = json['created_at'] ?? 'empty';
    updated_at = json['updated_at'] ?? 'empty';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['rating'] = rating;
    _data['body'] = body;
    _data['created_at'] = created_at;
    _data['updated_at'] = updated_at;
    return _data;
  }
}

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.special,
    required this.status,
  });

  late final int id;
  late final LanguageModel name;
  late final LanguageModel description;
  late final int special;
  late final int status;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    description =
        LanguageModel.fromMap(parseMapFromServer(json['description']));
    special = json['special'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['special'] = special;
    _data['status'] = status;
    return _data;
  }
}

class BrandModel {
  BrandModel({
    required this.id,
    required this.name,
    required this.special,
    required this.status,
    required this.image,
  });

  late final int id;
  late final LanguageModel name;
  late final int special;
  late final int status;
  late final String? image;

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    special = json['special'];
    status = json['status'];
    image = json['image'] ?? 'empty';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['special'] = special;
    _data['status'] = status;
    _data['image'] = image;

    return _data;
  }
}

class SizeModel {
  SizeModel({
    required this.id,
    required this.attribute_id,
    required this.attribute_type_id,
    required this.image,
    required this.price,
    required this.attribute,
  });

  late final int id;
  late final int attribute_id;
  late final int attribute_type_id;
  late final String image;
  late final num price;
  late final AttributeSize attribute;

  SizeModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['attribute_id'] != null) {
      attribute_id = json['attribute_id'];
    }
    if (json['attribute_type_id'] != null) {
      attribute_type_id = json['attribute_type_id'];
    }
    if (json['image'] != null) {
      image = json['image'];
    }

    if (json['price'] != null) {
      price = json['price'];
    }

    if (json['attribute'] != null) {
      attribute = AttributeSize.fromJson(json['attribute']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attribute'] = attribute;
    return _data;
  }
}

class AttributeSize {
  AttributeSize({
    required this.id,
    required this.attribute_type_id,
    required this.name,
  });

  late final int id;
  late final int attribute_type_id;
  late final LanguageModel name;

  AttributeSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attribute_type_id = json['attribute_type_id'];
    if (json['name'] != null) {
      name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attribute_type_id'] = attribute_type_id;
    _data['name'] = name;

    return _data;
  }
}

class ColorModel {
  ColorModel({
    required this.id,
    required this.attribute_id,
    required this.attribute_type_id,
    required this.image,
    required this.price,
    required this.attribute,
  });

  late final int id;
  late final int attribute_id;
  late final int attribute_type_id;
  String? image;
  late final num price;
  late final AttributeColor attribute;

  ColorModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['attribute_id'] != null) {
      attribute_id = json['attribute_id'];
    }
    if (json['attribute_type_id'] != null) {
      attribute_type_id = json['attribute_type_id'];
    }
    if (json['image'] != null) {
      image = '$attributesUrl${json['image'] ?? ''}';
    }

    if (json['price'] != null) {
      price = json['price'];
    }

    if (json['attribute'] != null) {
      attribute = AttributeColor.fromJson(json['attribute']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attribute'] = attribute;
    return _data;
  }
}

class AttributeColor {
  AttributeColor({
    required this.id,
    required this.attribute_type_id,
    required this.name,
    required this.value,
  });

  late final int id;
  late final int attribute_type_id;
  late final LanguageModel name;
  late final String value;

  AttributeColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attribute_type_id = json['attribute_type_id'];
    if (json['name'] != null) {
      name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    }
    value = json['value'] ?? 'empty';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attribute_type_id'] = attribute_type_id;
    _data['name'] = name;
    _data['value'] = value;

    return _data;
  }
}

class ProductRelatedModel {
  ProductRelatedModel({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.slug,
    required this.short_desc,
    required this.brandId,
    required this.price,
    required this.oldPrice,
    required this.special,
    required this.status,
    required this.freeShipping,
    required this.countryOrigin,
    required this.quantityInStock,
    required this.image,
  });

  late final int id;
  late final int vendorId;
  late final LanguageModel name;
  late final LanguageModel slug;
  late final LanguageModel short_desc;
  late final int brandId;
  late final String price;
  String? oldPrice;
  late final int special;
  late final int status;
  late final int freeShipping;
  late final String countryOrigin;
  late final int quantityInStock;
  late final String image;

  ProductRelatedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    slug = LanguageModel.fromMap(parseMapFromServer(json['slug']));
    short_desc = LanguageModel.fromMap(parseMapFromServer(json['short_desc']));
    brandId = json['brand_id'];
    price = json['price'];
    oldPrice = json['old_price'];
    special = json['special'];
    status = json['status'];
    freeShipping = json['free_shipping'];
    countryOrigin = json['country_origin'];
    quantityInStock = json['quantity_in_stock'] ?? 0;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['vendor_id'] = vendorId;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['short_desc'] = short_desc;
    _data['brand_id'] = brandId;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['special'] = special;
    _data['status'] = status;
    _data['free_shipping'] = freeShipping;
    _data['country_origin'] = countryOrigin;
    _data['quantity_in_stock'] = quantityInStock;
    _data['image'] = image;

    return _data;
  }
}
