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

    /* if (json['governorates'] != null) {
      governorates = List.from(json['governorates'])
          .map((e) => GovernmentModel.fromJson(e))
          .toList();
      debugPrint('governorate parsed ---------------------');
    } else */
    if (json['governoraties'] != null) {
      governorates = List.from(json['governoraties'])
          .map((e) => GovernmentModel.fromJson(e))
          .toList();
      debugPrint('governorate parsed ---------------------');
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
    required this.nameAr,
    required this.countryId,
    required this.governorateShippingPrice,
  });

  late final int id;
  late final String name;
  late final String nameAr;
  late final int countryId;
  late final GovernmentShippingPriceModel governorateShippingPrice;

  ShippingAddressGovernmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    countryId = json['country_id'];
    governorateShippingPrice = GovernmentShippingPriceModel.fromJson(
        json['governorate_shipping_price']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = nameAr;
    _data['country_id'] = countryId;
    _data['governorate_shipping_price'] = governorateShippingPrice.toJson();
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
    required this.nameAr,
    required this.countryId,
    required this.cities,
    required this.governmentShippingPriceModel,
  });

  late final int id;
  late final String name;
  late final String nameAr;
  late final int countryId;
  late final List<CitiesModel> cities;
  late final GovernmentShippingPriceModel governmentShippingPriceModel;

  GovernmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    countryId = json['country_id'];

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
    _data['name_ar'] = nameAr;
    _data['country_id'] = countryId;
    _data['governorate_shipping_price'] = governmentShippingPriceModel;
    return _data;
  }
}

class CitiesModel {
  CitiesModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.governorateId,
    required this.shippingPrice,
  });

  late final int id;
  late final String name;
  late final String nameAr;
  late final int governorateId;
  late final ShippingPrice? shippingPrice;

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    governorateId = json['governorate_id'];
    if (json['shipping_price'] != null) {
      shippingPrice = ShippingPrice.fromJson(json['shipping_price']);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['name_ar'] = nameAr;
    _data['governorate_id'] = governorateId;
    _data['shipping_price'] = shippingPrice!.toJson();
    return _data;
  }
}

class ShippingPrice {
  late int? id;
  late int? price;
  ShippingPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id ?? 0;
    _data['price'] = price ?? 0;
    return _data;
  }
}

class GovernmentShippingPriceModel {
  GovernmentShippingPriceModel({
    required this.id,
    required this.governorateFrom,
    required this.governorateTo,
    required this.cityFrom,
    required this.cityTo,
    required this.price,
  });

  late final int id;
  late final int governorateFrom;
  late final int governorateTo;
  late final int cityFrom;
  late final int cityTo;
  late final int price;

  GovernmentShippingPriceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateFrom = json['governorate_from'] ?? 0;
    governorateTo = json['governorate_to'] ?? 0;
    cityFrom = json['city_from'] ?? 0;
    cityTo = json['city_to'] ?? 0;
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['governorate_from'] = governorateFrom;
    _data['governorate_to'] = governorateTo;
    _data['city_from'] = cityFrom;
    _data['city_to'] = cityTo;
    _data['price'] = price;
    return _data;
  }
}
