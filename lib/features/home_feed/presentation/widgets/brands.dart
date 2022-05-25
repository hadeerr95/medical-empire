import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/features/brands/presentation/pages/brands.dart';

import '../../../grid_categories/presentation/pages/grid_categories.dart';

class BrandsWidget extends StatelessWidget {
  final List<Brand> brands;

  const BrandsWidget({
    Key? key,
    required this.brands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appTranslation(context).brand,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppTextButton(
                label: appTranslation(context).see_all,
                style: Theme.of(context).textTheme.subtitle2,
                onPress: () {
                  navigateTo(context, BrandsPage());
                },
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => BrandItem(
                model: brands[index],
              ),
              separatorBuilder: (context, index) => space10Horizontal,
              itemCount: brands.length,
            ),
          ),
        ],
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  final Brand model;

  const BrandItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(
            context,
            GridCategories(
              isCategory: false,
              id: model.id,
              categoryName: MainCubit.get(context).isRtl? model.name.ar : model.name.en,
            ));
      },
      child: Container(
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: HexColor(greyWhite),
            width: 1.0,
          ),
          image: DecorationImage(
            image: NetworkImage('$brandsUrl${model.image}'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
