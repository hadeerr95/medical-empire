import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/di/injection.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';

class NewsListDetailedPage extends StatelessWidget {
  const NewsListDetailedPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

//   @override
//   State<NewsListDetailedPage> createState() => _NewsListDetailedPageState();
// }
// class _NewsListDetailedPageState extends State<NewsListDetailedPage> {
//   @override
//   void initState() {
//     super.initState();
//     MainCubit.get(context).getBlogDetails(id: widget.id);
//   }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<MainCubit>()..getBlogDetails(id: id),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return BackScaffold(
            actionIcon: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mode_comment_outlined,
                    color: HexColor(black),
                    size: 20.0,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    color: HexColor(black),
                    size: 20.0,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share_outlined,
                    color: HexColor(black),
                    size: 20.0,
                  ),
                ),
              ],
            ),
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: BuildCondition(
              condition: MainCubit.get(context).bLogDetailsModel != null,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: HexColor(mainColor),
                            ),
                            child: Text(
                              'RUNNING',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                    color: HexColor(surface),
                                  ),
                            ),
                          ),
                          space10Horizontal,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: HexColor(mainColor),
                            ),
                            child: Text(
                              'TRAINING',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                    color: HexColor(surface),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        MainCubit.get(context).bLogDetailsModel!.blog.title.en,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: HexColor(secondaryVariantDark),
                            ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Image(
                        image: NetworkImage(
                            '$blogsUrl${MainCubit.get(context).bLogDetailsModel!.blog.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Align(
                    //   alignment: AlignmentDirectional.topEnd,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 15.0, vertical: 5.0),
                    //     child: Text(
                    //       'May 20, 2021',
                    //       maxLines: 1,
                    //       style:
                    //           Theme.of(context).textTheme.bodyText1!.copyWith(
                    //                 color: HexColor(blueGrey),
                    //               ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. a piece of classical Latin lita piece of classical Latin literature from 45 BC, making it over 2000 years ola piece of classical Latin litea piece of classical Latin literature from 45 BC, making it over 2000 years ola piece of classical Latin literature from 45 BC, making it over 2000 years olrature from 45 BC, making it over 2000 years olerature from 45 BC, making it over 2000 years olRichard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: HexColor(secondaryVariantDark),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
