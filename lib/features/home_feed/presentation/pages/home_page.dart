import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/keep_alive_widget.dart';
import 'package:medical_empire_app/features/grid_categories/presentation/pages/grid_categories.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/brands.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/category_data.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/offer_banners.dart';
import 'package:medical_empire_app/features/home_feed/presentation/widgets/slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state){
        if (state is AddComparesSuccessState) {
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: MainCubit.get(context).homeFeedModel != null && MainCubit.get(context).brandsModel != null,
          builder: (context) => KeepAliveWidget(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SliderWidget(
                    images: MainCubit.get(context).homeFeedModel!.data.sliders,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                            ),
                            height: 80.0,
                            child: Image(
                              image: NetworkImage(
                                MainCubit.get(context).homeFeedModel!.data.ads_1,
                              ),
                              width: double.infinity,
                              height: 80.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        space10Horizontal,
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                            ),
                            height: 80.0,
                            child: Image(
                              image: NetworkImage(
                                MainCubit.get(context).homeFeedModel!.data.ads_2,
                              ),
                              width: double.infinity,
                              height: 80.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  space10Vertical,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: SizedBox(
                      height: 100.0,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index)=>  OfferBanner(banners: MainCubit.get(context).homeFeedModel!.data.offersBanners[index],) ,
                        separatorBuilder: (context, index)=> space10Horizontal,
                        itemCount: MainCubit.get(context).homeFeedModel!.data.offersBanners.length,
                      ),
                    ),

                  ),
                  space10Vertical,
                  CategoryDataWidget(
                    title: appTranslation(context).bestOffers,
                    product: MainCubit.get(context)
                        .homeFeedModel!
                        .data
                        .bestOffers,
                  ),
                  space20Vertical,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      height: 100.0,
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(
                          MainCubit.get(context).homeFeedModel!.data.ads_3,
                        ),
                        height: 100.0,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  space10Vertical,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => KeepAliveWidget(
                      child: CategoryDataWidget(
                        title: MainCubit.get(context).isRtl ? MainCubit.get(context)
                            .homeFeedModel!
                            .data
                            .categories[index]
                            .name
                            .ar : MainCubit.get(context)
                            .homeFeedModel!
                            .data
                            .categories[index]
                            .name
                            .en,
                        product: MainCubit.get(context)
                            .homeFeedModel!
                            .data
                            .categories[index]
                            .products,

                        seeMoreClicked: () {
                          navigateTo(
                            context,
                            GridCategories(
                              isCategory: true,
                              categoryName:
                              MainCubit.get(context).isRtl?
                              MainCubit.get(context).homeFeedModel!.data.categories[index].name.ar :
                              MainCubit.get(context).homeFeedModel!.data.categories[index].name.en,
                              id: MainCubit.get(context)
                                  .homeFeedModel!
                                  .data
                                  .categories[index]
                                  .id,
                            ),
                          );
                        },
                        bannerImage: MainCubit.get(context).isRtl ? MainCubit.get(context)
                            .homeFeedModel!
                            .data
                            .categories[index]
                            .bannerImageAr : MainCubit.get(context)
                            .homeFeedModel!
                            .data
                            .categories[index]
                            .bannerImageEn,

                      ),
                    ),
                    itemCount: MainCubit.get(context)
                        .homeFeedModel!
                        .data
                        .categories
                        .length,
                  ),
                  BrandsWidget(
                    brands: MainCubit.get(context).brandsModel!.brands,
                  ),
                  space10Vertical,
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
