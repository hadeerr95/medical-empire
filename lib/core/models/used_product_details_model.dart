import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class UsedProductFeedModel{
  final UsedProductModel product;
  final int status;

  const UsedProductFeedModel({
    required this.product,
    required this.status,
  });

  factory UsedProductFeedModel.fromJson(Map<String, dynamic> json) {
    return UsedProductFeedModel(
      product: UsedProductModel.fromJson(json['product'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'status': status,
    };
  }
}

class UsedProductModel {

  UsedProductModel({

    required this.id,
    required this.user_id,
    required this.phone,
    required this.category_id,
    required this.name,
    required this.sku,
    required this.short_desc,

    required this.meta_keywords,
    required this.meta_description,
    required this.price,
    required this.country_origin,
    required this.image,
    required this.gallery,
    required this.catalog_file,
    required this.video_link,
    required this.count_views,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,

  });

  late final int id;
  late final int user_id;
  late final String phone;
  late final int category_id;
  late final LanguageModel name;
  late final String sku;
  late final LanguageModel short_desc;
  late final LanguageModel meta_keywords;
  late final LanguageModel meta_description;
  late final int price;
  late final String country_origin;
  late final String image;
  List<String>? gallery;
  late final String catalog_file;
  late final String video_link;
  late final int count_views;

  late final dynamic length;
  late final dynamic width;
  late final dynamic height;
  late final dynamic weight;


  UsedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print('Parsed => id');

    user_id = json['user_id'];
    print('Parsed => user_id');

    phone = json['phone']??'empty';
    print('Parsed => phone');

    category_id = json['category_id'];
    print('Parsed => category_id');


    if(json['name'] != null){
      name = LanguageModel.fromMap(parseMapFromServer(json['name']));

      print('Parsed => name');
    }

    sku = json['sku']??'empty';
    print('Parsed => sku');

    if(json['short_desc'] != null){
      short_desc = LanguageModel.fromMap(parseMapFromServer(json['short_desc']));

      print('Parsed => short_desc');
    }

    if(json['meta_keywords'] != null){
      meta_keywords = LanguageModel.fromMap(parseMapFromServer(json['meta_keywords']));

      print('Parsed => meta_keywords');
    }

    if(json['meta_description'] != null){
      meta_description = LanguageModel.fromMap(parseMapFromServer(json['meta_description']));

      print('Parsed => meta_description');
    }

    price = json['price']??0;
    print('Parsed => price');

    country_origin = json['country_origin']??'empty';
    print('Parsed => country_origin');


    image = json['image'] != null ? '$usedProductUrl${json['image']}' : 'empty';
    print('Parsed => image $image');

    if(json['gallery'] != null) {
      gallery = List.from(parseMapFromServer(json['gallery']))
          .map((e) => '$usedProductUrl${e.toString()}')
          .toList();

      print('Parsed => gallery');
    }

    catalog_file = json['catalog_file']??'empty';
    print('Parsed => catalog_file');

    video_link = json['video_link']??'empty';
    print('Parsed => video_link');

    count_views = json['count_views']??0;
    print('Parsed => count_views');

    length = json['length']??'empty';
    print('Parsed => length');

    width = json['width']??'empty';
    print('Parsed => width');

    height = json['height']??'empty';
    print('Parsed => height');

    weight = json['weight']??'empty';
    print('Parsed => weight');



  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = user_id;
    _data['phone'] = phone;
    _data['category_id'] = category_id;
    _data['name'] = name;
    _data['sku'] = sku;
    _data['short_desc'] = short_desc;
    _data['meta_keywords'] = meta_keywords;
    _data['meta_description'] = meta_description;
    _data['price'] = price;
    _data['country_origin'] = country_origin;
    _data['image'] = image;
    _data['gallery'] = gallery;
    _data['catalog_file'] = catalog_file;
    _data['video_link'] = video_link;
    _data['count_views'] = count_views;


    _data['length'] = length;
    _data['width'] = width;
    _data['height'] = height;
    _data['weight'] = weight;
    return _data;
  }
}