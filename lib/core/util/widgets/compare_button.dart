import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';

import '../constants.dart';
import 'asset_svg.dart';

class CompareButton extends StatelessWidget {
  final int id;

  const CompareButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return SizedBox(
          height: 40.0,
          width: 40.0,
          child: IconButton(
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.repeat_rounded,
                size: 14.0,
                color: HexColor(surface),
              ),
            ),
            padding: EdgeInsets.zero,
            alignment: AlignmentDirectional.topEnd,
            onPressed: () {
              if(MainCubit.get(context).userSigned){
                MainCubit.get(context).addCompares(
                  productId: id,
                );
              }else{
                showToast(toastStates: ToastStates.WARNING, message: appTranslation(context).please_login_to_compare);
                navigateTo(context, LoginPage());
              }

            },
          ),
        );
      },
    );
  }
}