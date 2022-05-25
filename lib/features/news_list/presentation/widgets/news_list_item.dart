import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/blog_model.dart';
import 'package:medical_empire_app/core/network/end_points.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/news_list/presentation/pages/news_list_deetailed_page.dart';

class NewsListItem extends StatelessWidget {
  final Blog blog;

  const NewsListItem({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            navigateTo(
              context,
              NewsListDetailedPage(
                id: blog.id,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: 192,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:MainCubit.get(context).isDark? HexColor(secondBackground): HexColor(productBackground),
            ),
            child: Row(
              children: [
                Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage('$blogsUrl${blog.image}'),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 192.0,
                  width: 150.0,
                ),
                space20Horizontal,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8.0, vertical: 5),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(5.0),
                      //         color: HexColor(mainColor),
                      //       ),
                      //       child: Text(
                      //         'RUNNING',
                      //         style: Theme.of(context).textTheme.overline!.copyWith(
                      //           color: HexColor(surface),
                      //         ),
                      //       ),
                      //     ),
                      //     space10Horizontal,
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8.0, vertical: 5),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(5.0),
                      //         color: HexColor(mainColor),
                      //       ),
                      //       child: Text(
                      //         'TRAINING',
                      //         style: Theme.of(context).textTheme.overline!.copyWith(
                      //           color: HexColor(surface),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // space20Vertical,
                      Text(
                        blog.title.en,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'May 20,2021',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: HexColor(secondaryVariantDark),
                        ),
                      ),
                      // space20Vertical,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Icon(
                      //       Icons.chat_bubble_outline_rounded,
                      //       color: HexColor(blueGrey),
                      //       size: 14,
                      //     ),
                      //     space6Horizontal,
                      //     Text(
                      //       '23',
                      //       maxLines: 1,
                      //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      //             color: HexColor(blueGrey),
                      //           ),
                      //     ),
                      //   ],
                      // ),
                    ],
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
