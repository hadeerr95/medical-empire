import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';

class OfferBanner extends StatelessWidget {
  final OffersBanners banners;

  const OfferBanner({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            // MainCubit.get(context)
            navigateTo(
              context,
              GridCategories(
                isCategory: true,
                categoryName: displayTranslatedText(
                  context: context,
                  ar: 'العروض',
                  en: 'Offer',
                ),
                id: banners.categoryId,
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            height: 100.0,
            width: 160.0,
            child: Image(
              image: NetworkImage(
                MainCubit.get(context).isRtl ? banners.imageAr : banners.imageEn,
              ),
              width: double.infinity,
              height: 100.0,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
