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

                space15Horizontal,
                Expanded(
                  child: Text(
                    '${shippingAddressModel.buildingNumber}, ${shippingAddressModel.streetName}, ${shippingAddressModel.shippingAddressCitiesModel.name}, ${shippingAddressModel.shippingAddressGovernmentModel.name}',
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
