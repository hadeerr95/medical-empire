import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/default_form_field.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';

class AddressShippingPage extends StatelessWidget {
  TextEditingController governorateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildNumberAddressController = TextEditingController();
  TextEditingController specialController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<GovernmentModel> governmentModel;

  AddressShippingPage({
    Key? key,
    required this.governmentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if (state is AddAddressSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, state) {
        return BackScaffold(
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: appTranslation(context).address_shipping,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InputDecorator(
                      decoration: InputDecoration(
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: HexColor(black),
                                    ),
                            onChanged: (newValue) {
                              MainCubit.get(context)
                                  .selectGovernment(newValue!);
                              governorateController.text =
                                  newValue.id.toString();
                            },
                            value: MainCubit.get(context).selectedGovernment,
                            items: governmentModel
                                .map<DropdownMenuItem<GovernmentModel>>(
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
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
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
                                imagePath: 'polygon_down2',
                                color: HexColor(grey)),
                            elevation: 0,
                            isDense: false,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
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
                                .map<DropdownMenuItem<CitiesModel>>(
                                    (CitiesModel value) {
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
                    BuildCondition(
                      condition: state is AddAddressLoadingState,
                      builder:(context) => const Center(child: CircularProgressIndicator()) ,
                      fallback:(context) =>  MyButton(
                        text: appTranslation(context).save,
                        voidCallback: () {
                          print(governorateController.text);
                          print(cityController.text);
                          if (governorateController.text.isEmpty ||
                              governorateController.text == '') {
                            governorateController.text =
                                MainCubit.get(context).selectedGovernment!.id.toString();
                          }
                          if (cityController.text.isEmpty ||
                              cityController.text == '') {
                            cityController.text =
                                MainCubit.get(context).selectedCity!.id.toString();
                          }
                          if (formKey.currentState!.validate()) {
                            MainCubit.get(context).addMyAddress(
                              buildingNumber: buildNumberAddressController.text,
                              city: int.parse(cityController.text),
                              governorate: int.parse(governorateController.text),
                              specialMarker: specialController.text,
                              streetName: streetNameController.text,
                            );
                          }

                          print(governorateController.text);
                          print(cityController.text);
                        },
                        color: HexColor(mainColor),
                        radius: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
