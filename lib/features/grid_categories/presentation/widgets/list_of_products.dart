import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/widgets/cart_button.dart';
import 'package:medical_empire_app/core/util/widgets/compare_button.dart';
import 'package:medical_empire_app/core/util/widgets/wish_list_button.dart';
import 'package:medical_empire_app/features/product_details/presentation/page/product_details_page.dart';

class ListOfProducts extends StatelessWidget {
  final ProductModel products;

  const ListOfProducts({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168.0,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            ProductDetailsPage(
              slug: products.slug.ar,
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
                          products.image,
                        ),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  if (products.oldPrice != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          child: Text(
                            appTranslation(context).sale,
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
                                  en: products.name.en,
                                  ar: products.name.ar,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                      // color: secondaryVariant,
                                      color: HexColor(blueGrey),
                                    ),
                              ),
                              space5Vertical,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${products.price} ${appTranslation(context).egp}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      Theme.of(context).textTheme.headline6!.copyWith(
                                        color: HexColor(mainColor),
                                      ),
                                    ),
                                  ),

                                  if(products.oldPrice != null)
                                    Expanded(
                                    child: Text(
                                      products.oldPrice != null
                                          ? '${products.oldPrice} ${appTranslation(context).egp}'
                                          : '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      Theme.of(context).textTheme.caption!.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor(mainColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // space5Vertical,
                              // CartButton(
                              //   product: products,
                              // ),
                            ],
                          ),
                        ),
                        space20Horizontal,
                        Column(
                          children: [
                            CompareButton(
                              id: products.id,
                            ),
                            space10Vertical,
                            WishListButton(
                              id: products.id,
                            ),
                          ],
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    space10Vertical,
                    SizedBox(
                      height: 48.0,
                      child: CartButton(
                        product: products,
                      ),
                    ),
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
