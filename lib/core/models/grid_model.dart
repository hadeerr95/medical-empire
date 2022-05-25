import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';

class CategoriesDetails {
  final Data data;
  final int status;

  CategoriesDetails({
    required this.data,
    required this.status,
  });

  factory CategoriesDetails.fromJson(Map<String, dynamic> json) {
    return CategoriesDetails(
      data: Data.fromJson(json['data'] ?? 'empty'),
      status: json['status'] as int,
    );
  }
}


class Data{
  Data({
    required this.products,
  });

  late final ProductsDataModel products;

  Data.fromJson(Map<String, dynamic> json) {
    products = ProductsDataModel.fromJson(json['products']);
  }
}

class ProductsDataModel {
  ProductsDataModel({
    required this.productsList,
    required this.currentPage,
    required this.lastPage,
  });

  late final List<ProductModel> productsList;
  late final int currentPage;
  late final int lastPage;

  ProductsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      productsList =
          List.from(json['data']).map((e) => ProductModel.fromJson(e)).toList();
    }
    currentPage = json['current_page']??0;
    lastPage = json['last_page']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = productsList.map((e) => e.toJson()).toList();
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }

}
