import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/get_faqs_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class QuestionItemWidget extends StatelessWidget {
  const QuestionItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FAQ model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (context) {
                  return Directionality(
                    textDirection: MainCubit.get(context).isRtl ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: MainCubit.get(context).isDark?  HexColor(secondBackground) : Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MainCubit.get(context).isRtl ?
                            model.question.ar : model.question.en,
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: HexColor(secondaryVariantDark),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          space10Vertical,
                          Text(
                            MainCubit.get(context).isRtl ?
                            model.answer.ar : model.answer.en,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: HexColor(secondaryVariantDark),
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    MainCubit.get(context).isRtl ?
                    model.question.ar : model.question.en,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: HexColor(secondaryVariantDark),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                space20Horizontal,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.0,
                  color: HexColor(grey),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
