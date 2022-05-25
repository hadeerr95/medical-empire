import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class CategoriesSheetItem extends StatelessWidget {
  final int id;
  final String nameEn;
  final String nameAr;
  // final int index;

  const CategoriesSheetItem({
    Key? key,
    required this.id,
    required this.nameEn,
    required this.nameAr,
    // required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 30.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: MaterialButton(
              minWidth: 0.0,
              onPressed: () {
                MainCubit.get(context).selectCategories(id, MainCubit.get(context).isRtl? nameAr : nameEn);
                // MainCubit.get(context).addCategoriesSelected(model.name.en);
              },
              child: Text(
                displayTranslatedText(context: context, ar: nameAr, en: nameEn),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: MainCubit.get(context).categoryId == id
                          ? HexColor(surface)
                          : (MainCubit.get(context).isDark
                              ? HexColor(surface)
                              : HexColor(mainColor)),
                    ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                  color: MainCubit.get(context).categoryId == id
                      ? HexColor(mainColor)
                      : (MainCubit.get(context).isDark
                          ? HexColor(grey)
                          : HexColor(mainColor)),),
              color: MainCubit.get(context).categoryId == id
                  ? HexColor(mainColor)
                  : (MainCubit.get(context).isDark
                      ? HexColor(secondBackground)
                      : HexColor(surface)),
            ),
          ),
        );
      },
    );
  }
}
