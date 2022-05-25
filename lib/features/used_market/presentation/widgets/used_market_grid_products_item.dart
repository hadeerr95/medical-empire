import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/used_market_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/used_product_details/presentation/page/used_product_details_page.dart';

class UsedMarketProductHorizontalItem extends StatelessWidget {
  final UsedMarketProduct product;

  const UsedMarketProductHorizontalItem({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        // return InkWell(
        //   onTap: () {
        //     navigateTo(
        //       context,
        //       UsedProductDetailsPage(
        //         id: product.id,
        //       ),
        //     );
        //   },
        //   child: SizedBox(
        //     width: 190.0,
        //     child: Column(
        //       children: [
        //         Container(
        //           clipBehavior: Clip.antiAliasWithSaveLayer,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(
        //               10.0,
        //             ),
        //             image: DecorationImage(
        //               image: NetworkImage(product.image),
        //               fit: BoxFit.cover,
        //             ),
        //             border: Border.all(
        //               color: Colors.grey[300]!,
        //               width: 1.0,
        //             ),
        //           ),
        //           width: double.infinity,
        //           height: 190.0,
        //           // child: Column(
        //           //   crossAxisAlignment: CrossAxisAlignment.end,
        //           //   children: [
        //           //     // WishListButton(
        //           //     //   id: products.id,
        //           //     // ),
        //           //     // const Spacer(),
        //           //     // IconButton(
        //           //     //   icon: Container(
        //           //     //     height: 30.0,
        //           //     //     width: 30.0,
        //           //     //     decoration: BoxDecoration(
        //           //     //       color: HexColor(mainColor),
        //           //     //       borderRadius: BorderRadius.circular(8.0),
        //           //     //     ),
        //           //     //     child: Icon(
        //           //     //       Icons.add,
        //           //     //       size: 14.0,
        //           //     //       color: HexColor(surface),
        //           //     //     ),
        //           //     //   ),
        //           //     //   padding: EdgeInsets.zero,
        //           //     //   onPressed: () {},
        //           //     // ),
        //           //   ],
        //           // ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 MainCubit.get(context).isRtl
        //                     ? product.name.ar
        //                     : product.name.en,
        //                 maxLines: 1,
        //                 overflow: TextOverflow.ellipsis,
        //                 style: Theme.of(context).textTheme.bodyText2,
        //               ),
        //               space3Vertical,
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.baseline,
        //                 textBaseline: TextBaseline.alphabetic,
        //                 children: [
        //                   Text(
        //                     appTranslation(context).egp,
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: Theme.of(context).textTheme.caption,
        //                   ),
        //                   space3Horizontal,
        //                   Text(
        //                     '${product.price}',
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: Theme.of(context).textTheme.subtitle1,
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        return GestureDetector(
          onTap: () {
            navigateTo(
              context,
              UsedProductDetailsPage(
                id: product.id,
              ),
            );
          },
          child: Container(
            width: 240.0,
            height: 412.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: MainCubit.get(context).isDark
                  ? HexColor(secondBackground)
                  : HexColor(white),
              border: Border.all(
                color: HexColor(greyWhite),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(
                              8.0,
                            ),
                            topEnd: Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        child: Image(
                          image: NetworkImage(
                            product.image,
                          ),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayTranslatedText(
                              context: context,
                              ar: product.name.ar,
                              en: product.name.en,
                            ),
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
                                '${product.price}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                  color: HexColor(mainColor),
                                ),
                              ),
                              space3Horizontal,
                              Text(
                                appTranslation(context).egp,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                          // space3Vertical,
                          // Text(
                          //   products.oldPrice != null ? 'EGP ${products.oldPrice}' : '',
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: Theme.of(context).textTheme.caption!.copyWith(
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                          // space3Vertical,
                          // Row(
                          //   children: [
                          //     if (products.oldPrice != null)
                          //       Container(
                          //         child: Text(
                          //           'SALE',
                          //           maxLines: 2,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .caption!
                          //               .copyWith(
                          //             fontWeight: FontWeight.bold,
                          //             color: HexColor('da7339'),
                          //           ),
                          //         ),
                          //         padding: const EdgeInsets.symmetric(
                          //           horizontal: 5.0,
                          //           vertical: 3.0,
                          //         ),
                          //         color: HexColor('da7339').withOpacity(
                          //           .2,
                          //         ),
                          //       ),
                          //     if (products.oldPrice == null)
                          //       Container(
                          //         child: Text(
                          //           '',
                          //           maxLines: 2,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .caption!
                          //               .copyWith(
                          //             fontWeight: FontWeight.bold,
                          //             color: HexColor('da7339'),
                          //           ),
                          //         ),
                          //         padding: const EdgeInsets.symmetric(
                          //           horizontal: 5.0,
                          //           vertical: 3.0,
                          //         ),
                          //       ),
                          //     // const Spacer(),
                          //     // Icon(
                          //     //   Icons.star,
                          //     //   size: 12.0,
                          //     //   color: HexColor('da7339'),
                          //     // ),
                          //     // Text(
                          //     //   '4.5',
                          //     //   maxLines: 2,
                          //     //   overflow: TextOverflow.ellipsis,
                          //     //   style:
                          //     //   Theme.of(context).textTheme.caption!.copyWith(
                          //     //     fontWeight: FontWeight.bold,
                          //     //     color: HexColor('da7339'),
                          //     //   ),
                          //     // ),
                          //     // space3Vertical,
                          //     // Text(
                          //     //   '(5)',
                          //     //   maxLines: 2,
                          //     //   overflow: TextOverflow.ellipsis,
                          //     //   style: Theme.of(context).textTheme.caption,
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CartButton(
                    //     product: products,
                    //   ),
                    // ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       SizedBox(
                //         height: 40.0,
                //         width: 40.0,
                //         child: IconButton(
                //           icon: CircleAvatar(
                //             radius: 20.0,
                //             backgroundColor: Colors.grey[300],
                //             child: const Icon(
                //               Icons.favorite_outline,
                //               size: 16.0,
                //               color: Colors.grey,
                //             ),
                //           ),
                //           padding: EdgeInsets.zero,
                //           onPressed: () {},
                //         ),
                //       ),
                //       CompareButton(
                //         id: products.id,
                //       ),
                //       space5Vertical,
                //       WishListButton(
                //         id: products.id,
                //       ),
                //     ],
                //   ),
                // ),
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
          ),
        );
      },
    );
  }
}
