import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';

import '../constants.dart';
import 'asset_svg.dart';
import 'default_form_field.dart';

class ShippingAddressForm extends StatelessWidget {
  final TextEditingController governorateController;
  final TextEditingController cityController;
  final TextEditingController streetNameController;
  final TextEditingController buildNumberAddressController;
  final TextEditingController specialController;
  final List<GovernmentModel> governmentModel;

  final GlobalKey<FormState> formKey;
  const ShippingAddressForm({
    Key? key,
    required this.governmentModel,
    required this.governorateController,
    required this.cityController,
    required this.streetNameController,
    required this.buildNumberAddressController,
    required this.specialController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          InputDecorator(
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              labelText: appTranslation(context).select_government,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MainCubit.get(context).isDark
                      ? HexColor(grey)
                      : secondaryVariant,
                ),
              ),
              hintStyle: Theme.of(context).textTheme.bodyText1,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(darkWhite),
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: MainCubit.get(context).isDark
                      ? HexColor(secondBackground)
                      : HexColor(darkWhite),
                ),
                child: DropdownButton<GovernmentModel>(
                  icon: AssetSvg(
                    imagePath: 'polygon_down2',
                    color: HexColor(grey),
                  ),
                  elevation: 0,
                  isDense: false,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: HexColor(black),
                      ),
                  onChanged: (newValue) {
                    MainCubit.get(context).selectGovernment(newValue!);
                    governorateController.text = newValue.id.toString();
                  },
                  value: MainCubit.get(context).selectedGovernment,
                  items: governmentModel.map<DropdownMenuItem<GovernmentModel>>(
                      (GovernmentModel value) {
                    return DropdownMenuItem<GovernmentModel>(
                      value: value,
                      child: Text(
                        value.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          space10Vertical,
          InputDecorator(
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              labelText: appTranslation(context).select_city,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MainCubit.get(context).isDark
                      ? HexColor(grey)
                      : secondaryVariant,
                ),
              ),
              hintStyle: Theme.of(context).textTheme.bodyText1,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(darkWhite),
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: MainCubit.get(context).isDark
                      ? HexColor(secondBackground)
                      : HexColor(darkWhite),
                ),
                child: DropdownButton<CitiesModel>(
                  icon: AssetSvg(
                      imagePath: 'polygon_down2', color: HexColor(grey)),
                  elevation: 0,
                  isDense: false,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: HexColor(black),
                      ),
                  onChanged: (newValue) {
                    MainCubit.get(context).selectCity(newValue!);
                    cityController.text = newValue.id.toString();
                  },
                  value: MainCubit.get(context).selectedCity,
                  items: MainCubit.get(context)
                      .selectedGovernment!
                      .cities
                      .map<DropdownMenuItem<CitiesModel>>((CitiesModel value) {
                    return DropdownMenuItem<CitiesModel>(
                      value: value,
                      child: Text(
                        value.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          space10Vertical,
          DefaultFormField(
            title: appTranslation(context).street_name,
            controller: streetNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return appTranslation(context).streetNameEmpty;
              }
            },
          ),

          // RegionPickerFormField(
          //   hint: 'Country/Region',
          //   controller: regionController,
          // ),
          space10Vertical,
          DefaultFormField(
            title: appTranslation(context).building_number_address,
            controller: buildNumberAddressController,
            validator: (value) {
              if (value!.isEmpty) {
                return appTranslation(context).buildingNumberEmpty;
              }
            },
          ),
          space10Vertical,
          DefaultFormField(
            title: appTranslation(context).special_marker,
            controller: specialController,
            validator: (value) {
              if (value!.isEmpty) {
                return appTranslation(context).specialMarkerEmpty;
              }
            },
          ),
          space20Vertical,
        ],
      ),
    );
  }
}
