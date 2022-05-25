import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/info_product/presentation/widget/list_item_category.dart';
import 'package:medical_empire_app/features/info_product/presentation/widget/list_item_color.dart';
import 'package:medical_empire_app/features/info_product/presentation/widget/list_item_size.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return  BackScaffold(
          title: appTranslation(context).addition_information,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [

                if(MainCubit.get(context).productFeedModel!.data.product.categories != null)
                  Column(
                    children: [
                      myDivider(context),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                appTranslation(context).category,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 30.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => ListItemCategory(model :MainCubit.get(context).productFeedModel!.data.product.categories[index]),
                                  separatorBuilder: (context, index) => space5Horizontal,
                                  itemCount: MainCubit.get(context).productFeedModel!.data.product.categories.length,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      myDivider(context),
                    ],
                  ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          appTranslation(context).brand,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          MainCubit.get(context).productFeedModel!.data.product.brand.name.en,
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
                          appTranslation(context).country,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          MainCubit.get(context).productFeedModel!.data.product.countryOrigin,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: HexColor(grey),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                myDivider(context),

                if (MainCubit.get(context).productFeedModel!.data.product.color_attributes != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                appTranslation(context).color,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 30.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => ListItemColor(model :MainCubit.get(context).productFeedModel!.data.product.color_attributes![index]),
                                  separatorBuilder: (context, index) => space5Horizontal,
                                  itemCount: MainCubit.get(context).productFeedModel!.data.product.color_attributes!.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      myDivider(context),
                    ],
                  ),

                if (MainCubit.get(context).productFeedModel!.data.product.size_attributes != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                appTranslation(context).size,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 20.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => ListItemSize(model :MainCubit.get(context).productFeedModel!.data.product.size_attributes![index]),
                                  separatorBuilder: (context, index) => space5Horizontal,
                                  itemCount: MainCubit.get(context).productFeedModel!.data.product.size_attributes!.length,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      myDivider(context),
                    ],
                  ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              appTranslation(context).length,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context).productFeedModel!.data.product.length ?? appTranslation(context).no_information_available,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: HexColor(grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              appTranslation(context).width,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context).productFeedModel!.data.product.width ?? appTranslation(context).no_information_available,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: HexColor(grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              appTranslation(context).height,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context).productFeedModel!.data.product.height ?? appTranslation(context).no_information_available,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: HexColor(grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              appTranslation(context).weight,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context).productFeedModel!.data.product.weight ?? appTranslation(context).no_information_available,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: HexColor(grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                  ],
                ),



                // Container(
                //   color: Colors.black,
                //   height: double.infinity,
                //   width: 1.0,
                // ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Texture',
                //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //             fontWeight: FontWeight.w700,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Text(
                //           'Cotton, Linen, Linen Organic',
                //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //             color: HexColor(grey),
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                // const Divider(),

              ],
            ),
          ),
        );
      },
    );
  }
}
