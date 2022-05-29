import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class CashSection extends StatelessWidget {
  const CashSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Column(
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
                  Text(
                    appTranslation(context).subtotal,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.get(context).subtotalCart} ${appTranslation(context).egp}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            cashForWeight(context),
            cashForVendor(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 13.0,
              ),
              child: Row(
                children: [
                  Text(
                    appTranslation(context).shipping,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '+ ${MainCubit.get(context).totalShippingPrice} ${appTranslation(context).egp}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            if (MainCubit.get(context).couponsModel != null &&
                MainCubit.get(context).couponsModel!.data != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 13.0,
                ),
                child: Row(
                  children: [
                    Text(
                      appTranslation(context).coupon,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: HexColor(secondaryVariantDark),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '- ${MainCubit.get(context).couponsModel!.data!.coupon.amount} ${appTranslation(context).egp}',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: HexColor(secondaryVariantDark),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            if (MainCubit.get(context).couponsModel != null &&
                MainCubit.get(context).couponsModel!.data != null)
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
                  Text(
                    appTranslation(context).total,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(mainColor),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.get(context).finalTotalCart} ${appTranslation(context).egp}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(mainColor),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget cashForWeight(context) {
    num overWeightTax = 0;
    MainCubit.get(context).cartMap.forEach((key, item) {
      if(item.weight !=null && num.parse(item.weight!) > 1000){
        num overWeight = (num.parse(item.weight!) - 1000) / 1000 * 5 ;
        overWeightTax += overWeight;
      }
    });
    if(overWeightTax > 0) {
      MainCubit.get(context).calculateFinalTotalCart(overTax: overWeightTax);
      return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 13.0,
          ),
          child: Row(
            children: [
              Text(
                appTranslation(context).overWeightTax,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: HexColor(secondaryVariantDark),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                '$overWeightTax ${appTranslation(context).egp}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: HexColor(secondaryVariantDark),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ],
    );
    } else {
      return  const SizedBox();
    }
  }

  Widget cashForVendor(context) {
    int firstVendorId = 0;
    num vendorTax = 0;
    MainCubit.get(context).cartMap.forEach((key, item) {
      if(firstVendorId == 0 ){
        firstVendorId = item.vendorId;
      }
      else if (firstVendorId != item.vendorId){
        vendorTax+=10;
      }
    });
    if(vendorTax > 0) {
      MainCubit.get(context).calculateFinalTotalCart(overTax: vendorTax);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 13.0,
            ),
            child: Row(
              children: [
                Text(
                  appTranslation(context).vendorTax,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: HexColor(secondaryVariantDark),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  '$vendorTax ${appTranslation(context).egp}',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: HexColor(secondaryVariantDark),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      );
    } else {
      return  const SizedBox();
    }
  }
}
