import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).about_us,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: NetworkImage(
                    'https://medicalempire.com/admin/uploads/pages/page-1635665923.jpg'),
              ),
              space20Vertical,
              Text(
                appTranslation(context).aboutUsText,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: HexColor(secondaryVariantDark),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
