class SimpleModel {
  String? token;
  int? status;
  String? message;

  SimpleModel({
    required this.token,
    required this.status,
    required this.message,
  });

  factory SimpleModel.fromJson(Map<String, dynamic> json) {
    return SimpleModel(
      token: json['token']??'',
      status: json['status']??0,
      message: json['message']??'',
    );
  }
}

