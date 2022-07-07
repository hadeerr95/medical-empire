import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/main_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/setting_item.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';
import 'package:medical_empire_app/features/description/presentation/page/description_page.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/category_data.dart';
import 'package:medical_empire_app/features/info_product/presentation/page/info_product_page.dart';
import 'package:medical_empire_app/features/internet_connection/page/internet_connection_page.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';
import 'package:medical_empire_app/features/product_details/presentation/widget/colors_list_item.dart';
import 'package:medical_empire_app/features/product_details/presentation/widget/size_list_item.dart';
import 'package:medical_empire_app/features/product_details/presentation/widget/slider.dart';
import 'package:medical_empire_app/features/review/presentation/page/add_review_page.dart';
import 'package:medical_empire_app/features/review/presentation/page/review_page.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsPage extends StatefulWidget {
  final String slug;

  const ProductDetailsPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  BehaviorSubject<bool?> refresh = BehaviorSubject();

  @override
  void initState() {
    super.initState();
    refresh.sink.add(false);
    MainCubit.get(context).getProductFeed(
      slug: widget.slug,
    );
  }

  @override
  void dispose() {
    super.dispose();
    refresh.stream.drain();
    refresh.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if (state is AddComparesSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
        if (state is SelectColor) {
          refresh.sink.add(true);
        }
      },
      builder: (BuildContext context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              !MainCubit.get(context).noInternetConnection,
          widgetBuilder: (context) => Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                MainCubit.get(context).productFeedModel != null,
            widgetBuilder: (context) => MainScaffold(
              scaffold: Scaffold(
                body: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        systemOverlayStyle: const SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent
                            // statusBarIconBrightness: Brightness.light,
                            ),
                        leading: Padding(
                          padding: const EdgeInsetsDirectional.all(12.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: MainCubit.get(context).isDark
                                ? Theme.of(context).scaffoldBackgroundColor
                                : HexColor(white),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 16.0,
                                color: HexColor(grey),
                              ),
                            ),
                          ),
                        ),
                        pinned: true,
                        floating: true,
                        titleSpacing: 2.0,
                        actions: [
                          Padding(
                            padding: const EdgeInsetsDirectional.all(12.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: MainCubit.get(context).isDark
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : HexColor(white),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 8.0,
                                    backgroundColor: HexColor(red),
                                    child: Text(
                                      MainCubit.get(context).cartMap.length > 9
                                          ? '+9'
                                          : MainCubit.get(context)
                                              .cartMap
                                              .length
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: HexColor(white),
                                          ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      MainCubit.get(context).bottomChanged(2);
                                    },
                                    icon: AssetSvg(
                                      color: HexColor(grey),
                                      imagePath: 'cart',
                                      size: 16.0,
                                    ),
                                    // Icon(
                                    //   FontAwesomeIcons.shoppingCart,
                                    //   size: 16.0,
                                    //   color: HexColor(black),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        backgroundColor: MainCubit.get(context).isDark
                            ? Theme.of(context).scaffoldBackgroundColor
                            : HexColor(white),
                        expandedHeight: 360.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: SliderProductDetails(
                            model: MainCubit.get(context)
                                .productFeedModel!
                                .data
                                .product,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Scrollbar(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  MainCubit.get(context).isRtl
                                      ? MainCubit.get(context)
                                          .productFeedModel!
                                          .data
                                          .product
                                          .name
                                          .ar
                                      : MainCubit.get(context)
                                          .productFeedModel!
                                          .data
                                          .product
                                          .name
                                          .en,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                space20Vertical,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${appTranslation(context).egp} ${MainCubit.get(context).productFeedModel!.data.product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ),
                                    Builder(builder: (context) {
                                      if (MainCubit.get(context)
                                              .productFeedModel!
                                              .data
                                              .product
                                              .quantityInStock ==
                                          0) {
                                        return Text(
                                          appTranslation(context).out_of_stock,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: HexColor(red),
                                              ),
                                        );
                                      }
                                      return Text(
                                        '${MainCubit.get(context).productFeedModel!.data.product.quantityInStock} ${appTranslation(context).in_stock}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: HexColor(green),
                                            ),
                                      );
                                    }),
                                  ],
                                ),
                                space20Vertical,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (MainCubit.get(context)
                                            .productFeedModel!
                                            .data
                                            .product
                                            .size_attributes !=
                                        null)
                                      Expanded(
                                        child: Text(
                                          appTranslation(context).size,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    if (MainCubit.get(context)
                                                .productFeedModel!
                                                .data
                                                .product
                                                .size_attributes !=
                                            null &&
                                        MainCubit.get(context)
                                                .productFeedModel!
                                                .data
                                                .product
                                                .color_attributes !=
                                            null)
                                      SizedBox(
                                        height: 24.0,
                                        child: AppTextButton(
                                          label:
                                              appTranslation(context).clear_all,
                                          onPress: () {
                                            MainCubit.get(context)
                                                .clearVariations();
                                          },
                                          buttonStyle: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(50, 30),
                                              alignment: Alignment.centerRight),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                  ],
                                ),
                                if (MainCubit.get(context)
                                        .productFeedModel!
                                        .data
                                        .product
                                        .size_attributes !=
                                    null)
                                  space10Vertical,
                                if (MainCubit.get(context)
                                        .productFeedModel!
                                        .data
                                        .product
                                        .size_attributes !=
                                    null)
                                  SizedBox(
                                    height: 30,
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          SizeListItem(
                                              model: MainCubit.get(context)
                                                  .productFeedModel!
                                                  .data
                                                  .product
                                                  .size_attributes![index],
                                              index: index),
                                      separatorBuilder: (context, index) =>
                                          space10Horizontal,
                                      itemCount: MainCubit.get(context)
                                          .productFeedModel!
                                          .data
                                          .product
                                          .size_attributes!
                                          .length,
                                    ),
                                  ),
                                space20Vertical,
                                if (MainCubit.get(context)
                                        .productFeedModel!
                                        .data
                                        .product
                                        .color_attributes !=
                                    null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appTranslation(context).color,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      space10Vertical,
                                      SizedBox(
                                        height: 30,
                                        child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              ColorsListItem(
                                                  model: MainCubit.get(context)
                                                      .productFeedModel!
                                                      .data
                                                      .product
                                                      .color_attributes![index],
                                                  index: index),
                                          separatorBuilder: (context, index) =>
                                              space10Horizontal,
                                          itemCount: MainCubit.get(context)
                                              .productFeedModel!
                                              .data
                                              .product
                                              .color_attributes!
                                              .length,
                                        ),
                                      ),
                                      space20Vertical,
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MainCubit.get(context).isDark
                                            ? HexColor(secondBackground)
                                            : HexColor(darkWhite),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                8.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: MainCubit.get(context)
                                                        .productFeedModel!
                                                        .data
                                                        .product
                                                        .quantityInStock !=
                                                    0
                                                ? () {
                                                    subtractItem(context);
                                                  }
                                                : null,
                                            icon: Icon(
                                              FontAwesomeIcons.minus,
                                              size: 16.0,
                                              color: HexColor(mainColor),
                                            ),
                                          ),
                                          Text(
                                            MainCubit.get(context).cartMap[
                                                        MainCubit.get(context)
                                                            .productFeedModel!
                                                            .data
                                                            .product
                                                            .id] !=
                                                    null
                                                ? MainCubit.get(context)
                                                        .cartMap[MainCubit.get(
                                                                context)
                                                            .productFeedModel!
                                                            .data
                                                            .product
                                                            .id]
                                                        ?.quantity
                                                        .toString() ??
                                                    ""
                                                : MainCubit.get(context)
                                                            .productFeedModel!
                                                            .data
                                                            .product
                                                            .quantityInStock ==
                                                        0
                                                    ? '0'
                                                    : '${MainCubit.get(context).itemCount}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  color: HexColor(mainColor),
                                                ),
                                          ),
                                          IconButton(
                                            onPressed: MainCubit.get(context)
                                                        .productFeedModel!
                                                        .data
                                                        .product
                                                        .quantityInStock !=
                                                    0
                                                ? () {
                                                    addItem(context);
                                                  }
                                                : null,
                                            icon: Icon(
                                              FontAwesomeIcons.plus,
                                              size: 16.0,
                                              color: HexColor(mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    space10Horizontal,
                                    StreamBuilder<bool?>(
                                        stream: refresh,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (checkIfProductInCartWithSpecifications(
                                                context)) {
                                              return removeFromCartButton(
                                                  context);
                                            } else {
                                              return addToCartButton(context);
                                            }
                                          }
                                          return addToCartButton(context);
                                        }),
                                    /*                  if (MainCubit.get(context).cartMap[
                                            MainCubit.get(context)
                                                .productFeedModel!
                                                .data
                                                .product
                                                .id] ==
                                        null)
                                      addToCartButton(context),*/
                                  ],
                                ),
                                space10Vertical,
                                SettingsItem(
                                  title: appTranslation(context).description,
                                  function: () {
                                    navigateTo(
                                        context, const DescriptionPage());
                                  },
                                  icon: FontAwesomeIcons.phoneAlt,
                                  showIcon: false,
                                  paddingHorizontal: 0.0,
                                ),
                                SettingsItem(
                                  title: appTranslation(context)
                                      .addition_information,
                                  function: () {
                                    navigateTo(context, const InfoProduct());
                                  },
                                  icon: FontAwesomeIcons.phoneAlt,
                                  showIcon: false,
                                  paddingHorizontal: 0.0,
                                ),
                                SettingsItem(
                                  title: appTranslation(context).reviews,
                                  function: () {
                                    if (MainCubit.get(context)
                                            .productFeedModel!
                                            .data
                                            .product
                                            .reviews !=
                                        null) {
                                      navigateTo(context, const ReviewPage());
                                    } else {
                                      navigateTo(context, AddReviewPage());
                                    }
                                  },
                                  icon: FontAwesomeIcons.phoneAlt,
                                  showIcon: false,
                                  paddingHorizontal: 0.0,
                                ),
                                space30Vertical,
                                Text(
                                  appTranslation(context).related_product,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                space20Vertical,
                                SizedBox(
                                  height: 360.0,
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        CategoryProductHorizontalItem(
                                      products: MainCubit.get(context)
                                          .productFeedModel!
                                          .data
                                          .related_products[index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        space10Horizontal,
                                    itemCount: MainCubit.get(context)
                                        .productFeedModel!
                                        .data
                                        .related_products
                                        .length,
                                  ),
                                ),
                                space20Vertical,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            fallbackBuilder: (context) => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          fallbackBuilder: (context) => const InternetConnectionPage(),
        );
      },
    );
  }

  bool checkIfProductInCartWithSpecifications(BuildContext context) {
    var productFoundOrNot = MainCubit.get(context).cartMap[
            MainCubit.get(context).productFeedModel!.data.product.id] !=
        null;
    if (productFoundOrNot) {
      var product = MainCubit.get(context)
          .cartMap[MainCubit.get(context).productFeedModel!.data.product.id];
      if (product?.color != null &&
          product?.color?.en == MainCubit.get(context).selectedColor?.en &&
          product?.color?.ar == MainCubit.get(context).selectedColor?.ar) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  void subtractItem(BuildContext context) {
    if (MainCubit.get(context).cartMap[
            MainCubit.get(context).productFeedModel!.data.product.id] !=
        null) {
      MainCubit.get(context).cartSubtraction(
          id: MainCubit.get(context)
                  .cartMap[
                      MainCubit.get(context).productFeedModel!.data.product.id]
                  ?.id ??
              0);
    } else {
      MainCubit.get(context).subtraction();
    }
  }

  void addItem(BuildContext context) {
    if (MainCubit.get(context).cartMap[
            MainCubit.get(context).productFeedModel!.data.product.id] !=
        null) {
      MainCubit.get(context).cartAddition(
          id: MainCubit.get(context)
                  .cartMap[
                      MainCubit.get(context).productFeedModel!.data.product.id]
                  ?.id ??
              0);
    } else {
      MainCubit.get(context).addition();
    }
  }

  Expanded addToCartButton(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 46.0,
        child: MyButton(
          isEnabled: MainCubit.get(context)
                  .productFeedModel!
                  .data
                  .product
                  .quantityInStock !=
              0,
          voidCallback: () {
            if (MainCubit.get(context).userSigned) {
              if (MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .color_attributes ==
                      null &&
                  MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .size_attributes ==
                      null) {
                addToCart(
                  context: context,
                  productModel:
                      MainCubit.get(context).productFeedModel!.data.product,
                );
              } else if (MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .color_attributes !=
                      null &&
                  MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .size_attributes ==
                      null) {
                if (MainCubit.get(context).currentColor < 0) {
                  showToast(
                      message: appTranslation(context).pleaseSelectColor,
                      toastStates: ToastStates.WARNING);
                } else {
                  addToCart(
                    context: context,
                    productModel:
                        MainCubit.get(context).productFeedModel!.data.product,
                  );
                }
              } else if (MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .color_attributes ==
                      null &&
                  MainCubit.get(context)
                          .productFeedModel!
                          .data
                          .product
                          .size_attributes !=
                      null) {
                if (MainCubit.get(context).currentSize < 0) {
                  showToast(
                      message: appTranslation(context).pleaseSelectSize,
                      toastStates: ToastStates.WARNING);
                } else {
                  addToCart(
                    context: context,
                    productModel:
                        MainCubit.get(context).productFeedModel!.data.product,
                  );
                }
              } else {
                if (MainCubit.get(context).currentSize < 0) {
                  showToast(
                      message: 'please select Size',
                      toastStates: ToastStates.WARNING);
                } else if (MainCubit.get(context).currentColor < 0) {
                  showToast(
                      message: 'please select Color',
                      toastStates: ToastStates.WARNING);
                } else {
                  addToCart(
                    context: context,
                    productModel:
                        MainCubit.get(context).productFeedModel!.data.product,
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
          },
          text: MainCubit.get(context)
                      .productFeedModel!
                      .data
                      .product
                      .quantityInStock ==
                  0
              ? appTranslation(context).out_of_stock
              : appTranslation(context).addToCart,
          color: MainCubit.get(context)
                      .productFeedModel!
                      .data
                      .product
                      .quantityInStock ==
                  0
              ? HexColor(grey)
              : HexColor(mainColor),
          radius: 30,
          iconBehindText: AssetSvg(
            imagePath: 'add_cart',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Expanded removeFromCartButton(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 46.0,
        child: MyButton(
          voidCallback: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TwoOptionsDialog(
                    pushButtonVoidCallback: () {
                      removeFromCart(
                        context: context,
                        id: MainCubit.get(context)
                            .productFeedModel!
                            .data
                            .product
                            .id,
                      );
                      Navigator.pop(context);
                    },
                    popButtonVoidCallback: () {
                      Navigator.pop(context);
                    },
                    message: appTranslation(context).are_you_sure_to_remove,
                    // title: 'title',
                    pushButtonText: appTranslation(context).remove,
                    popButtonText: appTranslation(context).cancel,
                  );
                });
          },
          text: appTranslation(context).remove_from_cart,
          color: HexColor(red),
        ),
      ),
    );
  }
}
