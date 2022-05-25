import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/di/injection.dart';
import 'package:medical_empire_app/core/network/local/cache_helper.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_button.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_form_field.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/main/presentation/pages/main_page.dart';
import 'package:medical_empire_app/features/register/presentation/pages/reister_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.simpleModelLogin.token != null) {
            sl<CacheHelper>()
                .put('token', state.simpleModelLogin.token)
                .then((value) {
              token = state.simpleModelLogin.token;
              MainCubit.get(context).changeUser(true);
              navigateAndFinish(context,  MainPage());
            });
          }
        } else if (state is LoginError) {
          showToast(
              message: state.error.toString(), toastStates: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return BackScaffold(
          title: '',
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          appTranslation(context).sign_in,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: HexColor(secondaryVariantDark),
                                    fontWeight: FontWeight.w700,
                                  ),
                          // textAlign: TextAlign.start,
                        ),
                      ),
                      space40Vertical,
                      AppTextFormField(
                        type: TextInputType.emailAddress,
                        hint: appTranslation(context).username_email_address,
                        error: appTranslation(context).username_email_address_empty,
                        callbackHandle: (controller) {
                          usernameController = controller;
                        },
                      ),
                      space10Vertical,
                      AppTextFormField(
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        hint: appTranslation(context).password,
                        error: appTranslation(context).password_empty,
                        callbackHandle: (controller) {
                          passwordController = controller;
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: AppTextButton(
                          label: appTranslation(context).forget_password,
                          onPress: () {},
                        ),
                      ),
                      space10Vertical,
                      BuildCondition(
                        condition: state is LoginLoading,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => AppButton(
                          label: appTranslation(context).sign_in,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              if (!usernameController.text.contains('@')) {
                                showToast(
                                    message: appTranslation(context).your_email_is_unacceptable,
                                    toastStates: ToastStates.ERROR);
                              } else if (passwordController.text.length < 7) {
                                showToast(
                                    message: appTranslation(context).your_password_is_too_short,
                                    toastStates: ToastStates.ERROR);
                              } else {
                                MainCubit.get(context).login(
                                  email: usernameController.text,
                                  password: passwordController.text,
                                );
                              }
                            }
                          },
                        ),
                      ),
                      space20Vertical,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            appTranslation(context).do_have_an_account,
                            textAlign: TextAlign.start,
                          ),
                          AppTextButton(
                            label: appTranslation(context).register_now,
                            onPress: () {
                              navigateTo(context, RegisterPage());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
