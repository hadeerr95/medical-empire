import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/core/util/widgets/empty_widget.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/checkout/presentation/pages/checkout_page.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';
import 'package:medical_empire_app/features/main/presentation/widgets/single_cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is AddComparesSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }

        if (state is ApplyCouponSuccess) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        MainCubit.get(context).getCouponModelIfExist();
        return KeepAliveWidget(
          child: BuildCondition(
            condition: MainCubit.get(context).userSigned,
            builder: (context) => BuildCondition(
              condition: MainCubit.get(context).cartMap.isNotEmpty,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...MainCubit.get(context)
                        .cartMap
                        .map(
                          (key, value) => MapEntry(
                            key,
                            Column(
                              children: [
                                SingleCartItem(
                                  cartItem: value,
                                ),
                                myDivider(context),
                              ],
                            ),
                          ),
                        )
                        .values
                        .toList(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appTranslation(context).coupon,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          space20Vertical,
                          Form(
                            key: formKey,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return appTranslation(context).couponEmpty;
                                }
                              },
                              controller: MainCubit.get(context)
                                  .couponEditingController,
                              decoration: InputDecoration(
                                suffixIcon: state is! ApplyCouponLoading
                                    ? MaterialButton(
                                        height: 60.0,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (MainCubit.get(context)
                                                    .couponsModel ==
                                                null) {
                                              MainCubit.get(context)
                                                  .applyCoupon(
                                                coupon: MainCubit.get(context)
                                                    .couponEditingController
                                                    .text,
                                              );
                                            } else {
                                              showToast(
                                                message: appTranslation(context)
                                                    .couponSentBefore,
                                                toastStates: ToastStates.ERROR,
                                              );
                                            }
                                          }
                                        },
                                        child: Text(
                                          appTranslation(context).apply,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      )
                                    : const CupertinoActivityIndicator(),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor(grey),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor(grey),
                                  ),
                                ),
                                hintText:
                                    appTranslation(context).enter_coupon_code,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: HexColor(grey),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                appTranslation(context).subtotal,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '${appTranslation(context).egp} ${MainCubit.get(context).subtotalCart}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: HexColor(secondaryVariantDark),
                                    ),
                              ),
                            ],
                          ),
                          if (MainCubit.get(context).couponsModel != null &&
                              MainCubit.get(context).couponsModel!.data != null)
                            space10Vertical,
                          if (MainCubit.get(context).couponsModel != null &&
                              MainCubit.get(context).couponsModel!.data != null)
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).coupon,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: secondaryVariant,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '- ${MainCubit.get(context).couponsModel!.data!.coupon.amount}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: HexColor(red),
                                      ),
                                ),
                              ],
                            ),
                          if (MainCubit.get(context).couponsModel != null &&
                              MainCubit.get(context).couponsModel!.data != null)
                            space10Vertical,
                          if (MainCubit.get(context).couponsModel != null &&
                              MainCubit.get(context).couponsModel!.data != null)
                            Row(
                              children: [
                                Text(
                                  appTranslation(context).total,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '${appTranslation(context).egp} ${MainCubit.get(context).firstTotalCart}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: HexColor(mainColor),
                                      ),
                                ),
                              ],
                            ),
                          space20Vertical,
                          MyButton(
                            voidCallback: () {
                              if (MainCubit.get(context).userSigned) {
                                navigateTo(context, const CheckoutPage());
                              } else {
                                navigateTo(context, LoginPage());
                                showToast(
                                    message: appTranslation(context).signFirst,
                                    toastStates: ToastStates.SUCCESS);
                              }
                            },
                            text: appTranslation(context).proceedCheckout,
                            color: HexColor(mainColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => EmptyWidget(
                  text: appTranslation(context).add_some_products_to_cart),
            ),
            fallback: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 50.0,
                  color: HexColor(mainColor),
                ),
                space20Vertical,
                Text(
                  'Please login to add or remove from cart',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                space20Vertical,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100.0,
                  ),
                  child: MyButton(
                    voidCallback: () {
                      navigateTo(context, LoginPage());
                    },
                    text: 'Sign in',
                    color: HexColor(mainColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Widget buildNewCartItem(context) =>
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10.0),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   10.0,
//                 ),
//                 color: HexColor(productBackground),
//               ),
//               width: 120.0,
//               height: 140.0,
//               child: const Image(
//                 image: NetworkImage(
//                     'https://cf1.s3.souqcdn.com/item/2021/01/11/13/22/62/65/9/item_XXL_132262659_97d72db42e5dd.jpg'),
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15.0,
//                   vertical: 10.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Samsung Galaxy S21 Dual SIM Mobile - 6.2 inches, 128  GB, 8 GB RAM, 5G - Violet with Samsung Wireless Power Bank, 10000 mAh and Samsung Fit 2 Watch',
//                       style: Theme
//                           .of(context)
//                           .textTheme
//                           .subtitle2,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'EGP 21,000.00',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .subtitle1,
//                             ),
//                             const SizedBox(
//                               height: 5.0,
//                             ),
//                             Text(
//                               'EGP 23,000.00',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .caption!
//                                   .copyWith(
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15.0,
//                           ),
//                           height: 40.0,
//                           decoration: BoxDecoration(
//                             color: HexColor(surface),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: Row(
//                             children: [
//                               InkWell(
//                                 onTap: () {},
//                                 child: Text(
//                                   '-',
//                                   style: Theme
//                                       .of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                     color: HexColor(mainColor),
//                                   ),
//                                 ),
//                               ),
//                               space20Horizontal,
//                               Text(
//                                 '1',
//                                 style: Theme
//                                     .of(context)
//                                     .textTheme
//                                     .headline6!
//                                     .copyWith(
//                                   color: HexColor(mainColor),
//                                 ),
//                               ),
//                               space20Horizontal,
//                               InkWell(
//                                 onTap: () {},
//                                 child: Text(
//                                   '+',
//                                   style: Theme
//                                       .of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                     color: HexColor(mainColor),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       padding: EdgeInsets.zero,
//                       icon: Icon(
//                         Icons.delete_outline,
//                         size: 16.0,
//                         color: HexColor(mainColor),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );

// Widget buildCartItem(context, index) => Row(
//       children: [
//         if (AppCubit.get(context).isCartEditable)
//           Checkbox(
//             value: AppCubit.get(context).isCartChecked[index],
//             onChanged: (value) {
//               AppCubit.get(context).changeCartChecked(index);
//             },
//           ),
//         Expanded(
//           child: Card(
//             elevation: 2.0,
//             margin: EdgeInsetsDirectional.only(
//               start: 8.0,
//               end: 8.0,
//               bottom: 8.0,
//             ),
//             child: Container(
//               height: 128.0,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.only(
//                       start: 0.0,
//                     ),
//                     child: Image(
//                       image: NetworkImage(
//                           'https://cf5.s3.souqcdn.com/item/2021/03/01/13/24/40/77/8/item_XXL_132440778_5c42a1857abff.jpg'),
//                       width: 100.0,
//                       height: 110.0,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {},
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 15.0,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(
//                               'Spicy Seasoning Indian Chicken - 90 gm',
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Text(
//                               '21.50 EGP',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .subtitle1!
//                                   .copyWith(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             Text(
//                               '25.50 EGP',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .caption!
//                                   .copyWith(
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '',
//                                   style:
//                                       Theme.of(context).textTheme.subtitle2,
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.remove_circle_outline,
//                                     size: 18.0,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .secondary,
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                                 Text(
//                                   '1',
//                                   style:
//                                       Theme.of(context).textTheme.subtitle1,
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.add_circle_outline,
//                                     size: 18.0,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .secondary,
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
}
