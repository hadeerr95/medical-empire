import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class ListItemCategory extends StatelessWidget {
  final CategoryModel model;
  const ListItemCategory({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: HexColor(mainColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Text(
          model.name.en,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: HexColor(white),
          ),
        ),
      ),
    );
  }
}
