import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/empty_widget.dart';
import 'package:medical_empire_app/features/comparisins/widget/comparison_details_item.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if(state is RemoveComparesSuccessState){
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        return BackScaffold(
          title: appTranslation(context).comparisons,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Conditional.single(
              context: context,
              conditionBuilder: (context) => MainCubit.get(context).comparesModel!= null ,
              widgetBuilder: (context) =>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    if(state is RemoveComparesLoadingState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          space10Vertical,
                        ],
                      ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (context)=> MainCubit.get(context).comparesModel!.compares.isNotEmpty,
                        widgetBuilder: (context)=> Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>  ComparisonsDetailsItem(model: MainCubit.get(context).comparesModel!.compares[index],),
                            separatorBuilder: (context, index) => space20Vertical,
                            itemCount:  MainCubit.get(context).comparesModel!.compares.length,
                          ),
                        ),
                        fallbackBuilder: (context)=>  EmptyWidget(text: appTranslation(context).add_some_products_to_comparison),
                    ),
                  ],
                ),
              ),
              fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
