import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/review/presentation/widget/review_text_form_field.dart';

class AddReviewPage extends StatelessWidget {
   AddReviewPage({Key? key}) : super(key: key);
  final reviewTextController =  TextEditingController();
  double starRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {
        if(state is AddReviewSuccessState){
          showToast(message: state.message, toastStates: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, state) {
        return  BackScaffold(
          title: appTranslation(context).reviews,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 46.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image:  DecorationImage(
                              image: NetworkImage(
                                MainCubit.get(context).productFeedModel!.data.product.image,
                              ),
                            )
                        ),
                      ),
                      space10Horizontal,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MainCubit.get(context).productFeedModel!.data.product.name.en,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: HexColor(grey),
                              ),
                            ),
                            Text(
                              '${appTranslation(context).egp} ${MainCubit.get(context).productFeedModel!.data.product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider(context),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appTranslation(context).tab_to_star,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: HexColor(grey),
                        ),
                      ),
                      space10Vertical,
                      RatingBar.builder(
                        updateOnDrag: false,
                        initialRating: 0 ,
                        minRating: 1,
                        itemSize: 25.0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) =>  Icon(
                          Icons.star,
                          color:HexColor(secondColor),
                        ),
                        onRatingUpdate: (rating) {
                          starRating = rating;

                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appTranslation(context).write__rating_here,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      ReviewTextFormField(
                        controller: reviewTextController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyButton(
                      voidCallback: (){
                        // print('-----------Rating*********$starRating');
                        MainCubit.get(context).addReview(
                            productId: MainCubit.get(context).productFeedModel!.data.product.id,
                            rating: starRating,
                            review: reviewTextController.text,
                        );
                      },
                      text: appTranslation(context).submit,
                      color: HexColor(mainColor),
                    radius: 8.0,
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
