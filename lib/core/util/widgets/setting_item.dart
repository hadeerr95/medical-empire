import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  Function? function;
  Widget? trailing;
  late bool showPhone;
  late bool sign;
  late bool showIcon;
  late bool showAssetsIcon;
  late double paddingHorizontal;
   String? imagePath;

  SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.function,
    this.trailing,
    this.showPhone = false,
    this.sign = true,
    this.showIcon = true,
    this.showAssetsIcon = false,
    this.paddingHorizontal = 14.0,
    this.imagePath ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            function!();
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(showIcon)
                  Icon(icon, size: 16.0, color: secondaryVariant,),
                if(showIcon)
                  space10Horizontal,
                if(showAssetsIcon)
                SvgPicture.asset(
                  'assets/images/$imagePath.svg',
                  color: HexColor(grey),
                  width: 18.0,
                ),
                if(showAssetsIcon)
                  space10Horizontal,

                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                if(showPhone)
                  Text(
                  '01555156821',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: secondaryVariant
                  ),
                ),
                space20Horizontal,
                if(sign)
                  RotatedBox(
                  quarterTurns: Directionality.of(context) == TextDirection.rtl ? 2 : 0,
                  child: trailing ??
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 16.0,
                        color: HexColor(grey),
                      ),
                ),
              ],
            ),
          ),
        ),
        myDivider(context),
      ],
    );
  }
}