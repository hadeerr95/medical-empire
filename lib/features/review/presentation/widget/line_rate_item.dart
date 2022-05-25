import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LineRateItem extends StatelessWidget {
  final String starNum;
  final String progressText;
  final double progress;
  const LineRateItem({
    Key? key,
    required this.starNum,
    required this.progressText,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          '$starNum star',
          style: Theme.of(context).textTheme.caption,
        ),
        space5Horizontal,
        LinearPercentIndicator(
          width: 160.0,
          lineHeight: 6.0,
          percent: progress,
          progressColor: HexColor(thirdColor),
        ),
        Text(
          '$progressText %',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
