import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';

import '../constants.dart';
import 'asset_svg.dart';

class WishListButton extends StatelessWidget {
  final int id;

  const WishListButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Column(
          children: [
            if (MainCubit.get(context).wishlistModel != null)
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey[300],
                    child: AssetSvg(
                      color: HexColor(mainColor),
                      imagePath: MainCubit.get(context).wishlistId.contains(id)
                          ? 'heart_solid'
                          : 'heart',
                      size: 16.0,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (MainCubit.get(context).userSigned) {
                      MainCubit.get(context)
                          .addToWishList(productId: id, context: context);
                    } else {
                      showToast(
                          toastStates: ToastStates.WARNING,
                          message: appTranslation(context)
                              .please_login_to_add_or_remove_from_wish_list);
                    }
                  },
                ),
              ),

            // IconButton(
            //   icon: AssetSvg(
            //     color: HexColor(mainColor),
            //     imagePath: MainCubit.get(context).wishlistId.contains(id)? 'heart_solid' : 'heart',
            //     size: 16.0,
            //   ),
            //   padding: EdgeInsets.zero,
            //   onPressed: () {
            //     MainCubit.get(context).addToWishList(productId: id);
            //   },
            // ),
            if (MainCubit.get(context).wishlistModel == null)
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  icon: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey[300],
                    child: AssetSvg(
                      color: HexColor(mainColor),
                      imagePath: 'heart',
                      size: 16.0,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showToast(
                        toastStates: ToastStates.WARNING,
                        message: appTranslation(context)
                            .please_login_to_add_or_remove_from_wish_list);
                    navigateTo(context, LoginPage());
                    MainCubit.get(context).emit(SignOutState());
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
