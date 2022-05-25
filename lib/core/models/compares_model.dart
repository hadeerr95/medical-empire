import 'package:medical_empire_app/core/models/product_details_model.dart';

import 'home_feed_model.dart';

class ComparesModel{

  ComparesModel({
    required this.status,
    required this.compares,
  });

  late final int status;
  late final List<ComparesDetailsModel> compares;


  ComparesModel.fromJson(Map<String, dynamic> json) {

    status = json['status'];

    if(json['compares'] != null) {
      print((json['compares'] as List).length);
      int count = 0;

      compares = List.from((json['compares'] as List))
          .map((e) {
            count ++;
            print('Count => $count');
            return ComparesDetailsModel.fromJson(e);
          }).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['compares'] = compares.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ComparesDetailsModel{

  ComparesDetailsModel({
    required this.id,
    required this.user_id,
    required this.product_id,
    required this.product,

  });

  late final int id;
  late final int user_id;
  late final int product_id;
  late final ProductModel product;


  ComparesDetailsModel.fromJson(Map<String, dynamic> json) {

    id = json['id']??0;
    user_id = json['user_id']??0;
    product_id = json['product_id']??0;

    if(json['product'] != null){
      product = ProductModel.fromJson(json['product']);
    }

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = user_id;
    _data['product_id'] = product_id;
    _data['product'] = product;
    return _data;
  }

}