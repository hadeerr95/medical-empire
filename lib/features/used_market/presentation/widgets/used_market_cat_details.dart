import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/categories/presentation/widgets/custom_delegate.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_grid_products_item.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_list_products_item.dart';

class UsedMarketCatDetails extends StatefulWidget {
  final String title;
  final int id;

  const UsedMarketCatDetails({
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<UsedMarketCatDetails> createState() => _UsedMarketCatDetailsState();
}

class _UsedMarketCatDetailsState extends State<UsedMarketCatDetails> {
  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getUsedMarketCatDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: widget.title,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BuildCondition(
            condition: MainCubit.get(context).usedMarketCatDetailsModel != null,
            builder: (context) => BuildCondition(
              condition: MainCubit.get(context)
                  .usedMarketCatDetailsModel!
                  .data
                  .usedMarketProductsDataModel
                  .usedMarketProduct
                  .isEmpty,
              builder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/empty_box.svg',
                    //   color: HexColor(blueGrey),
                    //   width: 200.0,
                    // ),
                    Image(
                      image: const AssetImage('assets/images/empty.png'),
                      height: 200.0,
                      width: 200.0,
                      color: HexColor(blueGrey),
                    ),
                    // Text(
                    //   'This category is empty',
                    //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    //         color: HexColor(black),
                    //       ),
                    // ),
                  ],
                ),
              ),
              fallback: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: MainCubit.get(context).isDark
                          ? HexColor(secondBackground)
                          : HexColor(productBackground),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              MainCubit.get(context).changeGridToList(true);
                            },
                            icon: Icon(
                              Icons.grid_view,
                              color: !MainCubit.get(context).gridNotList
                                  ? HexColor(blueGrey)
                                  : HexColor(mainColor),
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              MainCubit.get(context).changeGridToList(false);
                            },
                            icon: Icon(
                              Icons.view_list,
                              color: MainCubit.get(context).gridNotList
                                  ? HexColor(blueGrey)
                                  : HexColor(mainColor),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    space10Vertical,
                    if (MainCubit.get(context).gridNotList)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            height: 290.0,
                          ),
                          itemCount: MainCubit.get(context)
                              .usedMarketCatDetailsModel!
                              .data
                              .usedMarketProductsDataModel
                              .usedMarketProduct
                              .length,
                          itemBuilder: (context, index) =>
                              UsedMarketProductHorizontalItem(
                            product: MainCubit.get(context)
                                .usedMarketCatDetailsModel!
                                .data
                                .usedMarketProductsDataModel
                                .usedMarketProduct[index],
                          ),
                        ),
                      ),
                    if (!MainCubit.get(context).gridNotList)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            UsedMarketListOfProducts(
                          product: MainCubit.get(context)
                              .usedMarketCatDetailsModel!
                              .data
                              .usedMarketProductsDataModel
                              .usedMarketProduct[index],
                        ),
                        separatorBuilder: (context, index) =>
                            myDivider(context),
                        itemCount: MainCubit.get(context)
                            .usedMarketCatDetailsModel!
                            .data
                            .usedMarketProductsDataModel
                            .usedMarketProduct
                            .length,
                      ),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
