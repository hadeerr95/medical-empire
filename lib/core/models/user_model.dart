import 'package:medical_empire_app/core/network/end_points.dart';

import 'address_model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.addresses,
  });

  late final int id;
  late  String name;
  late  String email;
  late  String phone;
  late final String image;
  List<Addresses>? addresses;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'] != null
        ? '$profileImageUrl${json['image']}'
        : 'https://cdn-icons-png.flaticon.com/512/149/149071.png';

    if (json['addresses'] != null) {
      addresses = List.from(json['addresses'])
          .map((e) => Addresses.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['addresses'] = addresses;
    return _data;
  }
}
