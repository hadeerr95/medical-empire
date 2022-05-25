import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class OrdersModel{
  final OrdersDataModel orders;
  final int status;

  const OrdersModel({
    required this.orders,
    required this.status,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      orders: OrdersDataModel.fromJson(json['orders'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders,
      'status': status,
    };
  }
}

class OrdersDataModel {
  OrdersDataModel({
    required this.orders,
  });

  late final List<Order> orders;

  OrdersDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orders = List.from(json['data']).map((e) => Order.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = orders.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Order {
  Order({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.itemsCount,
    required this.paymentMethod,
    required this.status,
    required this.name,
    required this.email,
    required this.phone,
    required this.governate,
    required this.city,
    required this.streetName,
    required this.buildingNumber,
    required this.specialMarker,
    required this.createdAt,
    required this.shipping_price,
    required this.extra_shipping,
    required this.overweight_price,
  });

  late final int id;
  late final String orderNumber;
  // late final int user_id;
  late final String totalAmount;
  late final int itemsCount;
  late final String shipping_price;
  late final String extra_shipping;
  late final String overweight_price;
  late final String paymentMethod;
  late final int status;
  late final String name;
  late final String email;
  late final String phone;
  late final String governate;
  late final String city;
  late final String streetName;
  late final String buildingNumber;
  late final String specialMarker;

  // late final String name;
  // late final String email;
  // late final String phone;
  // late final String governate;
  // late final String city;
  // late final String street_name;
  // late final String building_number;
  // late final String special_marker;
  late final String createdAt;
  // late final String updated_at;


  Order.fromJson(Map<String, dynamic> json) {
    id = json['id']?? 0;
    orderNumber = json['order_number']??'';
    totalAmount = json['total_amount']??'';
    shipping_price = json['shipping_price']??'';
    extra_shipping = json['extra_shipping']??'';
    overweight_price = json['overweight_price']??'';
    itemsCount = json['items_count']??0;
    paymentMethod = json['payment_method']??'';
    status = json['status']??'';
    name = json['name']??0;
    email = json['email']??'';
    phone = json['phone']??'';
    governate = json['governate']??'';
    city = json['city']??'';
    streetName = json['street_name']??'';
    buildingNumber = json['building_number']??'';
    specialMarker = json['special_marker']??'';
    createdAt = json['created_at']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_number'] = orderNumber;
    _data['payment_method'] = paymentMethod;
    _data['status'] = status;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['governate'] = governate;
    _data['city'] = city;
    _data['street_name'] = streetName;
    _data['building_number'] = buildingNumber;
    _data['special_marker'] = specialMarker;
    _data['created_at'] = createdAt;
    return _data;
  }
}