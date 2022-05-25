import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';

class AddressItem extends StatelessWidget {
  final Addresses shippingAddressModel;
  final int index;

  const AddressItem({
    Key? key,
    required this.index,
    required this.shippingAddressModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MainCubit.get(context).changeShippingAddressIndex(index: index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1.0,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 13.0,
            ),
            child: Row(
              children: [
                if (MainCubit.get(context).shippingAddressIndex == index)
                  CircleAvatar(
                    backgroundColor: HexColor(green),
                    radius: 5,
                  ),
                if (MainCubit.get(context).shippingAddressIndex != index)
                  CircleAvatar(
                    backgroundColor: HexColor(black),
                    radius: 5,
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 4,
                    ),
                  ),
                space15Horizontal,
                Expanded(
                  child: Text(
                    '${shippingAddressModel.building_number}, ${shippingAddressModel.street_name}, ${shippingAddressModel.shippingAddressCitiesModel.name}, ${shippingAddressModel.shippingAddressGovernmentModel.name}',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
