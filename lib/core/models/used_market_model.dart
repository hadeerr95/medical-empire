import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class UsedMarketModel {
  final UsedMarketDataModel data;
  final int status;

  UsedMarketModel({
    required this.data,
    required this.status,
  });

  factory UsedMarketModel.fromJson(Map<String, dynamic> json) {
    return UsedMarketModel(
      data: UsedMarketDataModel.fromJson(json['data'] ?? 'empty'),
      status: json['status'] as int,
    );
  }
}

class UsedMarketDataModel {
  UsedMarketDataModel({
    required this.categoriesList,
    required this.usedMarketProductsDataModel,
    required this.countProducts,
  });

  late final List<UsedMarketCategory> categoriesList;
  late final UsedMarketProductsDataModel usedMarketProductsDataModel;
  late final int countProducts;

  UsedMarketDataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categoriesList = List.from(json['categories'])
          .map((e) => UsedMarketCategory.fromJson(e))
          .toList();
    }
    if (json['products'] != null) {
      usedMarketProductsDataModel =
          UsedMarketProductsDataModel.fromJson(json['products']);
    }
    if (json['count_products'] != null) {
      countProducts = json['count_products'];
    }
  }
}

class UsedMarketCategory {
  UsedMarketCategory({
    required this.id,
    required this.parentId,
    required this.name,
    // required this.description,
    // required this.metaKeywords,
    // required this.metaDescription,
    required this.special,
    required this.status,
    required this.cover,
  });

  late final int id;
  late final int parentId;
  late final LanguageModel name;
  // late final LanguageModel description;
  // late final LanguageModel metaKeywords;
  // late final LanguageModel metaDescription;
  late final int special;
  late final int status;
  late final String cover;

  UsedMarketCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    // description = LanguageModel.fromMap(parseMapFromServer(json['desc']));
    // metaKeywords =
    //     LanguageModel.fromMap(parseMapFromServer(json['meta_keywords']));
    // metaDescription =
    //     LanguageModel.fromMap(parseMapFromServer(json['meta_description']));
    special = json['special'];
    status = json['status'];
    cover = '$usedCategoriesUrl${json['cover']}';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parent_id'] = parentId;
    _data['name'] = name;
    // _data['desc'] = description;
    // _data['meta_keywords'] = metaKeywords;
    // _data['meta_description'] = metaDescription;
    _data['special'] = special;
    _data['status'] = status;
    _data['cover'] = cover;
    return _data;
  }
}

class UsedMarketProductsDataModel {
  UsedMarketProductsDataModel({
    required this.usedMarketProduct,
    required this.lastPage,
    required this.currentPage,
  });

  late final List<UsedMarketProduct> usedMarketProduct;
  late final int currentPage;
  late final int lastPage;

  UsedMarketProductsDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      usedMarketProduct = List.from(json['data'])
          .map((e) => UsedMarketProduct.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = usedMarketProduct.map((e) => e.toJson()).toList();
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }
}

class UsedMarketProduct {
  UsedMarketProduct({
    required this.id,
    required this.userId,
    required this.phone,
    required this.categoryId,
    required this.name,
    // required this.shortDesc,
    required this.price,
    required this.image,
    required this.special,
    required this.status,
    required this.countryOrigin,
  });

  late final int id;
  late final int userId;
  late final String phone;
  late final int categoryId;
  late final LanguageModel name;
  // late final LanguageModel shortDesc;
  late final int price;
  late final String image;
  late final int special;
  late final int status;
  late final String countryOrigin;

  UsedMarketProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    phone = json['phone'];
    categoryId = json['category_id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    // shortDesc = LanguageModel.fromMap(parseMapFromServer(json['short_desc']));
    price = json['price'] ?? '0';
    image = json['image'] != null ? '$usedProductUrl${json['image']}' : 'empty';
    special = json['special'];
    status = json['status'];
    countryOrigin = json['country_origin'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['phone'] = phone;
    _data['category_id'] = categoryId;
    _data['name'] = name;
    // _data['short_desc'] = shortDesc;
    _data['price'] = price;
    _data['image'] = image;
    _data['special'] = special;
    _data['status'] = status;
    _data['country_origin'] = countryOrigin;
    return _data;
  }
}
