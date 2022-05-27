import 'package:flutter/material.dart';

import '../constants.dart';
import 'default_form_field.dart';

class UserAccountDetailsWidget extends StatelessWidget {
  final TextEditingController nameController;

  final TextEditingController emailController;

  final TextEditingController phoneController;

  const UserAccountDetailsWidget(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultFormField(
          title: appTranslation(context).first_name,
          controller: nameController,
        ),
        space4Vertical,
        DefaultFormField(
          title: appTranslation(context).email_address,
          controller: emailController,
        ),
        space4Vertical,
        DefaultFormField(
          title: appTranslation(context).phone_star,
          controller: phoneController,
        ),
      ],
    );
  }
}
