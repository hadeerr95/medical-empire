import 'brands_model.dart';
import 'grid_model.dart';

class BrandsDetailsModel {
  final BrandsDetailsDataModel brandsDetailsDataModel;
  final int status;

  const BrandsDetailsModel({
    required this.brandsDetailsDataModel,
    required this.status,
  });

  factory BrandsDetailsModel.fromJson(Map<String, dynamic> json) {
    return BrandsDetailsModel(
      brandsDetailsDataModel: BrandsDetailsDataModel.fromJson(json['data'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': brandsDetailsDataModel,
      'status': status,
    };
  }
}

class BrandsDetailsDataModel {
  BrandsDetailsDataModel({
    required this.brand,
    required this.productsDataModel,
  });

  late final Brand brand;
  late final ProductsDataModel productsDataModel;

  BrandsDetailsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      brand = Brand.fromJson(json['brand']);
    }
    if (json['products'] != null) {
      productsDataModel = ProductsDataModel.fromJson(json['products']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brand'] = brand.toJson();
    _data['products'] = productsDataModel.toJson();
    return _data;
  }
}


// import 'package:medical_empire_app/core/models/grid_model.dart';
// import 'package:medical_empire_app/core/models/home_feed_model.dart';
//
// import 'brands_model.dart';
//
// class BrandsDetailsModel {
//   final BrandsDetailsDataModel data;
//   final int status;
//
//   const BrandsDetailsModel({
//     required this.data,
//     required this.status,
//   });
//
//   factory BrandsDetailsModel.fromJson(Map<String, dynamic> json) {
//     return BrandsDetailsModel(
//       data: BrandsDetailsDataModel.fromJson(json['data'] ?? 'empty'),
//       status: (json['status'] as num).toInt(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'data': data,
//       'status': status,
//     };
//   }
// }
//
// class BrandsDetailsDataModel {
//   BrandsDetailsDataModel({
//     required this.brand,
//     required this.productsDataModel,
//   });
//
//   late final Brand brand;
//   late final ProductsDataModel productsDataModel;
//
//   BrandsDetailsDataModel.fromJson(Map<String, dynamic> json) {
//     if (json['brand'] != null) {
//       brand = Brand.fromJson(json['brand']);
//     }
//     if (json['products'] != null) {
//       productsDataModel = ProductsDataModel.fromJson(json['products']);
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['brand'] = brand.toJson();
//     _data['brand'] = ProductsDataModel.toJson();
//     return _data;
//   }
// }

























