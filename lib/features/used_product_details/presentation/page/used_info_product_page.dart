import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';

class UsedInfoProduct extends StatelessWidget {
  const UsedInfoProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return BackScaffold(
          title: 'Addition Information',
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Country',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          MainCubit.get(context)
                              .usedProductFeedModel!
                              .product
                              .country_origin,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: HexColor(grey),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider(context),

                //TODO: COLOR ad SIZE if used
                /* if (MainCubit.get(context).productFeedModel!.data.product.color_attributes!.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Color',
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
                      const Divider(),
                    ],
                  ),

                if (MainCubit.get(context).productFeedModel!.data.product.size_attributes!.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Size',
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
                      const Divider(),
                    ],
                  ),*/

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Length',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context)
                                      .usedProductFeedModel!
                                      .product
                                      .length ??
                                  'No information available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                              'Width',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context)
                                      .usedProductFeedModel!
                                      .product
                                      .width ??
                                  'No information available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                              'Height',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context)
                                      .usedProductFeedModel!
                                      .product
                                      .height ??
                                  'No information available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                              'Weight',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              MainCubit.get(context)
                                      .usedProductFeedModel!
                                      .product
                                      .weight ??
                                  'No information available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: HexColor(grey),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    myDivider(context),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
