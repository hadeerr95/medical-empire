import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class ListItemSize extends StatelessWidget {
  final SizeModel model;
  const ListItemSize({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${model.attribute.name.en},',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        color: HexColor(grey),
      ),
    );
  }
}
