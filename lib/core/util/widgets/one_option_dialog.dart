import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';

import '../constants.dart';
import 'default_text_button.dart';
import 'dialog_button.dart';

class OneOptionDialog extends Dialog {
  // final String title;
  final String message;
  final String popButtonText;
  final VoidCallback popButtonVoidCallback;
  double height;

  OneOptionDialog({
    // required this.title,
    required this.message,
    required this.popButtonText,
    required this.popButtonVoidCallback,
    this.height = 140.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: HexColor(greyWhite),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Text(
              //   title,
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //         color: HexColor(red),
              //         fontWeight: FontWeight.bold,
              //       ),
              // ),
              // space10Vertical,
              space10Vertical,
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: HexColor(secondary),
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      child: MyButton(voidCallback: popButtonVoidCallback, text: popButtonText, color: HexColor(surface), textColor: HexColor(mainColor),),
                    ),
                  ),

                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
