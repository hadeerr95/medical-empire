import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';

class DefaultFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  FormFieldValidator? validator;
  bool dropListShow;
  bool enable;
  CitiesModel? governorate;
  ValueChanged? onChanged;
  bool readOnly;
  List<DropdownMenuItem<String>>? items;
  final bool isPassword;

  DefaultFormField({
    Key? key,
    required this.title,
    required this.controller,
    this.governorate,
    this.validator,
    this.dropListShow = false,
    this.enable = true,
    this.readOnly = false,
    this.onChanged,
    this.items,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? isShown : false,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: HexColor(black),
                  ),
              validator: widget.validator,
              enabled: widget.enable,
              readOnly: widget.readOnly,
              cursorColor: HexColor(black),
              decoration: InputDecoration(
                labelText: widget.title,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainCubit.get(context).isDark
                        ? HexColor(grey)
                        : secondaryVariant,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor(darkWhite),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor(darkWhite),
                  ),
                ),
                labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                suffixIcon: widget.dropListShow
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        child: DropdownButton<String>(
                          icon: AssetSvg(imagePath: 'polygon_down2'),
                          elevation: 0,
                          isDense: false,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: HexColor(black),
                              ),
                          onChanged: widget.onChanged,
                          items: widget.items,
                        ),
                      )
                    : widget.isPassword
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isShown = !isShown;
                              });
                            },
                            icon: Icon(
                              isShown ? Icons.visibility_off : Icons.visibility,
                              color: MainCubit.get(context).isDark
                                  ? HexColor(grey)
                                  : secondaryVariant,
                            ),
                          )
                        : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
