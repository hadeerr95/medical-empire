import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class BoxItem extends StatelessWidget {
  final String title;
  final Widget child;

  const BoxItem({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color:MainCubit.get(context).isDark? HexColor(secondBackground): HexColor(greyWhite),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: HexColor(secondaryVariantDark),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              child,
            ],
          ),
        );
      },
    );
  }
}
