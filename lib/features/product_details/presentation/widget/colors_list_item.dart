import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class ColorsListItem extends StatelessWidget {
  final ColorModel model;
  final int index;
  const ColorsListItem({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {

        String color = model.attribute.value.replaceAll('rgb(', '').replaceAll(')', '');
        List<String> R_G_BColor = color.split(',');

        return InkWell(
          onTap: () {
            MainCubit.get(context).selectColor(index);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor:MainCubit.get(context).currentColor == index? HexColor(thirdColor) : HexColor(grey),
              child: CircleAvatar(
                radius:MainCubit.get(context).currentColor == index? 12.0 : 13.0,
                backgroundColor: HexColor(white),
                child: CircleAvatar(
                  radius:MainCubit.get(context).currentColor == index? 11.0: 12.0,
                  backgroundColor: Color.fromRGBO(int.parse(R_G_BColor[0]), int.parse(R_G_BColor[1]), int.parse(R_G_BColor[2]), 1),
                  // model.attribute.value,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
