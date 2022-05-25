  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final double width;
  Color? color;

  AppButton({
    Key? key,
    required this.label,
    required this.onPress,
    this.width = double.infinity,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 56.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4.0,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        elevation: 50.0,
        hoverElevation: 150.0,
        color: color ?? Theme.of(context).primaryColor,
        onPressed: () {
          onPress();
        },
        child: Text(
          label,
          style: Theme.of(context).textTheme.button!.copyWith(
            color: HexColor(surface),
          ),
        ),
      ),
    );
  }
}
