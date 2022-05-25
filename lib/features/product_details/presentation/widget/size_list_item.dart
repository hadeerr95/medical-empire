import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class SizeListItem extends StatelessWidget {
  final SizeModel model;
  final int index;
  const SizeListItem({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return  InkWell(
          onTap: () {
            MainCubit.get(context).selectSize(index);
          },
          child: Container(
            height: 30.0,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: MainCubit.get(context).currentSize == index ? HexColor(thirdColor) :  HexColor(grey),width: 2.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              model.attribute.name.en,
              style: Theme.of(context).textTheme.caption!.copyWith(
                color: MainCubit.get(context).currentSize == index ? HexColor(thirdColor) : HexColor(grey),
              ),
            ),
          ),
        );
      },
    );
  }
}
