import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

import '../constants.dart';

class SubSubCategoriesItem extends StatelessWidget {
  final Children model;
  const SubSubCategoriesItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
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
                    MainCubit.get(context).isRtl? model.name.ar: model.name.en,
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
        );
      },
    );
  }
}
