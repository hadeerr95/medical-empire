import 'package:flutter/material.dart';
import 'package:medical_empire_app/core/models/used_market_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/features/used_market/presentation/widgets/used_market_cat_details.dart';

class UsedMarketCatItem extends StatelessWidget {
  const UsedMarketCatItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final UsedMarketCategory model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            UsedMarketCatDetails(
              title: MainCubit.get(context).isRtl?model.name.ar:model.name.en,
              id: model.id,
            ));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image(
                image: NetworkImage(model.cover),
                width: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              MainCubit.get(context).isRtl?model.name.ar:
              model.name.en,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
