import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/features/categories/presentation/widgets/custom_delegate.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/category_data.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return KeepAliveWidget(
          child: Conditional.single(
            context: context,
            widgetBuilder: (context) => Row(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 100.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...MainCubit.get(context)
                            .categoriesModel!
                            .data
                            .categoriesList
                            .asMap()
                            .map(
                              (i, element) => MapEntry(
                                i,
                                Material(
                                  color: MainCubit.get(context)
                                              .currentParentCategorySelected ==
                                          i
                                      ? Theme.of(context).scaffoldBackgroundColor
                                      : Colors.transparent,
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 60.0,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MainCubit.get(context)
                                                        .currentParentCategorySelected ==
                                                    i
                                                ? 0.0
                                                : 4.0,
                                          ),
                                          child: Row(
                                            children: [
                                              if (MainCubit.get(context)
                                                      .currentParentCategorySelected ==
                                                  i)
                                                Container(
                                                  width: 4.0,
                                                  height: double.infinity,
                                                  color:
                                                      Theme.of(context).primaryColor,
                                                ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: MainCubit.get(context)
                                                                .currentParentCategorySelected ==
                                                            i
                                                        ? 6.0
                                                        : 0.0,
                                                  ),
                                                  child: Text(
                                                    displayTranslatedText(
                                                      context: context,
                                                      ar: element.name.ar,
                                                      en: element.name.en,
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: MainCubit.get(
                                                                      context)
                                                                  .currentParentCategorySelected ==
                                                              i
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        space10Vertical,
                                      ],
                                    ),
                                    onTap: () {
                                      MainCubit.get(context)
                                          .changeParentCategorySelection(i);
                                    },
                                  ),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            space10Vertical,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  SingleGridBuilder(
                                childrenDataModel: MainCubit.get(context)
                                    .categoriesModel!
                                    .data
                                    .categoriesList[MainCubit.get(context)
                                        .currentParentCategorySelected]
                                    .childrenDataModel[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  space10Vertical,
                              itemCount: MainCubit.get(context)
                                  .categoriesModel!
                                  .data
                                  .categoriesList[MainCubit.get(context)
                                      .currentParentCategorySelected]
                                  .childrenDataModel
                                  .length,
                            ),
                            space10Vertical,
                            Text(
                              appTranslation(context).bestOffers,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                            ),
                            space10Vertical,
                            ProductsBuilder(
                              allProducts: MainCubit.get(context)
                                  .categoriesModel!
                                  .data
                                  .categoriesList[MainCubit.get(context)
                                      .currentParentCategorySelected]
                                  .products,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            fallbackBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            conditionBuilder: (context) =>
                MainCubit.get(context).categoriesModel != null,
          ),
        );
      },
    );
  }
}

class SingleChildItem extends StatelessWidget {
  final Children childrenModel;

  const SingleChildItem({
    required this.childrenModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          GridCategories(
            isCategory: true,
            categoryName: displayTranslatedText(
              context: context,
              ar: childrenModel.name.ar,
              en: childrenModel.name.en,
            ),
            id: childrenModel.id,
          ),
        );
      },
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Image(
              width: double.infinity,
              // height: gridWidth.roundToDouble(),
              height: 100.0,
              image: NetworkImage(
                '$categoriesUrl${childrenModel.image}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          space6Vertical,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
            ),
            child: Text(
              displayTranslatedText(
                context: context,
                ar: childrenModel.name.ar,
                en: childrenModel.name.en,
              ),
              textAlign: TextAlign.center,
              maxLines: displayTranslatedText(
                context: context,
                ar: childrenModel.name.ar,
                en: childrenModel.name.en,
              ).split(' ').length == 1 ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    height: 1.6,
                fontWeight: FontWeight.w400
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsBuilder extends StatelessWidget {
  final List<ProductModel> allProducts;

  const ProductsBuilder({
    required this.allProducts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      child: SizedBox(
        height: 360.0,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CategoryProductHorizontalItem(
                  products: MainCubit.get(context)
                      .categoriesModel!
                      .data
                      .categoriesList[
                          MainCubit.get(context).currentParentCategorySelected]
                      .products[index],
                ),
            separatorBuilder: (context, index) => space10Horizontal,
            itemCount: MainCubit.get(context)
                .categoriesModel!
                .data
                .categoriesList[
                    MainCubit.get(context).currentParentCategorySelected]
                .products
                .length),
        // child: ListView.separated(
        //   physics: const BouncingScrollPhysics(),
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) => SingleProductItem(
        //     image: allProducts[index].image,
        //     title: allProducts[index].name.en,
        //   ),
        //   separatorBuilder: (context, index) => space10Horizontal,
        //   itemCount: allProducts.length,
        // ),
      ),
    );
  }
}

class SingleGridBuilder extends StatelessWidget {
  final ChildrenDataModel childrenDataModel;

  const SingleGridBuilder({
    required this.childrenDataModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (childrenDataModel.children.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  displayTranslatedText(
                    context: context,
                    en: childrenDataModel.name.en,
                    ar: childrenDataModel.name.ar,
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.start,
                ),
              ),
                AppTextButton(
                  label: appTranslation(context).see_all,
                  onPress: () {
                    navigateTo(
                      context,
                      GridCategories(
                        isCategory: true,
                        categoryName: displayTranslatedText(
                          context: context,
                          ar: childrenDataModel.name.ar,
                          en: childrenDataModel.name.en,
                        ),
                        id: childrenDataModel.id,
                      ),
                    );
                  },
                  style: Theme.of(context).textTheme.subtitle2,
                ),
            ],
          ),
        if (childrenDataModel.children.isNotEmpty)
          const SizedBox(
            height: 14.0,
          ),
        if (childrenDataModel.children.isNotEmpty)
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 8.0,
                  height: 170.0,
                ),
                itemBuilder: (context, index) => SingleChildItem(
                  childrenModel: childrenDataModel.children[index],
                ),
                itemCount: childrenDataModel.children.length,
              );
            },
          ),
      ],
    );
  }
}

// class SingleProductItem extends StatelessWidget {
//   final String image;
//   final String title;
//
//   const SingleProductItem({
//     Key? key,
//     required this.image,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20.0,
//       ),
//       decoration: BoxDecoration(
//         color: HexColor(surface),
//         borderRadius: BorderRadius.circular(
//           10.0,
//         ),
//       ),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Column(
//         children: [
//           Expanded(
//             child: Image(
//               image: NetworkImage('$productsUrl$image'),
//               width: 140.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(
//             height: 6.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10.0,
//             ),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 10.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
