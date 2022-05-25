import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

class SingleBrandItem extends StatelessWidget {
  const SingleBrandItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Brand model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            navigateTo(
                context,
                GridCategories(
                  isCategory: false,
                  id: model.id,
                  categoryName: MainCubit.get(context).isRtl? model.name.ar : model.name.en,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Image(
                    image: NetworkImage(
                      '$brandsUrl${model.image}',
                    ),
                    height: 45.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                space20Horizontal,
                Text(
                  MainCubit.get(context).isRtl?
                  model.name.ar:
                  model.name.en,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w400,
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
