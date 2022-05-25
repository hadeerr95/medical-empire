import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/shipping_address_form.dart';

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
              child: Column(
                children: [
                  ShippingAddressForm(
                    governmentModel: MainCubit.get(context)
                        .addressFeedModel!
                        .data
                        .governorates!,
                    buildNumberAddressController: buildNumberAddressController,
                    cityController: cityController,
                    formKey: formKey,
                    governorateController: governorateController,
                    specialController: specialController,
                    streetNameController: streetNameController,
                  ),
                  BuildCondition(
                    condition: state is AddAddressLoadingState,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    fallback: (context) => MyButton(
                      text: appTranslation(context).save,
                      voidCallback: () {
                        print(governorateController.text);
                        print(cityController.text);
                        if (governorateController.text.isEmpty ||
                            governorateController.text == '') {
                          governorateController.text = MainCubit.get(context)
                              .selectedGovernment!
                              .id
                              .toString();
                        }
                        if (cityController.text.isEmpty ||
                            cityController.text == '') {
                          cityController.text = MainCubit.get(context)
                              .selectedCity!
                              .id
                              .toString();
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
        );
      },
    );
  }
}
