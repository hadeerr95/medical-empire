import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/address_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/box_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/cash_section.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/checkout_product_item.dart';
import 'package:medical_empire_app/features/checkout/presentation/widgets/payment_item.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).getCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).checkout,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if(state is CreateCheckoutSuccess) {
            showToast(
              message: state.message,
              toastStates: ToastStates.SUCCESS,
            );

            MainCubit.get(context).clearCart();
          }

          if(state is CartClear) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BuildCondition(
            condition: MainCubit.get(context).checkoutModel != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    BoxItem(
                      title: appTranslation(context).shipping_address,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => AddressItem(
                          index: index,
                          shippingAddressModel: MainCubit.get(context)
                              .checkoutModel!
                              .data
                              .shippingAddresses![index],
                        ),
                        itemCount: MainCubit.get(context)
                            .checkoutModel!
                            .data
                            .shippingAddresses!
                            .length,
                      ),
                    ),
                    space15Vertical,
                    BoxItem(
                      title: appTranslation(context).payment_method,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => PaymentItem(
                          index: index,
                          paymentMethodModel: MainCubit.get(context)
                              .checkoutModel!
                              .data
                              .paymentMethod![index],
                        ),
                        itemCount: MainCubit.get(context)
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
                          ...MainCubit.get(context)
                              .cartMap
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  Column(
                                    children: [
                                      Container(
                                        height: 1.0,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      space15Vertical,
                                      CheckoutProductItem(
                                        cartItem: value,
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
                      title: appTranslation(context).total,
                      child: const CashSection(),
                    ),
                    space15Vertical,
                    if(state is CreateCheckoutLoading)
                      const Center(child: CupertinoActivityIndicator()),
                    if(state is! CreateCheckoutLoading)
                      MyButton(
                      voidCallback: () {
                        MainCubit.get(context).createCheckout();
                      },
                      text: appTranslation(context).completeOrder,
                      color: HexColor(mainColor),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
