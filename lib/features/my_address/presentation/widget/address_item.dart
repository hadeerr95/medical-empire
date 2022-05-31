import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/models/user_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class AddressItem extends StatelessWidget {
  final UserModel userModel;
  final Addresses address;

  const AddressItem({
    Key? key,
    required this.userModel,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 18.0,
                    color: HexColor(grey),
                  ),
                  space10Horizontal,
                  Text(
                    address.streetName,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Spacer(),
                  IconButton(
                    alignment: AlignmentDirectional.centerEnd,
                    onPressed: () {
                      MainCubit.get(context)
                          .deleteMyAddress(addressId: address.id);
                    },
                    icon: Icon(
                      FontAwesomeIcons.trashAlt,
                      size: 18.0,
                      color: HexColor(grey),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  space10Vertical,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appTranslation(context).name,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          userModel.name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  space10Vertical,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appTranslation(context).address,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${address.buildingNumber}, ${address.streetName}, ${MainCubit.get(context).addressFeedModel!.data.governorates!.singleWhere((element) => element.id == address.governateId).cities.singleWhere((element) => element.id == address.cityId).name}, ${MainCubit.get(context).addressFeedModel!.data.governorates!.singleWhere((element) => element.id == address.governateId).name}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  space10Vertical,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appTranslation(context).mobile_phone,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          userModel.phone,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
