import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/cart_button.dart';
import 'package:medical_empire_app/core/util/widgets/compare_button.dart';
import 'package:medical_empire_app/core/util/widgets/wish_list_button.dart';
import 'package:medical_empire_app/features/product_details/presentation/page/product_details_page.dart';

class CategoryDataWidget extends StatelessWidget {
  final String title;
  String? bannerImage;
  final List<ProductModel> product;
  VoidCallback? seeMoreClicked;

  CategoryDataWidget({
    Key? key,
    required this.title,
    this.bannerImage,
    required this.product,
    this.seeMoreClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (seeMoreClicked != null)
                    AppTextButton(
                      label: appTranslation(context).see_all,
                      onPress: seeMoreClicked!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                ],
              ),
              if (seeMoreClicked == null) space15Vertical,
              SizedBox(
                height: 360.0,
                child: KeepAliveWidget(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        CategoryProductHorizontalItem(
                      products: product[index],
                    ),
                    separatorBuilder: (context, index) => space10Horizontal,
                    itemCount: product.length,
                  ),
                ),
              ),
              if (bannerImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    // height: 130.0,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage('$bannerImage'),
                      width: double.infinity,
                      // height: 130.0,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryProductHorizontalItem extends StatelessWidget {
  final ProductModel products;

  const CategoryProductHorizontalItem({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          ProductDetailsPage(
            slug: products.slug.ar,
          ),
        );
      },
      child: Container(
        width: 220.0,
        height: 360.0,
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
                        products.image,
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                          ar: products.name.ar,
                          en: products.name.en,
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
                            products.price,
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
                          if (products.oldPrice != null) space5Horizontal,
                          if (products.oldPrice != null)
                            Expanded(
                              child: Text(
                                products.oldPrice != null
                                    ? '${products.oldPrice} ${appTranslation(context).egp}'
                                    : '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: HexColor(mainColor),
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartButton(
                    product: products,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CompareButton(
                    id: products.id,
                  ),
                  space5Vertical,
                  WishListButton(
                    id: products.id,
                  ),
                ],
              ),
            ),
            if (products.oldPrice != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    child: Text(
                      appTranslation(context).sale +
                          " " +
                          getPercentageOfDiscount(
                              products.oldPrice!, products.price),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: HexColor(white),
                          ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      color: HexColor('da7339'),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String getPercentageOfDiscount(String oldPrice, String price) {
    num oldPriceNum = num.parse(oldPrice);
    num priceNum = num.parse(price);
    num result = (oldPriceNum - priceNum) / oldPriceNum;
    return dp(result.toDouble(), 2).toString() + "%";
  }

  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
