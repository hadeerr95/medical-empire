import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/setting_item.dart';
import 'package:medical_empire_app/core/util/widgets/default_form_field.dart';

class EditAccountPage extends StatefulWidget {
   EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = MainCubit.get(context).myAccountModel!.data.name;
    emailController.text = MainCubit.get(context).myAccountModel!.data.email;
    phoneController.text = MainCubit.get(context).myAccountModel!.data.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if(state is UpdateAccountSuccessState){
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
       return Conditional.single(
            context: context,
            conditionBuilder: (context) => MainCubit.get(context).myAccountModel != null,
            widgetBuilder: (context) => BackScaffold(
              scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: appTranslation(context).edit_account,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if(MainCubit.get(context).imageFile != null)
                          CircleAvatar(
                          radius: 70.0,
                          backgroundImage: FileImage(MainCubit.get(context).imageFile!),
                        ),
                        if(MainCubit.get(context).imageFile == null)
                          CircleAvatar(
                          radius: 70.0,
                          backgroundImage: NetworkImage(MainCubit.get(context).myAccountModel!.data.image),
                        ),
                        space20Horizontal,
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                voidCallback: () {
                                  MainCubit.get(context).selectImage();
                                },
                                color: HexColor(mainColor),
                                text: 'Select photo',
                                radius: 8.0,
                              ),
                              space10Vertical,
                              if(MainCubit.get(context).imageFile != null)
                                MyButton(
                                radius: 8.0,
                                voidCallback: () {
                                  MainCubit.get(context).clearSelectedImage();
                                },
                                color: HexColor(red),
                                text: 'Clear photo',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    space20Vertical,
                    DefaultFormField(
                      title: appTranslation(context).first_name,
                      controller: nameController,

                    ),
                    space4Vertical,
                    DefaultFormField(
                      title:  appTranslation(context).email_address,
                      controller: emailController,
                    ),
                    space4Vertical,
                    DefaultFormField(
                      title:  appTranslation(context).phone_star,
                      controller: phoneController,
                    ),
                    space30Vertical,
                    MyButton(
                      voidCallback: (){
                        MainCubit.get(context).updateAccount(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text
                        );
                      },
                      text:  appTranslation(context).save,
                      color: HexColor(mainColor),
                      radius: 8.0,
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder:(context) => const Center(child: CircularProgressIndicator()),
        );

      },
    );
  }
}
