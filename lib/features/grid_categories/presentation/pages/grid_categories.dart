import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/three_bounce.dart';
import 'package:medical_empire_app/features/categories/presentation/widgets/custom_delegate.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/widgets/list_of_products.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/category_data.dart';

class GridCategories extends StatefulWidget {
  final int id;
  final String categoryName;
  final bool isCategory;

  const GridCategories({
    required this.id,
    required this.categoryName,
    required this.isCategory,
    Key? key,
  }) : super(key: key);

  @override
  State<GridCategories> createState() => _GridCategoriesState();
}

class _GridCategoriesState extends State<GridCategories> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.extentAfter == 0) {
        if (MainCubit.get(context).hasEnd) {
          MainCubit.get(context).changeHasEnd();
          print('------------- end');

          if (MainCubit.get(context).categoryProductCurrentPage <=
              MainCubit.get(context).categoryProductTotalPages) {
            MainCubit.get(context).getCategoryProduct(
              id: widget.id,
            );
          }
        }
      }
    });

    if (widget.isCategory == true) {
      MainCubit.get(context).getCategoryProduct(
        id: widget.id,
        isFirst: true,
      );
    } else {
      MainCubit.get(context).getBrandDetails(id: widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is AddComparesSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return BackScaffold(
          title: widget.categoryName,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BuildCondition(
            condition: MainCubit.get(context).productsList.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              controller: controller,
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
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.sort,
                        //     color: HexColor(mainColor),
                        //     size: 20,
                        //   ),
                        // ),
                        // Text(
                        //   'Sort',
                        //   style: Theme.of(context).textTheme.headline6!.copyWith(
                        //     color: HexColor(blueGrey),
                        //   ),
                        // ),
                        // space10Horizontal,
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.add_road_rounded,
                        //     color: HexColor(mainColor),
                        //     size: 20,
                        //   ),
                        // ),
                        // Text(
                        //   'Refine',
                        //   style: Theme.of(context).textTheme.headline6!.copyWith(
                        //     color: HexColor(blueGrey),
                        //   ),
                        // ),
                        // const Spacer(),
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
                          height: 360.0,
                        ),
                        itemCount: MainCubit.get(context).productsList.length,
                        itemBuilder: (context, index) =>
                            CategoryProductHorizontalItem(
                          products: MainCubit.get(context).productsList[index],
                        ),
                      ),
                    ),
                  if (!MainCubit.get(context).gridNotList)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListOfProducts(
                        products: MainCubit.get(context).productsList[index],
                      ),
                      separatorBuilder: (context, index) => myDivider(context),
                      itemCount: MainCubit.get(context).productsList.length,
                    ),
                  if (state is CategoryProductsLoadingMoreState)
                    SizedBox(
                      height: 44.0 + 20.0 + 20.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SpinKitThreeBounce(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.75),
                          size: 30,
                        ),
                      ),
                    ),
                ],
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
