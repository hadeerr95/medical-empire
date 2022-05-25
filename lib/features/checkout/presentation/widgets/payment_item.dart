import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';

class PaymentItem extends StatelessWidget {
  final PaymentMethodModel paymentMethodModel;
  final int index;

  const PaymentItem({
    Key? key,
    required this.paymentMethodModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(paymentMethodModel.status == 1){
          MainCubit.get(context).changePaymentMethodIndex(index: index);
        }
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
                if (MainCubit.get(context).paymentMethodIndex == index)
                  CircleAvatar(
                    backgroundColor: HexColor(green),
                    radius: 5,
                  ),
                if (MainCubit.get(context).paymentMethodIndex != index)
                  CircleAvatar(
                    backgroundColor: HexColor(secondaryVariantDark),
                    radius: 5,
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 4,
                    ),
                  ),
                space15Horizontal,
                Text(
                  paymentMethodModel.name.en,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: HexColor(secondaryVariantDark),
                        fontWeight: FontWeight.w400,
                        decoration: paymentMethodModel.status == 1
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
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
