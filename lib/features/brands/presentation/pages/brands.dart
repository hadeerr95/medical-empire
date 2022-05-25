import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/brands/presentation/widgets/single_brand_item.dart';

// ignore: must_be_immutable
class BrandsPage extends StatelessWidget {
  BrandsPage({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).brand,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BuildCondition(
        condition: MainCubit.get(context).brandsModel != null,
        builder: (context) => Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => SingleBrandItem(
                  model: MainCubit.get(context).brandsModel!.brands[index],
                ),
                separatorBuilder: (context, index) => myDivider(
                  context,
                ),
                itemCount: MainCubit.get(context).brandsModel!.brands.length,
              ),
            ),
          ],
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
