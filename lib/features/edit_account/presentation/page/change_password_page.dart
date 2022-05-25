import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/default_form_field.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final oldPasswordController = TextEditingController();

  final newPasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if (state is ChangePasswordSuccess) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
          signOut(context);
          navigateAndFinish(context, LoginPage());
        }
      },
      builder: (BuildContext context, state) {
        return BackScaffold(
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: appTranslation(context).change_password,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space20Vertical,
                    DefaultFormField(
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return appTranslation(context)
                              .old_password_cant_be_empty;
                        }
                      },
                      title: appTranslation(context).old_password,
                      controller: oldPasswordController,
                    ),
                    space4Vertical,
                    DefaultFormField(
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return appTranslation(context)
                              .new_password_cant_be_empty;
                        }
                      },
                      title: appTranslation(context).new_password,
                      controller: newPasswordController,
                    ),
                    space4Vertical,
                    DefaultFormField(
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return appTranslation(context)
                              .confirm_password_cant_be_empty;
                        }
                      },
                      title: appTranslation(context).confirm_password,
                      controller: confirmPasswordController,
                    ),
                    space30Vertical,
                    BuildCondition(
                      condition: state is! ChangePasswordLoading,
                      builder: (context) => MyButton(
                        voidCallback: () {
                          if (formKey.currentState!.validate()) {
                            if (oldPasswordController.text.length > 7 &&
                                newPasswordController.text.length > 7 &&
                                confirmPasswordController.text.length > 7) {
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                MainCubit.get(context).changePassword(
                                  oldPassword: oldPasswordController.text,
                                  newPassword: newPasswordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                );
                              } else {
                                showToast(
                                    message: appTranslation(context)
                                        .make_sure_that_you_write_the_same_password,
                                    toastStates: ToastStates.ERROR);
                              }
                            } else {
                              showToast(
                                  message: appTranslation(context)
                                      .your_password_is_too_short,
                                  toastStates: ToastStates.ERROR);
                            }
                          }
                        },
                        text: appTranslation(context).save,
                        color: HexColor(mainColor),
                        radius: 8.0,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        // return Conditional.single(
        //   context: context,
        //   conditionBuilder: (context) =>
        //       MainCubit.get(context).myAccountModel != null,
        //   widgetBuilder: (context) => BackScaffold(
        //     scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //     title: appTranslation(context).change_password,
        //     body: SingleChildScrollView(
        //       physics: const BouncingScrollPhysics(),
        //       child: Padding(
        //         padding: const EdgeInsets.all(20.0),
        //         child: Form(
        //           key: formKey,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               space20Vertical,
        //               DefaultFormField(
        //                 validator: (value) {
        //                   if (value!.isEmpty) {
        //                     return appTranslation(context)
        //                         .old_password_cant_be_empty;
        //                   }
        //                 },
        //                 title: appTranslation(context).old_password,
        //                 controller: oldPasswordController,
        //               ),
        //               space4Vertical,
        //               DefaultFormField(
        //                 validator: (value) {
        //                   if (value!.isEmpty) {
        //                     return appTranslation(context)
        //                         .new_password_cant_be_empty;
        //                   }
        //                 },
        //                 title: appTranslation(context).new_password,
        //                 controller: newPasswordController,
        //               ),
        //               space4Vertical,
        //               DefaultFormField(
        //                 validator: (value) {
        //                   if (value!.isEmpty) {
        //                     return appTranslation(context)
        //                         .confirm_password_cant_be_empty;
        //                   }
        //                 },
        //                 title: appTranslation(context).confirm_password,
        //                 controller: confirmPasswordController,
        //               ),
        //               space30Vertical,
        //               MyButton(
        //                 voidCallback: () {
        //                   if (formKey.currentState!.validate()) {
        //                     MainCubit.get(context).changePassword(
        //                         oldPassword: oldPasswordController.text,
        //                         newPassword: newPasswordController.text,
        //                         confirmPassword: confirmPasswordController.text);
        //                   }
        //                 },
        //                 text: appTranslation(context).save,
        //                 color: HexColor(mainColor),
        //                 radius: 8.0,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //   fallbackBuilder: (context) =>
        //       const Center(child: CircularProgressIndicator()),
        // );
      },
    );
  }
}
