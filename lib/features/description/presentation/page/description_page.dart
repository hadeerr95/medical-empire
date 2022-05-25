import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return BackScaffold(
          title: appTranslation(context).description,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    displayTranslatedText(
                      context: context,
                      ar:  MainCubit.get(context).productFeedModel!.data.product.short_desc.ar,
                      en: MainCubit.get(context).productFeedModel!.data.product.short_desc.en,
                    ),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: HexColor(grey)
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
