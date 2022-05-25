import 'package:medical_empire_app/core/models/grid_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';

import 'orders_model.dart';

class OrderDetailsModel {
  final OrderDetailsDataModel data;
  final int status;

  const OrderDetailsModel({
    required this.data,
    required this.status,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      data: OrderDetailsDataModel.fromJson(json['data'] ?? 'empty'),
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

class OrderDetailsDataModel {
  OrderDetailsDataModel({
    required this.orderItems,
    required this.order,
  });

  late final List<OrderItem> orderItems;
  late final Order order;

  OrderDetailsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      orderItems =
          List.from(json['items']).map((e) => OrderItem.fromJson(e)).toList();
    }
    if (json['order'] != null) {
      order = Order.fromJson(json['order']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = orderItems.map((e) => e.toJson()).toList();
    _data['order'] = order;
    return _data;
  }
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.orderId,
    required this.vendorId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.product,
  });

  late final int id;
  late final int orderId;
  late final int vendorId;
  late final int productId;
  late final int quantity;
  late final String price;
  late final int status;
  late final String createdAt;
  late final ProductModel product;

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    orderId = json['order_id'] ?? 0;
    vendorId = json['vendor_id'] ?? 0;
    productId = json['product_id'] ?? 0;
    quantity = json['quantity'] ?? 0;
    price = json['price'] ?? '';
    status = json['status'] ?? 0;
    createdAt = json['created_at'] ?? '';
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_id'] = orderId;
    _data['vendor_id'] = vendorId;
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['product'] = product;
    return _data;
  }
}
