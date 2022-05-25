import 'package:medical_empire_app/core/models/used_market_model.dart';

class UsedMarketCatDetailsModel {
  final UsedMarketDataModel data;
  final int status;

  UsedMarketCatDetailsModel({
    required this.data,
    required this.status,
  });

  factory UsedMarketCatDetailsModel.fromJson(Map<String, dynamic> json) {
    return UsedMarketCatDetailsModel(
      data: UsedMarketDataModel.fromJson(json['data'] ?? 'empty'),
      status: json['status'] as int,
    );
  }
}

class UsedMarketDataModel {
  UsedMarketDataModel({
    required this.category,
    required this.usedMarketProductsDataModel,
    required this.countProducts,
  });

  late final UsedMarketCategory category;
  late final UsedMarketProductsDataModel usedMarketProductsDataModel;
  late final int countProducts;

  UsedMarketDataModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category =  UsedMarketCategory.fromJson(json['category']);
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

