import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class SelectFilterItem extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  const SelectFilterItem({
    Key? key,
    required this.title,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: HexColor(mainColor),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: onTap,
                  child: Icon(
                    Icons.close,
                    color: HexColor(white),
                    size: 18.0,
                  ),
                ),
                space3Horizontal,
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: HexColor(white),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
