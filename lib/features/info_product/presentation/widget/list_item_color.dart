import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class ListItemColor extends StatelessWidget {
  final ColorModel model;
  const ListItemColor({Key? key, required this.model,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {

        String color = model.attribute.value.replaceAll('rgb(', '').replaceAll(')', '');
        List<String> R_G_BColor = color.split(',');

        return CircleAvatar(
          radius: 14,
          backgroundColor: HexColor(grey),
          child: CircleAvatar(
            radius: 12.0,
            backgroundColor: Color.fromRGBO(int.parse(R_G_BColor[0]), int.parse(R_G_BColor[1]), int.parse(R_G_BColor[2]), 1),
            // model.attribute.value,
          ),
        );
      },
    );
  }
}
