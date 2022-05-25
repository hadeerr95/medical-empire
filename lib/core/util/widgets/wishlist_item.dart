import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/models/wishlist_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/wish_list_button.dart';

class WishlistItem extends StatelessWidget {
  final ProductModel model;

  const WishlistItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                width: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${model.image}',
                      ),
                    )),
              ),
              space20Horizontal,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: AlignmentDirectional.center,
                    //   width: 40.0,
                    //   height: 22.0,
                    //   decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     borderRadius: BorderRadiusDirectional.circular(12.0),
                    //   ),
                    //   child: Text(
                    //     'Sale',
                    //     textAlign: TextAlign.center,
                    //     style: Theme.of(context).textTheme.caption!.copyWith(
                    //       color: HexColor(surface),
                    //     ),
                    //   ),
                    //
                    // ),
                    // space10Vertical,
                    Text(
                      model.name.en,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: secondaryVariant),
                    ),
                    space3Vertical,
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                        text: 'from ',
                        children: [
                          TextSpan(
                            text: 'EGP${model.price}',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: secondaryVariant,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    space5Vertical,
                    // Row(
                    //   children: [
                    //     RatingBar.builder(
                    //       allowHalfRating: true,
                    //       initialRating: 0,
                    //       minRating: 1,
                    //       itemSize: 16.0,
                    //       direction: Axis.horizontal,
                    //       itemCount: 5,
                    //       itemBuilder: (context, _) => const Icon(
                    //         Icons.star,
                    //         color: Colors.amber,
                    //       ),
                    //       onRatingUpdate: (rating) {
                    //         // print(rating);
                    //       },
                    //     ),
                    //     space4Horizontal,
                    //     Text(
                    //       '(4)',
                    //       style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    //           color: secondaryVariant
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // MainCubit.get(context).removeFromWishList(productId: '1000');
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        color: HexColor(mainColor),
                        borderRadius: BorderRadiusDirectional.circular(8.0),
                      ),
                      child: Icon(
                        Icons.add,
                        color: HexColor(surface),
                      ),
                    ),
                  ),
                  WishListButton(id: model.id,),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}