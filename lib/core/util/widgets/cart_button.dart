import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/one_option_dialog.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';

import '../../../features/product_details/presentation/page/product_details_page.dart';
import '../constants.dart';
import 'asset_svg.dart';

class CartButton extends StatefulWidget {
  final ProductModel product;

  const CartButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    MainCubit.get(context).cartMap.forEach((key, value) {
      key == widget.product.id ? count = value.quantity : null;
    });
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MainCubit.get(context).cartMap[widget.product.id] != null &&
                count != 0
            ? Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                height: 54.0,
                decoration: BoxDecoration(
                  // color: MainCubit.get(context).isDark
                  //     ? HexColor(secondBackground)
                  //     : HexColor(darkWhite),
                  borderRadius: BorderRadiusDirectional.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: MainCubit.get(context).isDark
                          ? HexColor(secondBackground)
                          : HexColor(darkWhite),
                      child: InkWell(
                        onTap: () {
                          if (count > 1) {
                            MainCubit.get(context).cartSubtraction(
                              id: widget.product.id,
                            );
                            setState(() {
                              count--;
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TwoOptionsDialog(
                                    pushButtonVoidCallback: () {
                                      removeFromCart(
                                        context: context,
                                        id: widget.product.id,
                                      );
                                      setState(() {
                                        count = 0;
                                      });
                                      Navigator.pop(context);
                                    },
                                    popButtonVoidCallback: () {
                                      Navigator.pop(context);
                                    },
                                    message: appTranslation(context)
                                        .are_you_sure_to_remove,
                                    // title: 'title',
                                    pushButtonText:
                                        appTranslation(context).remove,
                                    popButtonText:
                                        appTranslation(context).cancel,
                                  );
                                });
                          }
                          // MainCubit.get(context).cartSubtraction(
                          //   id: widget.product.id,
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: MainCubit.get(context).isDark
                            //     ? HexColor(secondBackground)
                            //     : HexColor(darkWhite),
                            borderRadius: BorderRadiusDirectional.circular(0.0),
                          ),
                          height: 54.0,
                          width: 54.0,
                          child: Icon(
                            FontAwesomeIcons.minus,
                            size: 16.0,
                            color: HexColor(mainColor),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: HexColor(mainColor),
                          ),
                    ),
                    Material(
                      color: MainCubit.get(context).isDark
                          ? HexColor(secondBackground)
                          : HexColor(darkWhite),
                      child: InkWell(
                        onTap: () async {
                          int? stockRestriction =
                              await MainCubit.get(context).cartAddition(
                            id: widget.product.id,
                          );
                          if (stockRestriction == null) {
                            setState(() {
                              count++;
                            });
                          } else {
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
                            borderRadius: BorderRadiusDirectional.circular(0.0),
                          ),
                          height: 54.0,
                          width: 54.0,
                          child: Icon(
                            FontAwesomeIcons.plus,
                            size: 16.0,
                            color: HexColor(mainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : MyButton(
                isEnabled: widget.product.quantityInStock != 0,
                voidCallback: () {
                  if (MainCubit.get(context).userSigned) {
                    if (MainCubit.get(context).cartMap[widget.product.id] !=
                        null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TwoOptionsDialog(
                              pushButtonVoidCallback: () {
                                removeFromCart(
                                  context: context,
                                  id: widget.product.id,
                                );
                                Navigator.pop(context);
                              },
                              popButtonVoidCallback: () {
                                Navigator.pop(context);
                              },
                              message: appTranslation(context)
                                  .are_you_sure_to_remove,
                              // title: 'title',
                              pushButtonText: appTranslation(context).remove,
                              popButtonText: appTranslation(context).cancel,
                            );
                          });
                    } else {
                      //todo: add to cart
                      // addToCart(
                      //   context: context,
                      //   productModel: widget.product,
                      // );

                      if (MainCubit.get(context).userSigned) {
                        if (widget.product.color_attributes == null &&
                            widget.product.size_attributes == null) {
                          print('no color or size');
                          addToCart(
                            context: context,
                            productModel: widget.product,
                          );
                        } else if (widget.product.color_attributes != null &&
                            widget.product.size_attributes == null) {
                          if (MainCubit.get(context).currentColor < 0) {
                            navigateToProductDetailsScreen(context);
                            showToast(
                                message:
                                    appTranslation(context).pleaseSelectColor,
                                toastStates: ToastStates.WARNING);
                          } else {
                            print('yes color no size');
                            addToCart(
                              context: context,
                              productModel: widget.product,
                            );
                          }
                        } else if (widget.product.color_attributes == null &&
                            widget.product.size_attributes != null) {
                          if (MainCubit.get(context).currentSize < 0) {
                            navigateToProductDetailsScreen(context);
                            showToast(
                                message:
                                    appTranslation(context).pleaseSelectSize,
                                toastStates: ToastStates.WARNING);
                          } else {
                            print('no color yes size');
                            addToCart(
                              context: context,
                              productModel: widget.product,
                            );
                          }
                        } else {
                          if (MainCubit.get(context).currentSize < 0) {
                            navigateToProductDetailsScreen(context);
                            showToast(
                                message:
                                    appTranslation(context).pleaseSelectSize,
                                toastStates: ToastStates.WARNING);
                          } else if (MainCubit.get(context).currentColor < 0) {
                            navigateToProductDetailsScreen(context);
                            showToast(
                                message:
                                    appTranslation(context).pleaseSelectColor,
                                toastStates: ToastStates.WARNING);
                          } else {
                            print('yes color yes size');
                            addToCart(
                              context: context,
                              productModel: widget.product,
                            );
                          }
                        }
                      } else {
                        showToast(
                            toastStates: ToastStates.WARNING,
                            message: appTranslation(context)
                                .please_login_to_add_or_remove_from_cart);
                        navigateTo(context, LoginPage());
                      }

                      setState(() {
                        count++;
                      });
                    }
                  } else {
                    showToast(
                        toastStates: ToastStates.WARNING,
                        message: appTranslation(context)
                            .please_login_to_add_or_remove_from_cart);
                    navigateTo(context, LoginPage());
                  }
                },
                text: widget.product.quantityInStock == 0
                    ? appTranslation(context).out_of_stock
                    : MainCubit.get(context).cartMap[widget.product.id] != null
                        ? appTranslation(context).remove_from_cart
                        : appTranslation(context).addToCart,
                color: widget.product.quantityInStock == 0
                    ? HexColor(grey)
                    : MainCubit.get(context).cartMap[widget.product.id] != null
                        ? HexColor(red)
                        : HexColor(mainColor),
                radius: 30,
                iconBehindText: AssetSvg(
                  imagePath: 'add_cart',
                  color: Colors.white,
                ),
              );
      },
    );
  }

  void navigateToProductDetailsScreen(BuildContext context) {
    navigateTo(
      context,
      ProductDetailsPage(
        slug: widget.product.slug.en,
      ),
    );
  }
}
