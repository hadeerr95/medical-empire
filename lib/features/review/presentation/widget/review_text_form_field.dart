import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  const ReviewTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w700
      ),
    );
  }
}
