import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class SocialBox extends StatelessWidget {
  final String image;
  const SocialBox({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor(darkWhite)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset(
          'assets/images/$image.svg',
        ),
      ),
    );
  }
}
