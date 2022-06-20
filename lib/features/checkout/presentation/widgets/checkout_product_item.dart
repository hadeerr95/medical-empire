import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/widgets/one_option_dialog.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';

class CheckoutProductItem extends StatelessWidget {
  final CartModel cartItem;
  const CheckoutProductItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.0,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  image: NetworkImage(
                    cartItem.image,
                  ),
                  fit: BoxFit.cover),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          space10Horizontal,
          Expanded(
            child: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MainCubit.get(context).isRtl
                        ? cartItem.name.ar
                        : cartItem.name.en,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                  space10Vertical,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            cartItem.price,
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
                        ],
                      ),
                      Text(
                        '${appTranslation(context).total} : ${(double.parse(cartItem.price) * cartItem.quantity).toInt()} ${appTranslation(context).egp}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: HexColor(mainColor),
                            ),
                      ),
                      space10Vertical,
                      Row(
                        children: [
                          Text(
                            '${appTranslation(context).quantity} :',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: HexColor(secondaryVariantDark),
                                    ),
                          ),
                          space3Horizontal,
                          GestureDetector(
                            onTap: () async {
                              int? stockRestriction =
                                  await MainCubit.get(context).cartAddition(
                                id: cartItem.id,
                              );
                              if (stockRestriction != null) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return OneOptionDialog(
                                        message: appTranslation(context)
                                                .cartAdditionMessage +
                                            stockRestriction.toString() +
                                            appTranslation(context).inStock,
                                        popButtonVoidCallback: () {
                                          Navigator.pop(context);
                                        },
                                        popButtonText:
                                            appTranslation(context).cancel,
                                        // title: 'title',
                                      );
                                    });
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          color: Colors.grey.shade400,
                                          offset: const Offset(1, 1))
                                    ]),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                )),
                          ),
                          space6Horizontal,
                          Text(
                            cartItem.quantity.toString(),
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: HexColor(secondaryVariantDark),
                                    ),
                          ),
                          space6Horizontal,
                          GestureDetector(
                            onTap: () async {
                              int returnedType =
                                  await MainCubit.get(context).cartSubtraction(
                                id: cartItem.id,
                              );
                              if (returnedType < 0) {
                                showRemoveDialog(context);
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          color: Colors.grey.shade400,
                                          offset: const Offset(1, 1))
                                    ]),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.remove,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  space10Vertical
                ],
              ),
            ),
          ),
        ],
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
