import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/setting_item.dart';
import 'package:medical_empire_app/features/used_product_details/presentation/page/used_info_product_page.dart';
import 'package:medical_empire_app/features/used_product_details/presentation/widget/slider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'used_description_page.dart';

class UsedProductDetailsPage extends StatefulWidget {
  final int id;

  const UsedProductDetailsPage({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  State<UsedProductDetailsPage> createState() => _UsedProductDetailsPageState();
}

class _UsedProductDetailsPageState extends State<UsedProductDetailsPage> {
  @override
  void initState() {
    super.initState();

    MainCubit.get(context).getUsedProduct(productId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              MainCubit.get(context).usedProductFeedModel != null,
          widgetBuilder: (context) => Scaffold(
            body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent),
                    leading: Padding(
                      padding: const EdgeInsetsDirectional.all(12.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor:MainCubit.get(context).isDark? Theme.of(context).scaffoldBackgroundColor :  HexColor(white),
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
                    backgroundColor:MainCubit.get(context).isDark? Theme.of(context).scaffoldBackgroundColor : HexColor(white),
                    expandedHeight: 360.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SliderUsedProductDetails(
                        model: MainCubit.get(context)
                            .usedProductFeedModel!
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
                              MainCubit.get(context)
                                  .usedProductFeedModel!
                                  .product
                                  .name
                                  .en,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            // space5Vertical,
                            // Row(
                            //   children: [
                            //     RatingBar.builder(
                            //       allowHalfRating: true,
                            //       ignoreGestures: true,
                            //       initialRating: 4.5,
                            //       minRating: 1,
                            //       itemSize: 16.0,
                            //       direction: Axis.horizontal,
                            //       itemCount: 5,
                            //       itemBuilder: (context, _) =>  Icon(
                            //         Icons.star,
                            //         color: HexColor(secondColor),
                            //       ),
                            //       onRatingUpdate: (rating) {
                            //         // print(rating);
                            //       },
                            //     ),
                            //     space4Horizontal,
                            //     Text(
                            //       '(4)',
                            //       style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            //           color: secondaryVariant
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // space5Vertical,
                            // Text(
                            //   'SHIRTS',
                            //   style: Theme.of(context).textTheme.caption!.copyWith(
                            //     color: HexColor(thirdColor),
                            //   ),
                            // ),
                            space20Vertical,

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'EGP ${MainCubit.get(context).usedProductFeedModel!.product.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await launch(
                                        "tel://${MainCubit.get(context).usedProductFeedModel!.product.phone}");
                                  },
                                  child: Row(
                                    children: [
                                      AssetSvg(
                                        imagePath: 'phone_call',
                                        color: HexColor(grey),
                                        size: 18.0,
                                      ),
                                      // const Image(
                                      //   image: AssetImage(
                                      //     'assets/images/call.png',
                                      //   ),
                                      // ),
                                      space5Horizontal,
                                      Text(
                                        MainCubit.get(context)
                                            .usedProductFeedModel!
                                            .product
                                            .phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: HexColor(green),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            space20Vertical,
                            //   Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Expanded(
                            //         child: Text(
                            //           'Size',
                            //           style:
                            //               Theme.of(context).textTheme.caption,
                            //         ),
                            //       ),
                            //     SizedBox(
                            //       height: 24.0,
                            //       child: AppTextButton(
                            //         label: 'Clear all',
                            //         onPress: () {
                            //           MainCubit.get(context).selectSize(-1);
                            //           MainCubit.get(context).selectColor(-1);
                            //           MainCubit.get(context).itemCount = 1;
                            //         },
                            //         buttonStyle: TextButton.styleFrom(
                            //             padding: EdgeInsets.zero,
                            //             minimumSize: const Size(50, 30),
                            //             alignment: Alignment.centerRight),
                            //         style: Theme.of(context).textTheme.caption,
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            //TODO : SIZE and COLOR
                            /*
                               SizedBox(
                              height: 24.0,
                              child: AppTextButton(
                                label: 'Clear all',
                                onPress: () {
                                  MainCubit.get(context).clearVariations();
                                },
                                buttonStyle: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    alignment: Alignment.centerRight),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            if (MainCubit.get(context).productFeedModel!.data.product.size_attributes != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  space10Vertical,
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
                                ],
                              ),
                            if (MainCubit.get(context).productFeedModel!.data.product.color_attributes != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Color',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  space10Vertical,
                                  SizedBox(
                                    height: 30,
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
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
                               */

                            // SizedBox(
                            //   height: 46.0,
                            //   child: MyButton(
                            //     voidCallback: () {},
                            //     text: 'Add to cart',
                            //     color: HexColor(mainColor),
                            //   ),
                            // ),
                            //

                            SettingsItem(
                              title: 'Description',
                              function: () {
                                navigateTo(
                                    context, const DescriptionUsedPage());
                              },
                              icon: FontAwesomeIcons.phoneAlt,
                              showIcon: false,
                              paddingHorizontal: 0.0,
                            ),
                            SettingsItem(
                              title: 'Addition Information',
                              function: () {
                                navigateTo(context, const UsedInfoProduct());
                              },
                              icon: FontAwesomeIcons.phoneAlt,
                              showIcon: false,
                              paddingHorizontal: 0.0,
                            ),
                            space30Vertical,

                            // Container(
                            //   height: 160.0,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //     border: Border.all(color:HexColor(grey),),
                            //   ),
                            //   child: Column(
                            //     children: [
                            //       const BrandListItem(),
                            //       Divider(
                            //         color:HexColor(grey),
                            //       ),
                            //       const BrandListItem(),
                            //       Divider(
                            //         color:HexColor(grey),
                            //       ),
                            //       const BrandListItem(),
                            //     ],
                            //   ),
                            // ),
                            // space30Vertical,

                            space20Vertical,
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          fallbackBuilder: (context) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
