import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:medical_empire_app/core/util/widgets/user_account_details_widget.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/address_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/box_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/cash_section.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/checkout_product_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/payment_item.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController governorateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController buildNumberAddressController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final nameController = TextEditingController();
  final BehaviorSubject<int> _quantitySubject = BehaviorSubject<int>();
  final BehaviorSubject<int> _selectedAddressSubject = BehaviorSubject<int>();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getCheckout();
    MainCubit.get(context).getMyAddress();
    MainCubit.get(context).calculateFinalTotalCart();
    nameController.text = MainCubit.get(context).myAccountModel!.data.name;
    emailController.text = MainCubit.get(context).myAccountModel!.data.email;
    phoneController.text = MainCubit.get(context).myAccountModel!.data.phone;
    _selectedAddressSubject.sink.add(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _quantitySubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).checkout,
      scaffoldBackgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is AddAddressSuccessState) {
            MainCubit.get(context).createCheckout();
          }
          if (state is CreateCheckoutSuccess) {
            MainCubit.get(context).clearCart();
            showToast(
              message: state.message,
              toastStates: ToastStates.SUCCESS,
            );
          }
          if (state is CartClear) {
            print("---- back  -----");
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BuildCondition(
            condition: MainCubit
                .get(context)
                .checkoutModel != null,
            builder: (context) {
              var shippingAddress =
                  MainCubit.get(context).checkoutModel!.data.shippingAddresses;
              int addresses = 0;
              if (shippingAddress != null) {
                addresses = shippingAddress.length;
              }
              if (MainCubit
                  .get(context)
                  .checkoutModel!
                  .data
                  .shippingAddresses!
                  .isNotEmpty && isFirstTime) {
                setAddressControllers(0);
                isFirstTime = false;
              }
              return SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      BoxItem(
                        title: appTranslation(context).shipping_address,
                        child: shippingAddress == null || addresses == 0
                            ? buildAddressesWidget()
                            : StreamBuilder<int>(
                            stream: _selectedAddressSubject.stream,
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: MainCubit
                                        .get(context)
                                        .checkoutModel!
                                        .data
                                        .shippingAddresses!
                                        .length * 60,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Row(
                                            children: [
                                              Checkbox(value: index ==
                                                  _selectedAddressSubject.value,
                                                  onChanged: (bool? newValue) {
                                                    _selectedAddressSubject.sink
                                                        .add(index);
                                                    setAddressControllers(
                                                        index);
                                                  }),
                                              Flexible(
                                                child: SizedBox(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  child: AddressItem(
                                                    index: index,
                                                    shippingAddressModel: MainCubit
                                                        .get(context)
                                                        .checkoutModel!
                                                        .data
                                                        .shippingAddresses![index],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      itemCount: MainCubit
                                          .get(context)
                                          .checkoutModel!
                                          .data
                                          .shippingAddresses!
                                          .length,
                                    ),
                                  ),
                                  buildAddressesWidget()
                                ],
                              );
                            }
                        ),
                      ),
                      space15Vertical,
                      BoxItem(
                        title: appTranslation(context).personalInformation,
                        child: buildPersonalInformationWidget(),
                      ),
                      space15Vertical,
                      BoxItem(
                        title: appTranslation(context).payment_method,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              PaymentItem(
                                index: index,
                                paymentMethodModel: MainCubit
                                    .get(context)
                                    .checkoutModel!
                                    .data
                                    .paymentMethod![index],
                              ),
                          itemCount: MainCubit
                              .get(context)
                              .checkoutModel!
                              .data
                              .paymentMethod!
                              .length,
                        ),
                      ),
                      space15Vertical,
                      BoxItem(
                        title: appTranslation(context).products,
                        child: Column(
                          children: [
                            ...MainCubit
                                .get(context)
                                .cartMap
                                .map(
                                  (key, value) =>
                                  MapEntry(
                                    key,
                                    Column(
                                      children: [
                                        Container(
                                          height: 1.0,
                                          color: Theme
                                              .of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        space15Vertical,
                                        CheckoutProductItem(
                                          cartItem: value,
                                          quantitySubject: _quantitySubject,
                                        ),
                                      ],
                                    ),
                                  ),
                            )
                                .values
                                .toList(),
                          ],
                        ),
                      ),
                      space15Vertical,
                      BoxItem(
                          title: appTranslation(context).yourComment,
                          child: notesWidget()),
                      space15Vertical,
                      BoxItem(
                        title: appTranslation(context).total,
                        child: const CashSection(),
                      ),
                      space15Vertical,
                      if (state is CreateCheckoutLoading)
                        const Center(child: CupertinoActivityIndicator()),
                      if (state is! CreateCheckoutLoading)
                        MyButton(
                          voidCallback: () async{
                            if (shippingAddress == null || addresses == 0) {
                              await saveAddress();
                            }
                            else {
                              updateAddress(MainCubit.get(context).checkoutModel
                                  !.data.shippingAddresses![_selectedAddressSubject.value].id);
                            }
                            await saveProfileInformation();
                             MainCubit.get(context).changeShippingAddressIndex(index: _selectedAddressSubject.value);
                          },
                          text: appTranslation(context).completeOrder,
                          color: HexColor(mainColor),
                        ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) =>
            const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  buildAddressesWidget() {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if (state is AddAddressSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ShippingAddressForm(
              governmentModel:
              MainCubit
                  .get(context)
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
          ),
        );
      },
    );
  }

  saveAddress() async {
    if (governorateController.text.isEmpty ||
        governorateController.text == '') {
      governorateController.text =
          MainCubit.get(context).selectedGovernment!.id.toString();
    }
    if ((cityController.text.isEmpty || cityController.text == '')) {
      cityController.text = MainCubit.get(context).selectedCity!.id.toString();
    }
    if (formKey.currentState!.validate()) {
      await MainCubit.get(context).addMyAddress(
        buildingNumber: buildNumberAddressController.text,
        city: int.parse(cityController.text),
        governorate: int.parse(governorateController.text),
        specialMarker: specialController.text,
        streetName: streetNameController.text,
      );
    } else {
      _scrollController.jumpTo(0);
    }
  }

   updateAddress(int addressId) async{
    if (governorateController.text.isEmpty ||
        governorateController.text == '') {
      _scrollController.jumpTo(0);
      governorateController.text =
          MainCubit
              .get(context)
              .selectedGovernment!
              .id
              .toString();
    }
    if ((cityController.text.isEmpty || cityController.text == '')) {
      _scrollController.jumpTo(0);
      cityController.text =
          MainCubit
              .get(context)
              .selectedCity!
              .id
              .toString();
    }
    if (formKey.currentState!.validate()) {
      MainCubit.get(context).deleteMyAddress(addressId: addressId);
      await MainCubit.get(context).addMyAddress(
        buildingNumber: buildNumberAddressController.text,
        city: int.parse(cityController.text),
        governorate: int.parse(governorateController.text),
        specialMarker: specialController.text,
        streetName: streetNameController.text,
      );
    }
  }

  buildPersonalInformationWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: UserAccountDetailsWidget(
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController),
    );
  }

  saveProfileInformation() async {
    await MainCubit.get(context).updateAccount(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text);
  }

  notesWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: notesController,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: (note) {
          MainCubit.get(context).updateNote(note);
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void setAddressControllers(int index) {
    List<Addresses> addresses = MainCubit
        .get(context)
        .checkoutModel!
        .data
        .shippingAddresses!;
    buildNumberAddressController.text = addresses[index].buildingNumber;
    specialController.text = addresses[index].specialMarker;
    streetNameController.text = addresses[index].streetName;
    MainCubit
        .get(context)
        .selectedGovernment = MainCubit
        .get(context)
        .addressFeedModel!
        .data
        .governorates!
        .firstWhere((element) => element.id == addresses[index].governateId);
    MainCubit
        .get(context)
        .selectedCity = MainCubit
        .get(context)
        .selectedGovernment!
        .cities
        .firstWhere((e) => e.id == addresses[index].cityId);
    governorateController.text = addresses[index].governateId.toString();
    cityController.text = addresses[index].cityId.toString();

    print("------->"+MainCubit
        .get(context)
        .selectedCity!.name);
  }
}
