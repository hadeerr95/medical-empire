import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/widgets/compare_button.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';
import 'package:medical_empire_app/core/util/widgets/wish_list_button.dart';
import 'package:medical_empire_app/features/product_details/presentation/page/product_details_page.dart';

class SingleCartItem extends StatelessWidget {
  final CartModel cartItem;

  const SingleCartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(
        20.0,
      ),
      child: SizedBox(
        // height: 140.0,
        child: InkWell(
          onTap: () {
            navigateTo(
              context,
              ProductDetailsPage(
                slug: cartItem.slug.ar,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 0.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 140.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            cartItem.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
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
                                    en: cartItem.name.en,
                                    ar: cartItem.name.ar,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      cartItem.price,
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
                                  ],
                                ),
                                Text(
                                  '${appTranslation(context).total} : ${(double.parse(cartItem.price) * cartItem.quantity).toInt()} ${appTranslation(context).egp}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: HexColor(mainColor),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          space20Horizontal,
                          Column(
                            children: [
                              CompareButton(
                                id: cartItem.id,
                              ),
                              space10Vertical,
                              WishListButton(
                                id: cartItem.id,
                              ),
                            ],
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      space10Vertical,
                      SizedBox(
                        height: 40.0,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MainCubit.get(context).isDark
                                    ? HexColor(secondBackground)
                                    : HexColor(darkWhite),
                                borderRadius:
                                    BorderRadiusDirectional.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      int returnedType =
                                          await MainCubit.get(context)
                                              .cartSubtraction(
                                        id: cartItem.id,
                                      );
                                      if (returnedType < 0) {
                                        showRemoveDialog(context);
                                      }
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.minus,
                                      size: 16.0,
                                      color: HexColor(mainColor),
                                    ),
                                  ),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          color: HexColor(mainColor),
                                        ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      MainCubit.get(context).cartAddition(
                                        id: cartItem.id,
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 16.0,
                                      color: HexColor(mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    FontAwesomeIcons.trashAlt,
                                    size: 16.0,
                                    color: HexColor(mainColor),
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  showRemoveDialog(context);
                                },
                              ),
                            ),
                            // MyButton(
                            //   voidCallback: () {
                            //     removeFromCart(
                            //       context: context,
                            //       id: cartItem.id,
                            //     );
                            //   },
                            //   text: appTranslation(context).remove,
                            //   color: HexColor(red),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showRemoveDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TwoOptionsDialog(
            pushButtonVoidCallback: () {
              removeFromCart(
                context: context,
                id: cartItem.id,
              );
              Navigator.pop(context);
            },
            popButtonVoidCallback: () {
              Navigator.pop(context);
            },
            message: appTranslation(context).areYouSureRemoveCart,
            // title: 'title',
            pushButtonText: appTranslation(context).remove,
            popButtonText: appTranslation(context).cancel,
          );
        });
  }
}
