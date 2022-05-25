import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/faq/presentation/widgets/question_item_widget.dart';

class FAQPage extends StatelessWidget {
  FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).faq,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => QuestionItemWidget(
                model: MainCubit.get(context).faqsModel!.faqs[index],
              ),
              itemCount: 12, separatorBuilder: (BuildContext context, int index) => myDivider(context),
            ),
          ],
        ),
      ),
    );
  }
}
