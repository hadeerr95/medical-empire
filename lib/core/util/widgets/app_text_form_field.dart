import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';

class AppTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final String error;
  final bool isPassword;
  final Function callbackHandle;
  final TextInputType type;

  const AppTextFormField({
    Key? key,
    this.label = '',
    required this.hint,
    this.type = TextInputType.text,
    required this.error,
    this.isPassword = false,
    required this.callbackHandle,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final TextEditingController textEditingController = TextEditingController();
  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    widget.callbackHandle(textEditingController);

    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.label.isNotEmpty)
              Text(
                widget.label,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            if(widget.label.isNotEmpty)
              space10Vertical,
            TextFormField(
              keyboardType: widget.type,
              controller: textEditingController,
              obscureText: widget.isPassword ? isShown : false,
              validator: (String? value) {
                if(value!.isEmpty) {
                  return widget.error;
                }

                return null;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder:   OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                hintText: widget.hint,
                suffixIcon: widget.isPassword ? IconButton(
                  onPressed: () {
                    setState(() {
                      isShown = !isShown;
                    });
                  },
                  icon: Icon(
                    isShown ? Icons.visibility_off : Icons.visibility,
                    color: MainCubit.get(context).isDark? HexColor(grey) : secondaryVariant,
                  ),
                ) : null,
              ),
            ),
          ],
        );
      },
    );
  }
}