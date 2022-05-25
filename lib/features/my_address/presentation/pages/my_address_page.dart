import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/icons_broken.dart';
import 'package:medical_empire_app/core/util/widgets/app_button.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/app_text_form_field.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/default_text_button.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/region_picker_form_field.dart';
import 'package:medical_empire_app/features/my_address/presentation/widget/address_item.dart';
import 'package:medical_empire_app/features/shipping_address/presentation/pages/address_shipping_page.dart';

class MyAddressPage extends StatelessWidget {

  const MyAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if(state is DeleteAddressSuccessState){
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        return BackScaffold(
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: appTranslation(context).my_addresses,
          body: Conditional.single(
              context: context,
              conditionBuilder: (context)=> MainCubit.get(context).addressFeedModel != null,
              widgetBuilder: (context)=> Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children:  [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>  AddressItem(
                          userModel: MainCubit.get(context).addressFeedModel!.data.user,
                          address:  MainCubit.get(context).addressFeedModel!.data.addresses![index],
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top:  14.0),
                          child: Container(
                            width: double.infinity,
                            height: 4.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: MainCubit.get(context).addressFeedModel!.data.addresses!.length,
                      ),
                    ),
                  ],
                ),
              ),
              fallbackBuilder: (context)=> const Center(child: CircularProgressIndicator()),
          ),
          floatingButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddressShippingPage(governmentModel: MainCubit.get(context).addressFeedModel!.data.governorates!,));
            },
            child: const Icon(Icons.add),
            backgroundColor: HexColor(mainColor),
          ),
        );
      },
    );
  }
}
