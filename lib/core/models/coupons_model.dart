class CouponsModel {
  CouponsDataModel? data;
  final int status;
  final String message;

  CouponsModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CouponsModel.fromJson(Map<String, dynamic> json) {
    return CouponsModel(
      data:
          json['data'] != null ? CouponsDataModel.fromJson(json['data']) : null,
      status: (json['status'] as num).toInt(),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data!.toJson(),
      'status': status,
      'message': message,
    };
  }
}

class CouponsDataModel {
  CouponsDataModel({
    required this.coupon,
  });

  late final CouponDataModel coupon;

  CouponsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['coupon'] != null) {
      coupon = CouponDataModel.fromJson(json['coupon']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'coupon': coupon.toJson(),
    };
  }
}

class CouponDataModel {
  CouponDataModel({
    required this.name,
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.allowFreeShipping,
    required this.desc,
    required this.maximumAmount,
    required this.minimumAmount,
    required this.amount,
  });

  late final int id;
  late final String name;
  late final String type;
  late final String desc;
  late final String allowFreeShipping;
  late final String startDate;
  late final String endDate;
  late final num minimumAmount;
  late final num maximumAmount;
  late final num amount;

  CouponDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    type = json['type'] ?? '';
    desc = json['desc'] ?? '';
    allowFreeShipping = json['allow_free_shipping'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    minimumAmount = json['minimum_amount'] ?? 0;
    maximumAmount = json['maximum_amount'] ?? 0;
    amount = json['amount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'desc': desc,
      'allow_free_shipping': allowFreeShipping,
      'start_date': startDate,
      'end_date': endDate,
      'minimum_amount': minimumAmount,
      'maximum_amount': maximumAmount,
      'amount': amount,
    };
  }
}
