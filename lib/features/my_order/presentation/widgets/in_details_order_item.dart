import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/order_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class InDetailsOrderItem extends StatelessWidget {
  const InDetailsOrderItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OrderItem model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15.0,
          ),
          height: 130.0,
          color: MainCubit.get(context).isDark
              ? HexColor(secondBackground)
              : HexColor(greyWhite),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MainCubit.get(context).isRtl
                          ? model.product.name.ar
                          : model.product.name.en,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: HexColor(secondaryVariantDark),
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 2,
                    ),
                    space10Vertical,
                    // RatingBar.builder(
                    //   ignoreGestures: true,
                    //   tapOnlyMode: true,
                    //   updateOnDrag: false,
                    //   initialRating: 4,
                    //   minRating: 1,
                    //   itemSize: 18.0,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: HexColor(starColor),
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     // print(rating);
                    //   },
                    // ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          '${appTranslation(context).quantity} : ${model.quantity}',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              space15Horizontal,
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: Image(
                  image: NetworkImage(model.product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
