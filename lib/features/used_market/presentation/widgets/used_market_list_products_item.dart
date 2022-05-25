import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/used_market_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/features/used_product_details/presentation/page/used_product_details_page.dart';

class UsedMarketListOfProducts extends StatelessWidget {
  final UsedMarketProduct product;

  const UsedMarketListOfProducts({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: () {
    //     navigateTo(context, UsedProductDetailsPage(
    //       id: product.id,
    //     ),
    //     );
    //   },
    //   child: Padding(
    //     padding: const EdgeInsetsDirectional.only(
    //       top: 0.0,
    //       start: 15.0,
    //       end: 15.0,
    //       bottom: 10,
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsetsDirectional.only(
    //             top: 10.0,
    //           ),
    //           child: Container(
    //             height: 120.0,
    //             width: 100.0,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8.0),
    //               image: DecorationImage(
    //                 image: NetworkImage(
    //                   product.image,
    //                 ),
    //                 fit: BoxFit.cover
    //               ),
    //               border: Border.all(
    //                 color: Colors.grey[300]!,
    //                 width: 1.0,
    //               ),
    //             ),
    //           ),
    //         ),
    //         space10Horizontal,
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsetsDirectional.only(
    //               top: 10.0,
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 // Container(
    //                 //   alignment: AlignmentDirectional.center,
    //                 //   width: 40.0,
    //                 //   height: 22.0,
    //                 //   decoration: BoxDecoration(
    //                 //     color: Colors.red,
    //                 //     borderRadius: BorderRadiusDirectional.circular(12.0),
    //                 //   ),
    //                 //   child: Text(
    //                 //     'Sale',
    //                 //     textAlign: TextAlign.center,
    //                 //     style: Theme.of(context).textTheme.caption!.copyWith(
    //                 //       color: HexColor(surface),
    //                 //     ),
    //                 //   ),
    //                 //
    //                 // ),
    //                 // space10Vertical,
    //                 Text(
    //                   MainCubit.get(context).isRtl
    //                       ? product.name.ar
    //                       : product.name.en,
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
    //                         // color: secondaryVariant,
    //                         color: HexColor(secondaryVariantDark),
    //                       ),
    //                 ),
    //                 space3Vertical,
    //                 Text(
    //                   'EGP${product.price}',
    //                   style: Theme.of(context).textTheme.subtitle1,
    //                 ),
    //                 space5Vertical,
    //                 // Row(
    //                 //   children: [
    //                 //     RatingBar.builder(
    //                 //       allowHalfRating: true,
    //                 //       initialRating: 0,
    //                 //       minRating: 1,
    //                 //       itemSize: 16.0,
    //                 //       direction: Axis.horizontal,
    //                 //       itemCount: 5,
    //                 //       itemBuilder: (context, _) => const Icon(
    //                 //         Icons.star,
    //                 //         color: Colors.amber,
    //                 //       ),
    //                 //       onRatingUpdate: (rating) {
    //                 //         // print(rating);
    //                 //       },
    //                 //     ),
    //                 //     space4Horizontal,
    //                 //     Text(
    //                 //       '(4)',
    //                 //       style: Theme.of(context).textTheme.bodyText2!.copyWith(
    //                 //           color: secondaryVariant
    //                 //       ),
    //                 //     ),
    //                 //   ],
    //                 // ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         // space10Horizontal,
    //         // Column(
    //         //   children: [
    //         //     IconButton(
    //         //       icon: Container(
    //         //         height: 30.0,
    //         //         width: 30.0,
    //         //         decoration: BoxDecoration(
    //         //           color: HexColor(mainColor),
    //         //           borderRadius: BorderRadius.circular(8.0),
    //         //         ),
    //         //         child: Icon(
    //         //           Icons.add,
    //         //           size: 14.0,
    //         //           color: HexColor(surface),
    //         //         ),
    //         //       ),
    //         //       padding: EdgeInsets.zero,
    //         //       onPressed: () {},
    //         //     ),
    //         //     WishListButton(id: products.id,),
    //         //   ],
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
    return SizedBox(
      height: 168.0,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            UsedProductDetailsPage(
              id: product.id,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 168.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          product.image,
                        ),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  // if (products.oldPrice != null)
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Align(
                  //       alignment: AlignmentDirectional.topStart,
                  //       child: Container(
                  //         child: Text(
                  //           appTranslation(context).sale,
                  //           maxLines: 2,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: Theme.of(context).textTheme.caption!.copyWith(
                  //             fontWeight: FontWeight.bold,
                  //             color: HexColor(white),
                  //           ),
                  //         ),
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 5.0,
                  //           vertical: 3.0,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(
                  //             4.0,
                  //           ),
                  //           color: HexColor('da7339'),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              space10Horizontal,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayTranslatedText(
                                  context: context,
                                  en: product.name.en,
                                  ar: product.name.ar,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      // color: secondaryVariant,
                                      color: HexColor(blueGrey),
                                    ),
                              ),
                              space5Vertical,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${product.price}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: HexColor(mainColor),
                                        ),
                                  ),
                                  space3Horizontal,
                                  Text(
                                    appTranslation(context).egp,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: HexColor(mainColor),
                                        ),
                                  ),
                                  // space5Horizontal,
                                  // Text(
                                  //   products.oldPrice != null
                                  //       ? '${products.oldPrice} ${appTranslation(context).egp}'
                                  //       : '',
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style:
                                  //   Theme.of(context).textTheme.subtitle2!.copyWith(
                                  //     decoration: TextDecoration.lineThrough,
                                  //     color: HexColor(mainColor),
                                  //   ),
                                  // ),
                                ],
                              ),
                              // space5Vertical,
                              // CartButton(
                              //   product: products,
                              // ),
                            ],
                          ),
                        ),
                        // space20Horizontal,
                        // Column(
                        //   children: [
                        //     CompareButton(
                        //       id: products.id,
                        //     ),
                        //     space10Vertical,
                        //     WishListButton(
                        //       id: products.id,
                        //     ),
                        //   ],
                        // ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    // space10Vertical,
                    // SizedBox(
                    //   height: 48.0,
                    //   child: CartButton(
                    //     product: products,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
