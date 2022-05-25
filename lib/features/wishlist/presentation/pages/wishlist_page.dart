import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/core/util/widgets/empty_widget.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/widgets/list_of_products.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state){
        if (state is AddComparesSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        return KeepAliveWidget(
          child: BuildCondition(
            condition: MainCubit.get(context).userSigned,
            builder: (context) => Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
                  MainCubit.get(context).wishlistModel != null,
              widgetBuilder: (BuildContext context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    if (MainCubit.get(context).wishlistModel!.products.isEmpty) {
                      return EmptyWidget(
                        text: appTranslation(context).please_login_to_add_or_remove_from_wish_list,
                      );
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ListOfProducts(
                            products: MainCubit.get(context)
                                .wishlistModel!
                                .products[index],
                          ),
                          separatorBuilder: (context, index) => myDivider(context),
                          itemCount: MainCubit.get(context)
                              .wishlistModel!
                              .products
                              .length,
                        ),
                      );
                    }
                  }),
                ],
              ),
              fallbackBuilder: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            fallback: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 50.0,
                  color: HexColor(mainColor),
                ),
                space20Vertical,
                Text(
                  'Please login to add or remove from wish list',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                space20Vertical,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100.0,
                  ),
                  child: MyButton(
                    voidCallback: () {
                      navigateTo(context, LoginPage());
                    },
                    text: 'Sign in',
                    color: HexColor(mainColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
