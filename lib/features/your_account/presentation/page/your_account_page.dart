import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/setting_item.dart';
import 'package:medical_empire_app/features/edit_account/presentation/page/change_password_page.dart';
import 'package:medical_empire_app/features/edit_account/presentation/page/edit_account_page.dart';

class YourAccountPage extends StatelessWidget {
  const YourAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
        builder: (BuildContext context, state) {
          return BackScaffold(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: appTranslation(context).your_account,
              body: Column(
                children: [
                  SettingsItem(
                    title: appTranslation(context).edit_account,
                    function: ()
                    {
                      navigateTo(context,  EditAccountPage(),);
                    },
                    icon: FontAwesomeIcons.edit,
                    showIcon: false,
                    paddingHorizontal: 20.0,
                  ),
                  SettingsItem(
                    title: appTranslation(context).change_password,
                    function: ()
                    {
                      navigateTo(context,  ChangePasswordPage(),);
                    },
                    icon: FontAwesomeIcons.infoCircle,
                    showIcon: false,
                    paddingHorizontal: 20.0,
                  ),
                  // SettingsItem(
                  //   title: appTranslation(context).address_billing,
                  //   function: ()
                  //   {
                  //
                  //   },
                  //   icon: FontAwesomeIcons.phoneAlt,
                  //   showIcon: false,
                  //   paddingHorizontal: 20.0,
                  // ),
                  // SettingsItem(
                  //   title: appTranslation(context).address_shipping,
                  //   function: ()
                  //   {
                  //
                  //   },
                  //   icon: FontAwesomeIcons.phoneAlt,
                  //   showIcon: false,
                  //   paddingHorizontal: 20.0,
                  // ),
                ],
              ),
          );
        },
    );
  }
}
