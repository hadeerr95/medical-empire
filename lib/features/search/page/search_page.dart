import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/empty_widget.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/my_button_icon.dart';
import 'package:medical_empire_app/core/util/widgets/three_bounce.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/widgets/list_of_products.dart';
import 'package:medical_empire_app/features/search/widget/brand_sheet_item.dart';
import 'package:medical_empire_app/features/search/widget/categories_sheet_item.dart';
import 'package:medical_empire_app/features/search/widget/select_fillter_item.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

          if (MainCubit.get(context).searchProductCurrentPage <=
              MainCubit.get(context).searchProductTotalPages) {
            MainCubit.get(context).getSearch(
              productName: searchController.text,
              categoryId: MainCubit.get(context).categoryId,
              brandId: MainCubit.get(context).brandId,
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return BackScaffold(
          title: appTranslation(context).search,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            space10Horizontal,
                            Icon(
                              Icons.search,
                              color: HexColor(grey),
                            ),
                            space10Horizontal,
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  print('----data from search ----');
                                  MainCubit.get(context).getSearch(
                                    isFirst: true,
                                    productName: value,
                                    categoryId: MainCubit.get(context).categoryId,
                                    brandId: MainCubit.get(context).brandId,
                                  );
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      appTranslation(context).search_for_product,
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText2!.copyWith(
                                            color: HexColor(grey),
                                          ),
                                ),
                              ),
                            ),
                            if (searchController.text.isNotEmpty)
                              IconButton(
                                onPressed: () {
                                  searchController.text = '';
                                  MainCubit.get(context).clearSearch();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: HexColor(grey),
                                ),
                              ),
                          ],
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          color: MainCubit.get(context).isDark
                              ? HexColor(secondBackground)
                              : HexColor(productBackground),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    space10Horizontal,
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: MainCubit.get(context).isDark
                            ? HexColor(secondBackground)
                            : HexColor(productBackground),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                          icon: AssetSvg(
                              imagePath: 'filter',
                            color: HexColor(grey),
                          ),
                        onPressed: (){
                          if (MainCubit.get(context).categoriesModel != null) {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                        0.75,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SingleChildScrollView(
                                              physics: const BouncingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          appTranslation(context)
                                                              .filter,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6!
                                                              .copyWith(
                                                            color:MainCubit.get(context).isDark? HexColor(surface) : HexColor(black),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        AppTextButton(
                                                          label: appTranslation(context)
                                                              .clear_all,
                                                          onPress: () {
                                                            MainCubit.get(context)
                                                                .selectCategories(-1, '');
                                                            MainCubit.get(context)
                                                                .selectBrand(-1, '');
                                                          },
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  InkWell(
                                                    onTap: (){

                                                    },
                                                    child: ExpansionTile(
                                                      tilePadding: EdgeInsetsDirectional.zero,
                                                      childrenPadding: const EdgeInsetsDirectional.only(start: 0.0),
                                                      trailing: Icon(
                                                        MainCubit.get(context).changeCategoriesBottomSheet ?  Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                                                        color: HexColor(grey),
                                                        size: 18.0,
                                                      ),
                                                      onExpansionChanged: (bool expanded) {
                                                        MainCubit.get(context).changeCategoriesBottomSheetTile(expanded);
                                                      },
                                                      title: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            appTranslation(context)
                                                                .categories,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                              color: HexColor(
                                                                  secondaryVariantDark),
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      children: [
                                                        Wrap(
                                                          children: [
                                                            ...listOfCategories(
                                                              model: MainCubit.get(context).categoriesModel!.data.categoriesList,
                                                            ),

                                                          ],
                                                          crossAxisAlignment:
                                                          WrapCrossAlignment.start,
                                                          alignment: WrapAlignment.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {

                                                    },
                                                    child: ExpansionTile(
                                                      tilePadding: EdgeInsetsDirectional.zero,
                                                      childrenPadding: const EdgeInsetsDirectional.only(start: 0.0),
                                                      trailing: Icon(
                                                        MainCubit.get(context).changeBrandBottomSheet ?  Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                                                        color: HexColor(grey),
                                                        size: 18.0,
                                                      ),
                                                      onExpansionChanged: (bool expanded) {
                                                        MainCubit.get(context).changeBrandBottomSheetTile(expanded);
                                                      },
                                                      title: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            appTranslation(context).brand,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                              color: HexColor(
                                                                  secondaryVariantDark),
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      children: [
                                                        Wrap(
                                                          children: MainCubit.get(context)
                                                              .brandsModel!
                                                              .brands
                                                              .asMap()
                                                              .map((index, element) =>
                                                              MapEntry(
                                                                  index,
                                                                  BrandSheetItem(
                                                                    model: element,
                                                                  )))
                                                              .values
                                                              .toList(),
                                                          crossAxisAlignment:
                                                          WrapCrossAlignment.start,
                                                          alignment: WrapAlignment.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        MyButton(
                                            voidCallback: (){
                                              MainCubit.get(context).closeBottomSheet(context: context);
                                            },
                                            text: appTranslation(context).apply,
                                            color: HexColor(mainColor),
                                          radius: 0.0,
                                        ),
                                      ],
                                    ),
                                  );
                                },);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              if(MainCubit.get(context).categoryId != -1 || MainCubit.get(context).brandId != -1 )
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children:  [
                    if(MainCubit.get(context).categoryName != '')
                      SelectFilterItem(
                        title: MainCubit.get(context).categoryName,
                        onTap: (){
                          MainCubit.get(context).selectCategories(-1, '');
                        }
                        ,),
                    if(MainCubit.get(context).categoryName != '')
                      space8Horizontal,
                    if(MainCubit.get(context).brandName != '')
                      SelectFilterItem(
                        title: MainCubit.get(context).brandName,
                      onTap: (){
                        MainCubit.get(context).selectBrand(-1, '');
                      },
                      ),
                  ],
                ),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) => state is SearchLoadingState,
                widgetBuilder: (context) => const Expanded(
                    child: Center(child: CircularProgressIndicator())),
                fallbackBuilder: (context) => Builder(builder: (context) {
                  if (MainCubit.get(context).searchFeedsModel != null) {
                    return Expanded(
                      child: ListView.separated(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => ListOfProducts(
                          products: MainCubit.get(context)
                              .searchProductsList[index],
                        ),
                        separatorBuilder: (context, index) =>
                            myDivider(context),
                        itemCount: MainCubit.get(context)
                            .searchProductsList
                            .length,
                      ),
                    );
                  } else {
                    return Expanded(
                        child: EmptyWidget(
                            text: appTranslation(context).search_for_product));
                  }
                }),
              ),

              if (state is SearchLoadingMoreState)
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
        );
      },
    );
  }

  List<Widget> listOfCategories({
  required List<Categories> model,
}) {
    List<CategoriesSheetItem> myList = [];

    for (var element in model) {
      myList.add(CategoriesSheetItem(
        id: element.id,
        nameEn: element.name.en,
        nameAr: element.name.ar,
      ));

      for(var child in element.childrenDataModel) {
        myList.add(CategoriesSheetItem(
          id: child.id,
          nameEn: child.name.en,
          nameAr: child.name.ar,

        ));

        for(var sub in child.children) {
          myList.add(CategoriesSheetItem(
            id: sub.id,
            nameEn: sub.name.en,
            nameAr: sub.name.ar,
          ));
        }
      }
    }

    return myList;
  }
}


