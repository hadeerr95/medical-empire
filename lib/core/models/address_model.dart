import 'package:flutter/material.dart';
import 'package:medical_empire_app/core/models/user_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/language_model.dart';

class AddressFeedModel {
  final AddressModel data;
  final int status;

  const AddressFeedModel({
    required this.data,
    required this.status,
  });

  factory AddressFeedModel.fromJson(Map<String, dynamic> json) {
    return AddressFeedModel(
      data: AddressModel.fromJson(json['data'] ?? 'empty'),
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

class AddressModel {
  AddressModel({
    required this.user,
    required this.addresses,
    required this.governorates,
    required this.paymentMethod,
  });

  late final UserModel user;
  List<Addresses>? addresses;
  List<Addresses>? shippingAddresses;
  List<GovernmentModel>? governorates;
  List<PaymentMethodModel>? paymentMethod;

  AddressModel.fromJson(Map<String, dynamic> json) {
    user = UserModel.fromJson(json['user']);

    debugPrint('user parsed ====>');

    if (json['addresses'] != null) {
      addresses = List.from(json['addresses'])
          .map((e) => Addresses.fromJson(e))
          .toList();
    }

    if (json['shipping_addresses'] != null) {
      shippingAddresses = List.from(json['shipping_addresses']).map((e) {
        debugPrint(
            'shipping_addresses parsed ====> ${Addresses.fromJson(e).id}');

        return Addresses.fromJson(e);
      }).toList();
    }

    debugPrint('shipping_addresses parsed ====>');

    if (json['governoraties'] != null) {
      governorates = List.from(json['governoraties'])
          .map((e) => GovernmentModel.fromJson(e))
          .toList();
    }

    if (json['payment_methods'] != null) {
      paymentMethod = List.from(json['payment_methods']).map((e) {
        // int count = 0;
        //
        // count++;
        //
        // debugPrint('payment_methods parsed ====> $count');
        return PaymentMethodModel.fromJson(e);
      }).toList();
    }

    debugPrint('payment_methods parsed ====>');
  }
}

class Addresses {
  Addresses({
    required this.id,
    required this.userId,
    required this.governateId,
    required this.cityId,
    required this.streetName,
    required this.buildingNumber,
    required this.specialMarker,
    required this.shippingAddressGovernmentModel,
    required this.shippingAddressCitiesModel,
  });

  late final int id;
  late final int userId;
  late final int governateId;
  late final int cityId;
  late final String streetName;
  late final String buildingNumber;
  late final String specialMarker;
  late final ShippingAddressGovernmentModel shippingAddressGovernmentModel;
  late final ShippingAddressCitiesModel shippingAddressCitiesModel;

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'] ?? 0;
    governateId = json['governate_id'] ?? 0;
    cityId = json['city_id'] ?? 0;
    streetName = json['street_name'];
    buildingNumber = json['building_number'];
    specialMarker = json['special_marker'];
    print('building_number parsed ---------------------');

    if (json['governorate'] != null) {
      shippingAddressGovernmentModel =
          ShippingAddressGovernmentModel.fromJson(json['governorate']);
    }
    print('governorate parsed ---------------------');

    if (json['city'] != null) {
      shippingAddressCitiesModel =
          ShippingAddressCitiesModel.fromJson(json['city']);
    }
    print('city parsed ---------------------');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['governate_id'] = governateId;
    _data['city_id'] = cityId;
    _data['street_name'] = streetName;
    _data['building_number'] = buildingNumber;
    _data['governorate'] = shippingAddressGovernmentModel;
    _data['city'] = shippingAddressCitiesModel;

    return _data;
  }
}

class PaymentMethodModel {
  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.status,
  });

  late final int id;
  late final LanguageModel name;
  late final int status;

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    return _data;
  }
}

class ShippingAddressGovernmentModel {
  ShippingAddressGovernmentModel({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.country_id,
    required this.governorate_shipping_price,
  });

  late final int id;
  late final String name;
  late final String name_ar;
  late final int country_id;
  late final GovernmentShippingPriceModel governorate_shipping_price;

  ShippingAddressGovernmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    country_id = json['country_id'];
    governorate_shipping_price = GovernmentShippingPriceModel.fromJson(
        json['governorate_shipping_price']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = name_ar;
    _data['country_id'] = country_id;
    _data['governorate_shipping_price'] = governorate_shipping_price.toJson();
    return _data;
  }
}

class ShippingAddressCitiesModel {
  ShippingAddressCitiesModel({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.governorate_id,
    required this.shipping_price,
  });

  late final int id;
  late final String name;
  late final String name_ar;
  late final int governorate_id;
  int? shipping_price;

  ShippingAddressCitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    governorate_id = json['governorate_id'];
    if (json['shipping_price'] != null) {
      shipping_price = json['shipping_price']['price'];
    } else {
      shipping_price = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = name_ar;
    _data['governorate_id'] = governorate_id;
    _data['shipping_price'] = shipping_price;

    return _data;
  }
}

class GovernmentModel {
  GovernmentModel({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.country_id,
    required this.cities,
    required this.governmentShippingPriceModel,
  });

  late final int id;
  late final String name;
  late final String name_ar;
  late final int country_id;
  late final List<CitiesModel> cities;
  late final GovernmentShippingPriceModel governmentShippingPriceModel;

  GovernmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    country_id = json['country_id'];

    if (json['cities'] != null) {
      cities = List.from(json['cities'])
          .map((e) => CitiesModel.fromJson(e))
          .toList();
    }
    if (json['governorate_shipping_price'] != null) {
      governmentShippingPriceModel = GovernmentShippingPriceModel.fromJson(
          json['governorate_shipping_price']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = name_ar;
    _data['country_id'] = country_id;
    _data['governorate_shipping_price'] = governmentShippingPriceModel;
    return _data;
  }
}

class CitiesModel {
  CitiesModel({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.governorate_id,
    required this.shipping_price,
  });

  late final int id;
  late final String name;
  late final String name_ar;
  late final int governorate_id;
  late final int shipping_price;

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    governorate_id = json['governorate_id'];
    shipping_price = json['shipping_price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = name_ar;
    _data['governorate_id'] = governorate_id;
    _data['shipping_price'] = shipping_price;
    return _data;
  }
}

class GovernmentShippingPriceModel {
  GovernmentShippingPriceModel({
    required this.id,
    required this.governorate_from,
    required this.governorate_to,
    required this.city_from,
    required this.city_to,
    required this.price,
  });

  late final int id;
  late final int governorate_from;
  late final int governorate_to;
  late final int city_from;
  late final int city_to;
  late final int price;

  GovernmentShippingPriceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorate_from = json['governorate_from'] ?? 0;
    governorate_to = json['governorate_to'] ?? 0;
    city_from = json['city_from'] ?? 0;
    city_to = json['city_to'] ?? 0;
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['governorate_from'] = governorate_from;
    _data['governorate_to'] = governorate_to;
    _data['city_from'] = city_from;
    _data['city_to'] = city_to;
    _data['price'] = price;
    return _data;
  }
}
