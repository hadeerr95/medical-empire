import 'package:medical_empire_app/core/models/orders_model.dart';

class ReadNotificationModel {
  final ReadNotificationModelData data;

  const ReadNotificationModel({
    required this.data,
  });

  factory ReadNotificationModel.fromJson(Map<String, dynamic> json) {
    return ReadNotificationModel(
      data: ReadNotificationModelData.fromJson(json['data'] ?? 'empty'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}

class ReadNotificationModelData {
  final Order order;
  final int subTotal;
  final int status;

  const ReadNotificationModelData({
    required this.order,
    required this.subTotal,
    required this.status,
  });

  factory ReadNotificationModelData.fromJson(Map<String, dynamic> json) {
    return ReadNotificationModelData(
      order: Order.fromJson(json['order'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
      subTotal: (json['sub_total'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'status': status,
      'sub_total': subTotal,
    };
  }
}
