import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/categories/presentation/widgets/custom_delegate.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_cat_item.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_grid_products_item.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_list_products_item.dart';

class UsedMarketPage extends StatefulWidget {
  const UsedMarketPage({Key? key}) : super(key: key);

  @override
  State<UsedMarketPage> createState() => _UsedMarketPageState();
}

class _UsedMarketPageState extends State<UsedMarketPage> {
  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getUsedMarket();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BackScaffold(
          title: appTranslation(context).used_market,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BuildCondition(
            condition: state is GetUsedMarketLoadingState,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
            fallback: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 140.0,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => UsedMarketCatItem(
                          model: MainCubit.get(context)
                              .usedMarketModel!
                              .data
                              .categoriesList[index],
                        ),
                        separatorBuilder: (context, index) => space5Horizontal,
                        itemCount: MainCubit.get(context)
                            .usedMarketModel!
                            .data
                            .categoriesList
                            .length,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: MainCubit.get(context).isDark
                            ? HexColor(secondBackground)
                            : HexColor(productBackground),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              appTranslation(context).used_products,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                MainCubit.get(context).changeGridToList(true);
                              },
                              icon: Icon(
                                Icons.grid_view,
                                color: !MainCubit.get(context).gridNotList
                                    ? HexColor(grey)
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
                                    ? HexColor(grey)
                                    : HexColor(mainColor),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (MainCubit.get(context).gridNotList)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              height:
                                  MainCubit.get(context).isRtl ? 262.0 : 252.0,
                            ),
                            itemCount: MainCubit.get(context)
                                .usedMarketModel!
                                .data
                                .usedMarketProductsDataModel
                                .usedMarketProduct
                                .length,
                            itemBuilder: (context, index) =>
                                UsedMarketProductHorizontalItem(
                              product: MainCubit.get(context)
                                  .usedMarketModel!
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
                                .usedMarketModel!
                                .data
                                .usedMarketProductsDataModel
                                .usedMarketProduct[index],
                          ),
                          separatorBuilder: (context, index) =>
                              myDivider(context),
                          itemCount: MainCubit.get(context)
                              .usedMarketModel!
                              .data
                              .usedMarketProductsDataModel
                              .usedMarketProduct
                              .length,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
