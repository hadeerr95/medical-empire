import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class RelatedProductItem extends StatelessWidget {
  const RelatedProductItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProductRelatedModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.0,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: HexColor(productBackground),
              // border: Border.all(
              //   color: Colors.grey[300]!,
              //   width: 1.0,
              // ),
            ),
            width: 190.0,
            height: 190.0,
            child: Stack(
              children: [
                 Image(
                  image: NetworkImage(
                      '${model.image}',
                  ),
                  width: double.infinity,
                  height: 190.0,
                  fit: BoxFit.cover,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(
                //     12.0,
                //   ),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 10.0, vertical: 4.0),
                //     decoration: BoxDecoration(
                //       color: HexColor(red),
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: Text(
                //       'Sale',
                //       style: Theme.of(context).textTheme.caption!.copyWith(
                //             color: HexColor(surface),
                //           ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_outline,
                          size: 16.0,
                          color: HexColor(mainColor),
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: HexColor(mainColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 14.0,
                            color: HexColor(surface),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name.en,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                space3Vertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'EGP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    space3Horizontal,
                    Text(
                      model.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                space3Vertical,
                // Row(
                //   children: [
                //     RatingBar.builder(
                //       ignoreGestures: true,
                //       tapOnlyMode: true,
                //       updateOnDrag: false,
                //       initialRating: 4,
                //       minRating: 1,
                //       itemSize: 12.0,
                //       direction: Axis.horizontal,
                //       allowHalfRating: true,
                //       itemCount: 5,
                //       itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                //       itemBuilder: (context, _) => const Icon(
                //         Icons.star,
                //         color:Colors.yellow,
                //       ),
                //       onRatingUpdate: (rating) {
                //         // print(rating);
                //       },
                //     ),
                //     space3Horizontal,
                //     Text(
                //       '(5)',
                //       maxLines: 2,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.caption,
                //     ),
                //   ],
                // ),


                // Row(
                //   children: [
                //     Container(
                //       child: Text(
                //         '10% OFF',
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         style: Theme.of(context).textTheme.caption!.copyWith(
                //               fontWeight: FontWeight.bold,
                //               color: HexColor(secondColor),
                //             ),
                //       ),
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 5.0,
                //         vertical: 3.0,
                //       ),
                //       color: HexColor(secondColor).withOpacity(
                //         .2,
                //       ),
                //     ),
                //     const Spacer(),
                //     Icon(
                //       Icons.star,
                //       size: 12.0,
                //       color: HexColor(secondColor),
                //     ),
                //     Text(
                //       '4.8',
                //       maxLines: 2,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.caption!.copyWith(
                //             fontWeight: FontWeight.bold,
                //             color: HexColor(secondColor),
                //           ),
                //     ),
                //     space3Horizontal,
                //     Text(
                //       '(${products.quantityInStock})',
                //       maxLines: 2,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.caption,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
