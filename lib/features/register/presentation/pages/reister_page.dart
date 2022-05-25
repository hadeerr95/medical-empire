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
import 'package:medical_empire_app/core/util/widgets/app_text_form_field.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/main/presentation/pages/main_page.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          if (state.simpleModelRegister.token != null) {
            sl<CacheHelper>()
                .put('token', state.simpleModelRegister.token)
                .then((value) {
              token = state.simpleModelRegister.token;
              MainCubit.get(context).changeUser(true);
              navigateAndFinish(context,  MainPage());
            });
          }
        }

        if (state is Error) {
          showToast(message: appTranslation(context).error_phone, toastStates: ToastStates.ERROR,);
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
                          appTranslation(context).register,
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
                        type: TextInputType.text,
                        hint: appTranslation(context).name,
                        error: appTranslation(context).name_must_not_be_empty,
                        callbackHandle: (controller) {
                          nameController = controller;
                        },
                      ),
                      space10Vertical,
                      AppTextFormField(
                        type: TextInputType.phone,
                        hint: appTranslation(context).phone,
                        error: appTranslation(context).phone_must_not_be_empty,
                        callbackHandle: (controller) {
                          phoneController = controller;
                        },
                      ),
                      // CountryPickerFormField(
                      //   hint: 'Phone number',
                      //   controller: phoneController,
                      // ),
                      space10Vertical,
                      AppTextFormField(
                        type: TextInputType.emailAddress,
                        hint: appTranslation(context).email,
                        error: appTranslation(context).email_must_not_be_empty,
                        callbackHandle: (controller) {
                          emailController = controller;
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
                      space10Vertical,
                      AppTextFormField(
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        hint: appTranslation(context).confirm_password,
                        error: appTranslation(context).confirm_password_empty,
                        callbackHandle: (controller) {
                          confirmPasswordController = controller;
                        },
                      ),

                      space20Vertical,
                      BuildCondition(
                        condition: state is RegisterLoading,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => AppButton(
                          label: appTranslation(context).register,
                          onPress: () {
                            if (formKey.currentState!.validate()) {

                              if (!emailController.text.contains('@')) {
                                showToast(
                                    message: appTranslation(context).your_email_is_unacceptable,
                                    toastStates: ToastStates.ERROR);
                              }
                              else if (passwordController.text.length < 7) {
                                showToast(
                                    message: appTranslation(context).your_password_is_too_short,
                                    toastStates: ToastStates.ERROR);
                              }
                              else {
                                MainCubit.get(context).register(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                );
                              }
                            }
                          },
                        ),
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
