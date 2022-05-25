import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/social_box.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';
import 'package:medical_empire_app/features/register/presentation/pages/reister_page.dart';

import '../../../../core/util/widgets/setting_item.dart';

class SignOutPage extends StatelessWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Align(
            //     alignment: AlignmentDirectional.center,
            //     child: Text(
            //         'Sign in to receive exclusive offer and\n promotions',
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //           color: secondaryVariant
            //       ),
            //     ),
            //   ),
            // ),
            space20Vertical,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                        voidCallback: (){
                          navigateTo(context, RegisterPage());
                        },
                        text: 'Create account',
                        color: HexColor(mainColor),
                      radius: 8.0,
                    ),
                  ),
                  space10Horizontal,
                  Expanded(
                    child: MyButton(
                        voidCallback: (){
                          navigateTo(context, LoginPage());
                        },
                        text: 'Sign in',
                        color: HexColor(mainColor),
                      radius: 8.0,
                    ),
                  ),
                ],
              ),
            ),
            space20Vertical,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Text(
            //     'Setting',
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            // ),
            space10Vertical,
            SettingsItem(
              title: 'App Setting',
              function: ()
              {

              },
              icon: FontAwesomeIcons.edit,
            ),
            SettingsItem(
              title: 'Help & info',
              function: ()
              {

              },
              icon: FontAwesomeIcons.infoCircle,
            ),
            SettingsItem(
              title: 'Hotline',
              function: ()
              {

              },
              icon: FontAwesomeIcons.phoneAlt,
              showPhone: true,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '@cirrilla 2021',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                   InkWell(
                    onTap: (){},
                      child: const SocialBox(image: 'facebook'),
                  ),
                  space10Horizontal,
                  InkWell(
                    onTap: (){},
                    child: const SocialBox(image: 'google'),
                  ),
                  space10Horizontal,
                  InkWell(
                   onTap: (){},
                    child: const SocialBox(image: 'twitter'),
                  ),
                  space10Horizontal,
                  InkWell(
                    onTap: (){},
                    child: const SocialBox(image: 'pinterest'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
