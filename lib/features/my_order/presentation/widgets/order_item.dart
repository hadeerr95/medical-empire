import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/orders_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/features/my_order/presentation/pages/my_order_details_page.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 15),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: MainCubit.get(context).isDark
              ? HexColor(secondBackground)
              : HexColor(greyWhite),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: HexColor(green),
              ),
              child: Text(
                getOrderStatus(status: order.status, context: context),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: HexColor(surface),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      MyOrderDetailsPage(
                        orderId: order.id,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/delivery_truck.svg',
                        color: HexColor(grey),
                        width: 50.0,
                      ),
                      space20Horizontal,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).order_number,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const Spacer(),
                                Text(
                                  order.orderNumber,
                                  style:
                                      Theme.of(context).textTheme.headline6!.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            space3Vertical,
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).date,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const Spacer(),
                                Text(
                                  order.createdAt.split('T').first,
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            space3Vertical,
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).quantity,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const Spacer(),
                                Text(
                                  '${order.itemsCount}',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            space3Vertical,
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).total,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const Spacer(),
                                Text(
                                  '${order.totalAmount} ${appTranslation(context).egp}',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}