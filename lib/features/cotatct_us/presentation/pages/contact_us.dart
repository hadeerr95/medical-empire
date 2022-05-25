import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/app_button.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state){
        if (state is ContactUsSuccessState) {
          showToast(
              message:
              '${state.message}',
              toastStates: ToastStates.SUCCESS);
          print('${state.message} test print');
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          subjectController.clear();
          messageController.clear();
        }
      },
      builder: (context, state) {
        return BackScaffold(
          title: appTranslation(context).contact_us,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appTranslation(context).get_in_touch,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: HexColor(secondaryVariantDark),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    space10Vertical,
                    Text(
                      appTranslation(context).contact_us_partnerships,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: HexColor(secondaryVariantDark),
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                          ),
                    ),
                    space40Vertical,
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        maxLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return appTranslation(context).name_must_not_be_empty;
                          } else {
                            return null;
                          }
                        },
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: HexColor(mainColor),
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          hintText: appTranslation(context).name,
                        ),
                      ),
                    ),
                    space10Vertical,
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        maxLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return appTranslation(context).email;
                          } else {
                            return null;
                          }
                        },
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: HexColor(mainColor),
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          hintText: appTranslation(context).email,
                        ),
                      ),
                    ),
                    space10Vertical,
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        maxLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return appTranslation(context).phone_must_not_be_empty;
                          } else {
                            return null;
                          }
                        },
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: HexColor(mainColor),
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          hintText: appTranslation(context).phone,
                        ),
                      ),
                    ),
                    space10Vertical,
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: TextFormField(
                        controller: subjectController,
                        maxLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return appTranslation(context).subject_must_not_be_empty;
                          } else {
                            return null;
                          }
                        },
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: HexColor(mainColor),
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          hintText: appTranslation(context).subject,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    space10Vertical,
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: messageController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return appTranslation(context).message_must_not_be_empty;
                          } else {
                            return null;
                          }
                        },
                        maxLines: 7,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: HexColor(mainColor),
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          hintText: appTranslation(context).message,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                            ),
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    space30Vertical,
                    AppButton(
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          MainCubit.get(context).contactUs(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            subject: subjectController.text,
                            message: messageController.text,
                          );
                        }
                      },
                      label: appTranslation(context).submit,
                    ),
                    space5Vertical,
                    if (state is ContactUsLoadingState)
                      const LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
