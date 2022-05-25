import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

import 'home_feed_model.dart';

class CategoriesModel {
  final CategoriesDataModel data;
  final int status;

  CategoriesModel({
    required this.data,
    required this.status,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      data: CategoriesDataModel.fromJson(json['data'] ?? 'empty'),
      status: json['status'] as int,
    );
  }
}

class CategoriesDataModel {
  CategoriesDataModel({
    required this.categoriesList,
  });

  late final List<Categories> categoriesList;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categoriesList = List.from(json['categories'])
          .map((e) => Categories.fromJson(e[0]))
          .toList();
    }
  }
}

class Categories {
  Categories({
    required this.id,
    required this.parentId,
    required this.name,
    required this.description,
    required this.metaKeywords,
    required this.metaDescription,
    required this.special,
    required this.status,
    required this.cover,
    required this.products,
    required this.childrenDataModel,
    required this.mobile_image,
  });

  late final int id;
  late final int parentId;
  late final LanguageModel name;
  late final LanguageModel description;
  late final LanguageModel metaKeywords;
  late final LanguageModel metaDescription;
  late final int special;
  late final int status;
  late final String cover;
  late final String mobile_image;
  late final List<ProductModel> products;

  late final List<ChildrenDataModel> childrenDataModel;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    description =
        LanguageModel.fromMap(parseMapFromServer(json['description']));
    metaKeywords =
        LanguageModel.fromMap(parseMapFromServer(json['meta_keywords']));
    metaDescription =
        LanguageModel.fromMap(parseMapFromServer(json['meta_description']));
    special = json['special'];
    status = json['status'];
    mobile_image = json['mobile_image']??'';
    cover = json['cover']??'';
    if (json['products'] != null) {
      print('-------------------------------------------------------');
      print((json['products'] as List).length);
      products = List.from((json['products'] as List))
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
    if(json['childrens'] != null) {
      print('-------------------------------------------------------');
      print((json['childrens'] as List).length);
      childrenDataModel = List.from((json['childrens'] as List))
          .map((e) => ChildrenDataModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['name'] = name;
    _data['description'] = description;
    _data['meta_keywords'] = metaKeywords;
    _data['meta_description'] = metaDescription;
    _data['special'] = special;
    _data['status'] = status;
    _data['cover'] = cover;
    _data['mobile_image'] = mobile_image;
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['childrens'] = childrenDataModel.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ChildrenDataModel {
  ChildrenDataModel({
    required this.children,
    required this.name,
    required this.id,
    required this.image_en,
    required this.image_ar,
  });

  late final List<Children> children;
  late final LanguageModel name;
  late final int id;
  late final String image_en;
  late final String image_ar;

  ChildrenDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    if (json['childrens'] != null) {
      children = List.from(json['childrens'])
          .map((e) => Children.fromJson(e))
          .toList();
    }
    image_en = json['image_en']??'empty';
    image_ar = json['image_ar']??'empty';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['childrens'] = children.map((e) => e.toJson()).toList();
    _data['name'] = name;
    _data['id'] = id;
    _data['image_en'] = image_en;
    _data['image_ar'] = image_ar;
    return _data;
  }

}

class Children {
  Children({
    required this.id,
    required this.parentId,
    required this.name,
    required this.categoryId,
    required this.special,
    required this.status,
    required this.image,
  });

  late final int id;
  late final int parentId;
  late final LanguageModel name;
  late final int categoryId;
  late final int special;
  late final int status;
  late final String image;

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    categoryId = json['category_id'];
    special = json['special'];
    status = json['status'];
    image = json['mobile_image']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['name'] = name;
    _data['category_id'] = categoryId;
    _data['special'] = special;
    _data['status'] = status;
    _data['mobile_image'] = image;
    return _data;
  }
}
