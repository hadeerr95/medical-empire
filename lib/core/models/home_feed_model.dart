import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class HomeFeedModel {
  final HomeDataModel data;
  final int status;

  const HomeFeedModel({
    required this.data,
    required this.status,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedModel(
      data: HomeDataModel.fromJson(json['data'] ?? 'empty'),
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

class HomeDataModel {
  HomeDataModel({
    required this.offersBanners,
    required this.sliders,
    required this.categories,
  });

  late final List<OffersBanners> offersBanners;
  late final List<Sliders> sliders;
  late final List<Categories> categories;
  late final List<ProductModel> bestOffers;
  late final String ads_1;
  late final String ads_2;
  late final String ads_3;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['ads_1'] != null) {
      ads_1 = '$adsUrl${json['ads_1']}';
    }
    if (json['ads_2'] != null) {
      ads_2 = '$adsUrl${json['ads_2']}';
    }
    if (json['ads_3'] != null) {
      ads_3 = '$adsUrl${json['ads_3']}';
    }
    if (json['offers_banners'] != null) {
      offersBanners = List.from(json['offers_banners'])
          .map((e) => OffersBanners.fromJson(e))
          .toList();
    }
    if (json['best_offers'] != null) {
      bestOffers = List.from(json['best_offers'])
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
    if (json['sliders'] != null) {
      sliders =
          List.from(json['sliders']).map((e) => Sliders.fromJson(e)).toList();
    }
    if (json['categories'] != null) {
      categories = List.from(json['categories'])
          .map((e) => Categories.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offers_banners'] = offersBanners.map((e) => e.toJson()).toList();
    _data['sliders'] = sliders.map((e) => e.toJson()).toList();
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class OffersBanners {
  OffersBanners({
    required this.id,
    required this.categoryId,
    required this.imageEn,
    required this.imageAr,
    required this.status,
  });

  late final int id;
  late final int categoryId;
  late final String imageEn;
  late final String imageAr;
  late final int status;

  OffersBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    imageEn = '$bannersUrl${json['image_en']}';
    imageAr = '$bannersUrl${json['image_ar']}';
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['image_en'] = imageEn;
    _data['image_ar'] = imageAr;
    _data['status'] = status;
    return _data;
  }
}

class Sliders {
  Sliders({
    required this.id,
    required this.link,
    required this.status,
    required this.imageEn,
    required this.imageAr,
  });

  late final int id;
  late final String link;
  late final String imageEn;
  late final String imageAr;
  late final int status;

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    imageEn = json['image_en'];
    imageAr = json['image_ar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['link'] = link;
    _data['status'] = status;
    return _data;
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
    required this.imageAr,
    required this.imageEn,
    required this.cover,
    required this.bannerImageAr,
    required this.bannerImageEn,
    required this.products,
  });

  late final int id;
  late final int parentId;
  late final LanguageModel name;
  late final LanguageModel description;
  late final LanguageModel metaKeywords;
  late final LanguageModel metaDescription;
  late final int special;
  late final int status;
  late final String imageAr;
  late final String imageEn;
  late final String cover;
  late final String bannerImageAr;
  late final String bannerImageEn;
  late final List<ProductModel> products;

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
    imageAr = json['image_ar'];
    imageEn = json['image_en'];
    cover = json['cover'];
    bannerImageAr = '$categoriesUrl${json['banner_image_ar']}';
    bannerImageEn = '$categoriesUrl${json['banner_image_en']}';
    if (json['products'] != null) {
      print('-------------------------------------------------------');
      print((json['products'] as List).length);
      products = List.from((json['products'] as List))
          .map((e) => ProductModel.fromJson(e))
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
    _data['image_ar'] = imageAr;
    _data['image_en'] = imageEn;
    _data['cover'] = cover;
    _data['banner_image_ar'] = bannerImageAr;
    _data['banner_image_en'] = bannerImageEn;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }
}

// class Products {
//   Products({
//     required this.id,
//     required this.vendorId,
//     required this.name,
//     required this.slug,
//     required this.brandId,
//     required this.price,
//     required this.oldPrice,
//     required this.special,
//     required this.status,
//     required this.freeShipping,
//     required this.countryOrigin,
//     required this.quantityInStock,
//     required this.image,
//   });
//
//   late final int id;
//   late final int vendorId;
//   late final LanguageModel name;
//   late final LanguageModel slug;
//
//   late final int brandId;
//   late final String price;
//   String? oldPrice;
//
//   late final int special;
//   late final int status;
//
//   late final int freeShipping;
//
//   late final String countryOrigin;
//
//   late final int quantityInStock;
//
//   late final String image;
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     name = LanguageModel.fromMap(parseMapFromServer(json['name']));
//     slug = LanguageModel.fromMap(parseMapFromServer(json['slug']));
//     brandId = json['brand_id'];
//     price = json['price']??'0';
//     oldPrice = json['old_price']??'0';
//     special = json['special'];
//     status = json['status'];
//     freeShipping = json['free_shipping'];
//     countryOrigin = json['country_origin']??'';
//     quantityInStock = json['quantity_in_stock']??0;
//     image = json['image'] != null ? '$productsUrl${json['image']}' : 'empty';
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['vendor_id'] = vendorId;
//     _data['name'] = name;
//     _data['slug'] = slug;
//     _data['brand_id'] = brandId;
//     _data['price'] = price;
//     _data['old_price'] = oldPrice;
//     _data['special'] = special;
//     _data['status'] = status;
//     _data['free_shipping'] = freeShipping;
//     _data['country_origin'] = countryOrigin;
//     _data['quantity_in_stock'] = quantityInStock;
//     _data['image'] = image;
//     return _data;
//   }
// }
