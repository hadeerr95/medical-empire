import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/compares_model.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';
import 'package:medical_empire_app/features/info_product/presentation/widget/list_item_color.dart';
import 'package:medical_empire_app/features/info_product/presentation/widget/list_item_size.dart';
import 'package:medical_empire_app/features/product_details/presentation/page/product_details_page.dart';

class ComparisonsDetailsItem extends StatelessWidget {
  final ComparesDetailsModel model;
  const ComparisonsDetailsItem({
    Key? key,
    required this.model
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: HexColor(grey),),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      appTranslation(context).product_details,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color:MainCubit.get(context).isDark? HexColor(surface): HexColor(black),
                      ),
                    ),
                    const Spacer(),
                    AppTextButton(
                      label: appTranslation(context).view,
                      onPress: (){
                        navigateTo(
                          context,
                          ProductDetailsPage(
                            slug: model.product.slug.en,
                          ),
                        );
                      },
                      style: Theme.of(context).textTheme.subtitle1!,
                      buttonStyle: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ),
                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:HexColor(white),
                    borderRadius: BorderRadius.circular(8.0),
                    image:   DecorationImage(
                      image: NetworkImage(
                        model.product.image,
                      ),
                    ),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  displayTranslatedText(context: context, ar: model.product.name.ar, en: model.product.name.en),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: MainCubit.get(context).isDark? HexColor(surface): secondaryVariant,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${appTranslation(context).egp} ${model.product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Builder(builder: (context) {
                      if (model.product.quantityInStock == 0) {
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
                        '${model.product.quantityInStock} ${appTranslation(context).in_stock}',
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
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).country,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        model.product.countryOrigin,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: HexColor(grey),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).brand,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        displayTranslatedText(context: context, ar: model.product.brand.name.ar, en: model.product.brand.name.en),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: HexColor(grey),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).rating,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            tapOnlyMode: true,
                            updateOnDrag: false,
                            initialRating:model.product.reviews != null ? 0 : 0,
                            minRating: 0,
                            itemSize: 12.0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: HexColor(secondColor),
                            ),
                            onRatingUpdate: (rating) {
                              // print(rating);
                            },
                          ),
                          space3Horizontal,
                          Text(
                            model.product.reviews != null? '(0)' :'' ,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).description,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child:  Text(
                        displayTranslatedText(context: context, ar: model.product.short_desc.ar, en: model.product.short_desc.en,),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: HexColor(grey),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).size,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Builder(
                        builder: (context) {
                          if(model.product.size_attributes != null){
                            return Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 20.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => ListItemSize(model : model.product.size_attributes![index]),
                                  separatorBuilder: (context, index) => space5Horizontal,
                                  itemCount: model.product.size_attributes!.length,
                                ),
                              ),
                            );
                          }else{
                            return Expanded(
                              flex: 2,
                              child: Text(
                                appTranslation(context).no_information_available,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: HexColor(grey),
                                ),
                              ),
                            );
                          }

                        }
                    ),
                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).color,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Builder(
                        builder: (context) {
                          if (model.product.color_attributes != null) {
                            return Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 30.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ListItemColor(model : model.product.color_attributes![index]),
                                separatorBuilder: (context, index) => space5Horizontal,
                                itemCount: model.product.color_attributes!.length,
                              ),
                            ),
                          );
                          }else{
                            return Expanded(
                              flex: 2,
                              child: Text(
                                appTranslation(context).no_information_available,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: HexColor(grey),
                                ),
                              ),
                            );
                          }
                        }
                    ),
                  ],
                ),
              ),
              myDivider(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appTranslation(context).weight,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        model.product.weight ?? appTranslation(context).no_information_available,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: HexColor(grey),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              myDivider(context),
              if (MainCubit.get(context).cartMap[model.product.id] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 38.0,
                  child: MyButton(
                    voidCallback: (){
                      showDialog(
                          context: context,
                          builder:
                              (BuildContext context) {
                            return TwoOptionsDialog(
                              pushButtonVoidCallback:
                                  () {
                                removeFromCart(
                                  context: context,
                                  id: model.product.id,
                                );
                                Navigator.pop(context);
                              },
                              popButtonVoidCallback:
                                  () {
                                Navigator.pop(context);
                              },
                              message:
                              appTranslation(context).are_you_sure_to_remove,
                              // title: 'title',
                              pushButtonText: appTranslation(context).remove,
                              popButtonText: appTranslation(context).cancel,
                            );
                          });
                    },
                    text: appTranslation(context).remove_from_cart,
                    color: HexColor(red),
                    radius: 8.0,
                  ),
                ),
              ),
              if (MainCubit.get(context).cartMap[model.product.id] == null)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 38.0,
                  child: MyButton(
                    voidCallback: (){
                      addToCart(
                        context: context,
                        productModel: model.product,
                      );
                    },
                    text: appTranslation(context).addToCart,
                    color: HexColor(mainColor),
                    radius: 8.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0 , bottom: 8.0),
                child: SizedBox(
                  height: 38.0,
                  child: MyButton(
                    voidCallback: (){
                      showDialog(
                          context: context,
                          builder:
                              (BuildContext context) {
                            return TwoOptionsDialog(
                              pushButtonVoidCallback: () {
                                    MainCubit.get(context).removeFromCompares(compareId: model.id);
                                    Navigator.pop(context);
                              },
                              popButtonVoidCallback: () {
                                Navigator.pop(context);
                              },
                              message:
                              appTranslation(context).are_you_sure_to_remove,
                              // title: 'title',
                              pushButtonText: appTranslation(context).remove,
                              popButtonText: appTranslation(context).cancel,
                            );
                          });
                    },
                    text: appTranslation(context).delete,
                    color: HexColor(red),
                    radius: 8.0,
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
