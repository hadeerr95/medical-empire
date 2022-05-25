import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/news_list/presentation/widgets/news_list_item.dart';
import 'package:medical_empire_app/features/search/page/search_page.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();

    MainCubit.get(context).getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      actionIcon: IconButton(
        onPressed: () {
          navigateTo(context, SearchPage());
        },
        icon: Icon(
          Icons.search,
          color: HexColor(black),
        ),
      ),
      title: 'Blogs',
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is BlogsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => NewsListItem(
                blog:
                    MainCubit.get(context).bLogModel!.data.blog[index],
              ),
              separatorBuilder: (context, index) => space10Vertical,
              itemCount: MainCubit.get(context).bLogModel!.data.blog.length,
            ),
          );
        },
      ),
    );
  }
}