// for(int i = 0 ; i < MainCubit.get(context).categoriesModel!.data.categoriesList.length ; i++)
//   CategoriesSheetItem(
//     id: MainCubit.get(context).categoriesModel!.data.categoriesList[i].id,
//     nameAr:
//     MainCubit.get(context).categoriesModel!.data.categoriesList[i].name.ar,
//     nameEn:
//     MainCubit.get(context).categoriesModel!.data.categoriesList[i].name.en,
//     index: i,
//   ),


// ...MainCubit.get(context)
//     .categoriesModel!
//     .data
//     .categoriesList
//     .asMap()
//     .map(
//       (index, element) =>
//           MapEntry(
//         index,
//         Wrap(
//           crossAxisAlignment:
//               WrapCrossAlignment
//                   .start,
//           alignment:
//               WrapAlignment.start,
//           children: [
//             CategoriesSheetItem(
//               id: element.id,
//               nameAr:
//                   element.name.ar,
//               nameEn:
//                   element.name.en,
//               index: index,
//             ),
//             ...element
//                 .childrenDataModel
//                 .asMap()
//                 .map(
//                   (key, value) =>
//                       MapEntry(
//                     key,
//                     Wrap(
//                       crossAxisAlignment:
//                           WrapCrossAlignment
//                               .start,
//                       alignment:
//                           WrapAlignment
//                               .start,
//                       children: [
//                         CategoriesSheetItem(
//                           id: value
//                               .id,
//                           nameAr: value
//                               .name
//                               .ar,
//                           nameEn: value
//                               .name
//                               .en,
//                           index:
//                               index,
//                         ),
//                         ...value
//                             .children
//                             .asMap()
//                             .map(
//                               (key, subValue) =>
//                                   MapEntry(
//                                 key,
//                                 CategoriesSheetItem(
//                                   id: subValue.id,
//                                   nameAr: subValue.name.ar,
//                                   nameEn: subValue.name.en,
//                                   index: index,
//                                 ),
//                               ),
//                             )
//                             .values
//                             .toList(),
//                       ],
//                     ),
//                   ),
//                 )
//                 .values
//                 .toList(),
//           ],
//         ),
//       ),
//     )
//     .values
//     .toList(),