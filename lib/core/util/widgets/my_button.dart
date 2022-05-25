import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  final Color color;
  double radius;
  Color textColor;
  bool stroke;
  FontWeight fontWeight;
  double fontsize;

  MyButton({
    Key? key,
    required this.voidCallback,
    required this.text,
    required this.color,
    this.radius = 5.0,
    this.textColor = Colors.white,
    this.stroke = false,
    this.fontWeight = FontWeight.bold,
    this.fontsize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: voidCallback,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
                fontSize: fontsize,
              ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ),
        border:stroke? Border.all(color: HexColor(mainColor)) : null,
        color: color,
      ),
    );
  }
}
