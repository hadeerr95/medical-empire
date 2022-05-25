import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  Color? color;
  double? size;

  AssetSvg({
    Key? key,
    required this.imagePath,
    this.color = secondaryVariant,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Transform(
          alignment: Alignment.center,
          transform:MainCubit.get(context).isRtl? Matrix4.rotationY(math.pi) :  Matrix4.rotationY(0),
          child: SvgPicture.asset(
            'assets/images/$imagePath.svg',
            color: color,
            width: size,
            height: size,
          ),
        );
      },
    );
  }
}
