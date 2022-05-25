import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/icons_broken.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,

          onTap: (int index) {
            dispatchPages(
              context: context,
              index: index,
            );
          },
          elevation: 20.0,
          unselectedLabelStyle: const TextStyle(
            height: 1.7,
          ),
          selectedLabelStyle: const TextStyle(
            height: 1.7,
          ),
          currentIndex: MainCubit.get(context).currentIndex,
          items:  [
            BottomNavigationBarItem(
              icon:  Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: AssetSvg(
                  color: MainCubit.get(context).currentIndex == 0 ? HexColor(mainColor) : HexColor(grey),
                  imagePath: 'home',
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: AssetSvg(
                  color: MainCubit.get(context).currentIndex == 1 ? HexColor(mainColor) : HexColor(grey),
                  imagePath: 'categories',
                ),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon:  Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: AssetSvg(
                  color: MainCubit.get(context).currentIndex == 2 ? HexColor(mainColor) : HexColor(grey),
                  imagePath: 'cart',
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon:  Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: AssetSvg(
                  color: MainCubit.get(context).currentIndex == 3 ? HexColor(mainColor) : HexColor(grey),
                  imagePath: 'heart',
                ),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: AssetSvg(
                  color: MainCubit.get(context).currentIndex == 4 ? HexColor(mainColor) : HexColor(grey),
                  imagePath: 'user',
                ),
              ),

              label: 'Profile',
            ),
          ],
        );
      },
    );
  }

  void dispatchPages({
    context,
    index,
  }) {
    MainCubit.get(context).bottomChanged(index);
  }
}
