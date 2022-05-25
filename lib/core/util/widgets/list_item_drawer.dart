import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/sub_categories_item.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

import '../constants.dart';

class ListItemDrawer extends StatelessWidget {
  Widget? trailing;
  final Categories model;
  int? indexIcon;

  ListItemDrawer({
    Key? key,
    required this.model,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                // navigateTo(
                //     context,
                //     GridCategories(
                //       isCategory: true,
                //       id: model.id,
                //       categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
                //     ));

                //Navigator.pop(context);
              },
              child: ExpansionTile(
                key: Key(model.id.toString()),
                tilePadding: const EdgeInsetsDirectional.only(end: 14.0),
                childrenPadding: EdgeInsetsDirectional.zero,
                // iconColor: HexColor(grey),
                // trailing: AssetSvg(imagePath: 'dot',color: HexColor(grey),),
                trailing: Icon(
                  MainCubit.get(context).defaultExpansionTile == model.id
                      ? Icons.keyboard_arrow_down
                      :MainCubit.get(context).isRtl? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                  color: HexColor(grey),
                  size: 18.0,
                ),
                onExpansionChanged: (bool expanded) {
                  MainCubit.get(context).changeExpansionTile(expanded, model.id);
                },
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CircleAvatar(
                      //   radius: 14.0,
                      //   backgroundImage:
                      //       NetworkImage('$categoriesUrl${model.mobile_image}'),
                      // ),
                      // space10Horizontal,
                      Expanded(
                        child: Text(
                          MainCubit.get(context).isRtl
                              ? model.name.ar
                              : model.name.en,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w700),
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
                        Icons.keyboard_arrow_right,
                        color: HexColor(grey),
                        size: 18.0,
                      ),
                      onExpansionChanged: (bool expanded) {
                        navigateTo(
                            context,
                            GridCategories(
                              isCategory: true,
                              id: model.id,
                              categoryName: MainCubit.get(context).isRtl ? model.name.ar : model.name.en,
                            ));
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
                                appTranslation(context).see_all,
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      indexIcon = index;
                      print(index);
                      return SubCategoriesItem(
                        model: model.childrenDataModel[index],
                        modelList: model.childrenDataModel,
                      );
                    },
                    itemCount: model.childrenDataModel.length,
                  ),
                ],
              ),
            ),
            myDivider(context),
          ],
        );
      },
    );
  }
}
