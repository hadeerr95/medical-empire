import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/core/util/widgets/app_button.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/about_us/presentation/pages/about_us.dart';
import 'package:medical_empire_app/features/comparisins/page/comparison_page.dart';
import 'package:medical_empire_app/features/cotatct_us/presentation/pages/contact_us.dart';
import 'package:medical_empire_app/features/faq/presentation/pages/faq_page.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';
import 'package:medical_empire_app/features/my_address/presentation/pages/my_address_page.dart';
import 'package:medical_empire_app/features/my_order/presentation/pages/my_orders_page.dart';
import 'package:medical_empire_app/features/register/presentation/pages/reister_page.dart';
import 'package:medical_empire_app/features/used_market/presentation/pages/used_market_page.dart';
import 'package:medical_empire_app/features/your_account/presentation/page/your_account_page.dart';

import '../../../../core/util/widgets/setting_item.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is NewsLetterSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
          emailController.clear();
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, state) {
        return KeepAliveWidget(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!MainCubit.get(context).userSigned ||
                    MainCubit.get(context).myAccountModel == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            voidCallback: () {
                              navigateTo(context, RegisterPage());
                            },
                            text: appTranslation(context).create_account,
                            color: HexColor(mainColor),
                            radius: 8.0,
                          ),
                        ),
                        space10Horizontal,
                        Expanded(
                          child: MyButton(
                            voidCallback: () {
                              navigateTo(context, LoginPage());
                            },
                            text: appTranslation(context).sign_in,
                            color: HexColor(mainColor),
                            radius: 8.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: MainCubit.get(context).isDark
                            ? HexColor(secondBackground)
                            : HexColor(productBackground),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundImage: NetworkImage(
                                MainCubit.get(context)
                                    .myAccountModel!
                                    .data
                                    .image,
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 60.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      appTranslation(context).welcome,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    space3Vertical,
                                    if (MainCubit.get(context).myAccountModel !=
                                        null)
                                      Text(
                                        MainCubit.get(context)
                                            .myAccountModel!
                                            .data
                                            .name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  SettingsItem(
                    title: appTranslation(context).my_account,
                    function: () {
                      navigateTo(
                        context,
                        const YourAccountPage(),
                      );
                    },
                    icon: FontAwesomeIcons.user,
                    showIcon: false,
                    showAssetsIcon: true,
                    imagePath: 'user',
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  SettingsItem(
                    title: appTranslation(context).my_addresses,
                    function: () {
                      navigateTo(
                        context,
                        const MyAddressPage(),
                      );
                      MainCubit.get(context).getMyAddress();
                    },
                    icon: FontAwesomeIcons.locationArrow,
                    showIcon: false,
                    showAssetsIcon: true,
                    imagePath: 'locations',
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  SettingsItem(
                    title: appTranslation(context).comparison,
                    function: () {
                      MainCubit.get(context).getCompares();
                      navigateTo(context, const ComparisonPage());
                    },
                    icon: FontAwesomeIcons.compass,
                    showIcon: false,
                    showAssetsIcon: true,
                    imagePath: 'comparison',
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  SettingsItem(
                    title: appTranslation(context).my_orders,
                    function: () {
                      navigateTo(context, MyOrdersPage());
                    },
                    icon: FontAwesomeIcons.dropbox,
                    showIcon: false,
                    showAssetsIcon: true,
                    imagePath: 'order',
                  ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  bigDivider(context),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        MainCubit.get(context).changeMode();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SvgPicture.asset(
                            //   'assets/images/$imagePath.svg',
                            //   color: HexColor(grey),
                            //   width: 18.0,
                            // ),

                            Icon(
                              FontAwesomeIcons.adjust,
                              color: HexColor(grey),
                              size: 18.0,
                            ),
                            space10Horizontal,
                            Expanded(
                              child: Text(
                                appTranslation(context).darkMode,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            space20Horizontal,
                            SizedBox(
                              height: 24.0,
                              child: CupertinoSwitch(
                                value: MainCubit.get(context).isDark,
                                onChanged: (value) {
                                  MainCubit.get(context).changeMode();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    myDivider(context),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        MainCubit.get(context).changeLanguage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AssetSvg(
                              imagePath: 'language',
                              color: HexColor(grey),
                              size: 18.0,
                            ),
                            space10Horizontal,
                            Expanded(
                              child: Text(
                                appTranslation(context).changeLanguage,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            space20Horizontal,
                            Text(
                              MainCubit.get(context).isRtl
                                  ? 'تغيير للانجليزية'
                                  : 'Change to Arabic',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: HexColor(secondaryVariantDark),
                                      ),
                            ),
                            space10Horizontal,
                            SizedBox(
                              height: 24.0,
                              child: CupertinoSwitch(
                                value: MainCubit.get(context).isRtl,
                                onChanged: (value) {
                                  MainCubit.get(context).changeLanguage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    myDivider(context),
                  ],
                ),
                // SettingsItem(
                //   title: appTranslation(context).used_market,
                //   function: () {
                //     navigateTo(context, const UsedMarketPage());
                //   },
                //   icon: FontAwesomeIcons.handHoldingUsd,
                //   showIcon: false,
                //   showAssetsIcon: true,
                //   imagePath: 'used',
                // ),
                SettingsItem(
                  title: appTranslation(context).about_us,
                  function: () {
                    navigateTo(context, const AboutUsPage());
                  },
                  icon: FontAwesomeIcons.infoCircle,
                  showIcon: false,
                  showAssetsIcon: true,
                  imagePath: 'info',
                ),
                SettingsItem(
                  title: appTranslation(context).contact_us,
                  function: () {
                    navigateTo(context, ContactUsPage());
                  },
                  icon: FontAwesomeIcons.phoneAlt,
                  showIcon: false,
                  showAssetsIcon: true,
                  imagePath: 'contact_us',
                ),
                SettingsItem(
                  title: appTranslation(context).faq,
                  function: () {
                    navigateTo(context, FAQPage());
                  },
                  icon: FontAwesomeIcons.solidQuestionCircle,
                  showIcon: false,
                  showAssetsIcon: true,
                  imagePath: 'faq',
                ),
                SettingsItem(
                  title: appTranslation(context).news_letter,
                  function: () {
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: MainCubit.get(context).isDark
                                  ? HexColor(secondBackground)
                                  : HexColor(surface),
                            ),
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      appTranslation(context)
                                          .type_yor_email_to_get_news_letter,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color:
                                                HexColor(secondaryVariantDark),
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    space40Vertical,
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      maxLines: 1,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return appTranslation(context)
                                              .email_must_not_be_empty;
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: HexColor(mainColor),
                                            fontWeight: FontWeight.w400,
                                          ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MainCubit.get(context).isDark
                                                ? HexColor(grey)
                                                : secondaryVariant,
                                          ),
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        hintText: appTranslation(context).email,
                                      ),
                                    ),
                                    space20Vertical,
                                    AppButton(
                                        label: appTranslation(context).submit,
                                        onPress: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            MainCubit.get(context).newsLetter(
                                              email: emailController.text,
                                            );
                                          }
                                        }),
                                    space3Vertical,
                                    if (state is NewsLetterLoadingState)
                                      const LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icons.fiber_new_rounded,
                  showIcon: false,
                  showAssetsIcon: true,
                  imagePath: 'news_letter',
                ),
                if (MainCubit.get(context).userSigned &&
                    MainCubit.get(context).myAccountModel != null)
                  SettingsItem(
                    title: appTranslation(context).sign_out,
                    function: () {
                      signOut(context);
                    },
                    icon: FontAwesomeIcons.signOutAlt,
                    sign: false,
                    showIcon: false,
                    showAssetsIcon: true,
                    imagePath: 'sign_out',
                  ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '@medical_empire 2021',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: const SocialBox(image: 'facebook'),
                      // ),
                      // space10Horizontal,
                      // InkWell(
                      //   onTap: () {},
                      //   child: const SocialBox(image: 'google'),
                      // ),
                      // space10Horizontal,
                      // InkWell(
                      //   onTap: () {},
                      //   child: const SocialBox(image: 'twitter'),
                      // ),
                      // space10Horizontal,
                      // InkWell(
                      //   onTap: () {},
                      //   child: const SocialBox(image: 'pinterest'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
