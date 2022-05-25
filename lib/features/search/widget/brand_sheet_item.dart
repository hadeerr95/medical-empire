import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class BrandSheetItem extends StatelessWidget {
 final Brand model;
  const BrandSheetItem({
    Key? key,
    required this.model,
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
              onPressed: (){
                MainCubit.get(context).selectBrand(model.id, MainCubit.get(context).isRtl? model.name.ar : model.name.en);
                // MainCubit.get(context).addBrandSelected(model.name.en);
              },
              child: Text(
                MainCubit.get(context).isRtl?
                model.name.ar : model.name.en,
                style: Theme.of(context).textTheme.caption!.copyWith(
                  color: MainCubit.get(context).brandId == model.id ? HexColor(surface) : (MainCubit.get(context).isDark? HexColor(surface) : HexColor(mainColor)) ,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color:MainCubit.get(context).brandId == model.id? HexColor(mainColor) : (MainCubit.get(context).isDark? HexColor(grey) : HexColor(mainColor))) ,
              color: MainCubit.get(context).brandId == model.id ? HexColor(mainColor) : (MainCubit.get(context).isDark? HexColor(secondBackground) : HexColor(surface)) ,
            ),
          ),
        );
      },
    );
  }
}
