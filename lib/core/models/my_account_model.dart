import 'package:medical_empire_app/core/models/user_model.dart';

class MyAccountModel{
  final UserModel data;
  final int status;

  const MyAccountModel({
    required this.data,
    required this.status,
  });

  factory MyAccountModel.fromJson(Map<String, dynamic> json) {
    return MyAccountModel(
      data: UserModel.fromJson(json['data'] ?? 'empty'),
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