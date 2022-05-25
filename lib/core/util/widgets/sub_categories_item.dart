import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/sub_sub_categories.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

import '../constants.dart';

class SubCategoriesItem extends StatelessWidget {
  final ChildrenDataModel model;
  final List<ChildrenDataModel> modelList;
  const SubCategoriesItem({
    Key? key,
    required this.model,
    required this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            // navigateTo(
            //     context,
            //     GridCategories(
            //       isCategory: true,
            //       id: model.id,
            //       categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
            //     ));
          },
          child: ExpansionTile(
            tilePadding: const EdgeInsetsDirectional.only(end: 14.0),
            childrenPadding: EdgeInsetsDirectional.zero,
            // iconColor: HexColor(grey),
            trailing: Icon(
              MainCubit.get(context).defaultSubExpansionTile == model.id ?
              Icons.keyboard_arrow_down :
              MainCubit.get(context).isRtl? Icons.keyboard_arrow_left :Icons.keyboard_arrow_right,
              color: HexColor(grey),
              size: 18.0,
            ),
            onExpansionChanged: (bool expanded) {
              if(model.children.isEmpty) {
                navigateTo(
                    context,
                    GridCategories(
                      isCategory: true,
                      id: model.id,
                      categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
                    ));
              } else {
                MainCubit.get(context).changeSubExpansionTile(expanded, model.id);
              }
            },
//            maintainState: MainCubit.get(context).defaultSubExpansionTile,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 12.0,
                  //   backgroundImage:
                  //   NetworkImage('$categoriesUrl${model.image_en}'),
                  // ),

                  Text(
                    '-',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!.copyWith(
                      color: HexColor(secondaryVariantDark),
                    ),
                  ),
                  space3Horizontal,
                  Expanded(
                    child: Text(
                      MainCubit.get(context).isRtl? model.name.ar: model.name.en,
                      style: model.children.isNotEmpty ? Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: HexColor(secondaryVariantDark),
                      ) :  Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: HexColor(grey),
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  // AppTextButton(
                  //   label: appTranslation(context).see_all,
                  //   onPress: () {
                  //     navigateTo(
                  //         context,
                  //         GridCategories(
                  //           isCategory: true,
                  //           id: model.id,
                  //           categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
                  //         ));
                  //   },
                  //   style: Theme.of(context).textTheme.subtitle2,
                  // ),
                  // space20Horizontal,
                  // if (sign)
                  //   RotatedBox(
                  //     quarterTurns:
                  //     Directionality.of(context) == TextDirection.rtl ? 2 : 0,
                  //     child: trailing ??
                  //         Icon(
                  //           Icons.keyboard_arrow_right,
                  //           size: 20.0,
                  //           color: HexColor(grey),
                  //         ),
                  //   ),
                ],
              ),
            ),
            children: [
              InkWell(
                onTap: (){
                  navigateTo(
                      context,
                      GridCategories(
                        isCategory: true,
                        id: model.id,
                        categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 8.0),
                  child: Row(
                    children: [
                      // CircleAvatar(
                      //   radius: 12.0,
                      //   backgroundImage:
                      //   NetworkImage('$categoriesUrl${model.image_en}'),
                      // ),

                      Text(
                        '-',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!.copyWith(
                          color: HexColor(secondaryVariantDark),
                        ),
                      ),
                      space3Horizontal,
                      Expanded(
                        child: Text(
                          appTranslation(context).see_all,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!.copyWith(
                            color: HexColor(secondaryVariantDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(index);
                  return SubSubCategoriesItem(
                      model: model.children[index],
                  );
                },
                itemCount: model.children.length,
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
          //   child: Row(
          //     children: [
          //       // CircleAvatar(
          //       //   radius: 12.0,
          //       //   backgroundImage:
          //       //   NetworkImage('$categoriesUrl${model.image_en}'),
          //       // ),
          //
          //       Text(
          //        '-',
          //         style: Theme
          //             .of(context)
          //             .textTheme
          //             .bodyText2!.copyWith(
          //           color: HexColor(secondaryVariantDark),
          //         ),
          //       ),
          //       space3Horizontal,
          //       Expanded(
          //         child: Text(
          //           MainCubit.get(context).isRtl? model.name.ar: model.name.en,
          //           style: Theme
          //               .of(context)
          //               .textTheme
          //               .bodyText2!.copyWith(
          //             color: HexColor(secondaryVariantDark),
          //           ),
          //         ),
          //       ),
          //       // space20Horizontal,
          //       // if (sign)
          //       //   RotatedBox(
          //       //     quarterTurns:
          //       //     Directionality.of(context) == TextDirection.rtl ? 2 : 0,
          //       //     child: trailing ??
          //       //         Icon(
          //       //           Icons.keyboard_arrow_right,
          //       //           size: 20.0,
          //       //           color: HexColor(grey),
          //       //         ),
          //       //   ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
