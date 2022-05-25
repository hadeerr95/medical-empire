import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/features/review/presentation/page/add_review_page.dart';
import 'package:medical_empire_app/features/review/presentation/widget/line_rate_item.dart';
import 'package:medical_empire_app/features/review/presentation/widget/review_list_item.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return  BackScaffold(
          title: appTranslation(context).reviews,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Row(
                      //           children: [
                      //             Column(
                      //               children: [
                      //                 CircleAvatar(
                      //                   radius: 43.0,
                      //                   backgroundColor: HexColor(thirdColor),
                      //                   child:  CircleAvatar(
                      //                     radius: 40.0,
                      //                     backgroundColor: HexColor(white),
                      //                     child: Text(
                      //                       '4.45',
                      //                       style: Theme.of(context).textTheme.headline5!.copyWith(
                      //                         fontWeight: FontWeight.w700,
                      //                         color: HexColor(thirdColor),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 space5Vertical,
                      //                 Text(
                      //                   '9 reviews',
                      //                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      //                     color: HexColor(grey),
                      //                   ),
                      //                 ),
                      //                 RatingBar.builder(
                      //                   ignoreGestures: true,
                      //                   tapOnlyMode: true,
                      //                   updateOnDrag: false,
                      //                   initialRating: 4.45,
                      //                   minRating: 1,
                      //                   itemSize: 16.0,
                      //                   direction: Axis.horizontal,
                      //                   allowHalfRating: true,
                      //                   itemCount: 5,
                      //                   itemBuilder: (context, _) =>  Icon(
                      //                     Icons.star,
                      //                     color:HexColor(secondColor),
                      //                   ),
                      //                   onRatingUpdate: (rating) {
                      //                     // print(rating);
                      //                   },
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Row(
                      //           children: [
                      //             Column(
                      //               children: const [
                      //                 LineRateItem(
                      //                     starNum: '5',
                      //                     progressText: '78',
                      //                     progress: 0.78
                      //                 ),
                      //                 space10Vertical,
                      //                 LineRateItem(
                      //                     starNum: '4',
                      //                     progressText: '12',
                      //                     progress: 0.12,
                      //                 ),
                      //                 space10Vertical,
                      //                 LineRateItem(
                      //                   starNum: '3',
                      //                   progressText: '33',
                      //                   progress: 0.33,
                      //                 ),
                      //                 space10Vertical,
                      //                 LineRateItem(
                      //                   starNum: '2',
                      //                   progressText: '22',
                      //                   progress: 0.22,
                      //                 ),
                      //                 space10Vertical,
                      //                 LineRateItem(
                      //                   starNum: '1',
                      //                   progressText: '11',
                      //                   progress: 0.11,
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const Divider(),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) => MainCubit.get(context).productFeedModel!.data.product.reviews != null,
                          widgetBuilder: (context) => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>  ReviewListItem(model: MainCubit.get(context).productFeedModel!.data.product.reviews![index]),
                            separatorBuilder: (context, index) => myDivider(context),
                            itemCount: MainCubit.get(context).productFeedModel!.data.product.reviews!.length,
                          ),
                          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: MyButton(
                  voidCallback: (){
                    navigateTo(context, AddReviewPage());
                  },
                  text:  appTranslation(context).write_review,
                  color: HexColor(mainColor),
                  radius: 8.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
