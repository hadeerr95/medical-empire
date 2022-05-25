import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/my_order/presentation/widgets/in_details_order_item.dart';

class MyOrderDetailsPage extends StatefulWidget {
  const MyOrderDetailsPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final int orderId;

  @override
  State<MyOrderDetailsPage> createState() => _MyOrderDetailsPageState();
}

class _MyOrderDetailsPageState extends State<MyOrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getOrderDetails(id: widget.orderId);
    MainCubit.get(context).getMyAddress();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).order_details,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<MainCubit, MainState>(
        listener: (context, state){
          if(state is CancelOrderDetailsSuccess){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BuildCondition(
            condition: MainCubit.get(context).orderDetailsModel != null &&
                MainCubit.get(context).addressFeedModel != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: MainCubit.get(context).isDark
                    ? Theme.of(context).scaffoldBackgroundColor
                    : HexColor(surface),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: MainCubit.get(context).isDark
                            ? HexColor(secondBackground)
                            : HexColor(greyWhite),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).order_number,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  MainCubit.get(context)
                                      .orderDetailsModel!
                                      .data
                                      .order
                                      .orderNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).subtotal,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '${MainCubit.get(context).orderDetailsModel!.data.order.totalAmount.split('.').first} ${appTranslation(context).egp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w700,
                                      ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).shipping,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${MainCubit.get(context).orderDetailsModel!.data.order.shipping_price} ${appTranslation(context).egp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).extra_shipping,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${MainCubit.get(context).orderDetailsModel!.data.order.extra_shipping} ${appTranslation(context).egp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).overweight_price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${MainCubit.get(context).orderDetailsModel!.data.order.overweight_price} ${appTranslation(context).egp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).total,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(mainColor),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${MainCubit.get(context).totalAmount()} ${appTranslation(context).egp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: HexColor(mainColor),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          myDivider(context),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).payment_method,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  getPaymentMethodType(
                                      paymentId: int.parse(
                                          MainCubit.get(context)
                                              .orderDetailsModel!
                                              .data
                                              .order
                                              .paymentMethod),
                                      context: context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  appTranslation(context).date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  MainCubit.get(context)
                                      .orderDetailsModel!
                                      .data
                                      .order
                                      .createdAt
                                      .split('T')
                                      .first,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: HexColor(secondaryVariantDark),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          space10Vertical,
                          myDivider(context),
                          space10Vertical,
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: HexColor(grey),
                                    size: 14.0,
                                  ),
                                ),
                                space10Horizontal,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MainCubit.get(context)
                                          .orderDetailsModel!
                                          .data
                                          .order
                                          .name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color:
                                                HexColor(secondaryVariantDark),
                                          ),
                                    ),
                                    Text(
                                      '${MainCubit.get(context).orderDetailsModel!.data.order.buildingNumber}, ${MainCubit.get(context).orderDetailsModel!.data.order.streetName}, ${MainCubit.get(context).addressFeedModel!.data.governorates!.singleWhere((element) => element.id == int.parse(MainCubit.get(context).orderDetailsModel!.data.order.governate)).cities.singleWhere((element) => element.id == int.parse(MainCubit.get(context).orderDetailsModel!.data.order.city)).name}, ${MainCubit.get(context).addressFeedModel!.data.governorates!.singleWhere((element) => element.id == int.parse(MainCubit.get(context).orderDetailsModel!.data.order.governate)).name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                HexColor(secondaryVariantDark),
                                          ),
                                    ),
                                    Text(
                                      MainCubit.get(context)
                                          .orderDetailsModel!
                                          .data
                                          .order
                                          .phone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                HexColor(secondaryVariantDark),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    space15Vertical,
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: MainCubit.get(context).isDark
                            ? HexColor(secondBackground)
                            : HexColor(greyWhite),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: HexColor(green),
                            ),
                            child: Text(
                              getOrderStatus(
                                  status: MainCubit.get(context)
                                      .orderDetailsModel!
                                      .data
                                      .order
                                      .status,context: context),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                                color:
                                HexColor(surface),
                              ),
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InDetailsOrderItem(
                              model: MainCubit.get(context)
                                  .orderDetailsModel!
                                  .data
                                  .orderItems[index],
                            ),
                            separatorBuilder: (context, index) =>
                                myDivider(context),
                            itemCount: MainCubit.get(context)
                                .orderDetailsModel!
                                .data
                                .orderItems
                                .length,
                          ),
                        ],
                      ),
                    ),
                    space30Vertical,
                    if(MainCubit.get(context).orderDetailsModel!.data.order.status == 0)
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) => state is !CancelOrderDetailsLoading,
                        widgetBuilder: (context) => MyButton(
                          voidCallback: () {
                            MainCubit.get(context).cancelOrderDetails();
                          },
                          text: appTranslation(context).cancel,
                          color: HexColor(mainColor),
                        ),
                        fallbackBuilder: (context) =>  const Center(child: CircularProgressIndicator()),
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
