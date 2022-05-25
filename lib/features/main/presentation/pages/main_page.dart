import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/asset_svg.dart';
import 'package:medical_empire_app/core/util/widgets/list_item_drawer.dart';
import 'package:medical_empire_app/core/util/widgets/main_scaffold.dart';
import 'package:medical_empire_app/core/util/widgets/my_button.dart';
import 'package:medical_empire_app/core/util/widgets/my_theme_icon.dart';
import 'package:medical_empire_app/core/util/widgets/setting_item.dart';
import 'package:medical_empire_app/features/about_us/presentation/pages/about_us.dart';
import 'package:medical_empire_app/features/categories/presentation/pages/categories_demo.dart';
import 'package:medical_empire_app/features/cotatct_us/presentation/pages/contact_us.dart';
import 'package:medical_empire_app/features/faq/presentation/pages/faq_page.dart';
import 'package:medical_empire_app/features/home_feed/presentation/pages/home_page.dart';
import 'package:medical_empire_app/features/internet_connection/page/internet_connection_page.dart';
import 'package:medical_empire_app/features/login/presentation/pages/login_page.dart';
import 'package:medical_empire_app/features/main/presentation/pages/cart_page.dart';
import 'package:medical_empire_app/features/news_list/presentation/pages/news_list_page.dart';
import 'package:medical_empire_app/features/notification/page/notification_screen.dart';
import 'package:medical_empire_app/features/search/page/search_page.dart';
import 'package:medical_empire_app/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:medical_empire_app/features/wishlist/presentation/pages/wishlist_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    MainCubit.get(context).pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              !MainCubit.get(context).noInternetConnection,
          widgetBuilder: (context) => MainScaffold(
            scaffold: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const MyThemeIcon(
                      path: 'menu',
                    )),
                actions: [
                  IconButton(
                    onPressed: () {
                      if(MainCubit.get(context).userSigned){
                        MainCubit.get(context).getNotification();
                        navigateTo(context, const NotificationScreen());
                      }else{
                        showToast(toastStates: ToastStates.WARNING, message: appTranslation(context).please_login_to_get_notifications);
                        navigateTo(context, LoginPage());
                      }

                    },
                    icon: const MyThemeIcon(
                      path: 'notification',
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchPage());
                      },
                      icon: const MyThemeIcon(
                        path: 'search',
                      )),
                ],
                centerTitle: false,
                titleSpacing: 20.0,
                title: Image(
                  height: 60.0,
                  width: 60.0,
                  color: MainCubit.get(context).isDark ? HexColor(white) : null,
                  image: const AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              body: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: MainCubit.get(context).pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const HomePage(),
                            const SectionsScreen(),
                            CartPage(),
                            const WishlistPage(),
                            ProfilePage(),
                          ],
                          // onPageChanged: (index) {
                          //   MainCubit.get(context).bottomChanged(index);
                          // },
                        ),
                      ),
                      if (MainCubit.get(context).isDark) myDivider(context),
                    ],
                  );
                },
              ),
              drawer: Drawer(
                child: SafeArea(
                  child: BlocBuilder<MainCubit, MainState>(
                    builder: (context, state) {
                      return Container(
                        color: MainCubit.get(context).isDark
                            ? HexColor(
                                MainCubit.get(context).scaffoldBackground)
                            : null,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!MainCubit.get(context).userSigned ||
                                  MainCubit.get(context).myAccountModel == null)
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MyButton(
                                          voidCallback: () {
                                            navigateTo(context, LoginPage());
                                          },
                                          text: appTranslation(context).sign_in,
                                          color: HexColor(mainColor),
                                          radius: 8.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (MainCubit.get(context).userSigned &&
                                  MainCubit.get(context).myAccountModel != null)
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                          MainCubit.get(context)
                                              .myAccountModel!
                                              .data
                                              .image,
                                        ),
                                      ),
                                      space10Vertical,
                                      if (MainCubit.get(context)
                                              .myAccountModel !=
                                          null)
                                        Text(
                                          MainCubit.get(context)
                                              .myAccountModel!
                                              .data
                                              .name,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      space3Vertical,
                                      if (MainCubit.get(context)
                                              .myAccountModel !=
                                          null)
                                        Text(
                                          MainCubit.get(context)
                                              .myAccountModel!
                                              .data
                                              .email,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     signOut(context);
                                      //   },
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         vertical: 10.0),
                                      //     child: Row(
                                      //       children: [
                                      //         SvgPicture.asset(
                                      //           'assets/images/sign_out.svg',
                                      //           color: secondaryVariant,
                                      //         ),
                                      //         space10Horizontal,
                                      //         Text(
                                      //           appTranslation(context).sign_out,
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodyText1!
                                      //               .copyWith(
                                      //                 color: HexColor(grey),
                                      //               ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 14.0, top: 10.0),
                                    child: Text(
                                      appTranslation(context).category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  space10Vertical,
                                  if (MainCubit.get(context).categoriesModel !=
                                      null)
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          ListItemDrawer(
                                        model: MainCubit.get(context)
                                            .categoriesModel!
                                            .data
                                            .categoriesList[index],
                                      ),
                                      itemCount: MainCubit.get(context)
                                          .categoriesModel!
                                          .data
                                          .categoriesList
                                          .length,
                                    ),
                                  space40Vertical,
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 14.0, top: 10.0),
                                child: Text(
                                  appTranslation(context).help_info,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                              space10Vertical,
                              Column(
                                children: [
                                  SettingsItem(
                                    function: () {
                                      navigateTo(context, const NewsListPage());
                                      //Navigator.pop(context);
                                    },
                                    title: appTranslation(context).blogs,
                                    icon: FontAwesomeIcons.blog,
                                    sign: false,
                                    showIcon: false,
                                    showAssetsIcon: true,
                                    imagePath: 'blogs',
                                  ),
                                  SettingsItem(
                                    function: () {
                                      navigateTo(context, const AboutUsPage());
                                    },
                                    title: appTranslation(context).about_us,
                                    icon: FontAwesomeIcons.info,
                                    sign: false,
                                    showIcon: false,
                                    showAssetsIcon: true,
                                    imagePath: 'info',
                                  ),
                                  SettingsItem(
                                    function: () {
                                      navigateTo(context, ContactUsPage());
                                    },
                                    title: appTranslation(context).contact_us,
                                    icon: FontAwesomeIcons.tag,
                                    sign: false,
                                    showIcon: false,
                                    showAssetsIcon: true,
                                    imagePath: 'contact_us',
                                  ),
                                  SettingsItem(
                                    function: () {
                                      navigateTo(context, FAQPage());
                                    },
                                    title: appTranslation(context).faq,
                                    icon: FontAwesomeIcons.umbrella,
                                    sign: false,
                                    showIcon: false,
                                    showAssetsIcon: true,
                                    imagePath: 'faq',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    onTap: (int index) {
                      MainCubit.get(context).bottomChanged(index);
                    },
                    elevation: 20.0,
                    unselectedLabelStyle: TextStyle(
                      color: HexColor(grey),
                      height: 1.7,
                    ),
                    selectedLabelStyle: const TextStyle(
                      height: 1.7,
                    ),
                    currentIndex: MainCubit.get(context).currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: MainCubit.get(context).currentIndex == 0
                                ? HexColor(mainColor)
                                : HexColor(grey),
                            imagePath: 'home',
                          ),
                        ),
                        label: appTranslation(context).home,
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: MainCubit.get(context).currentIndex == 1
                                ? HexColor(mainColor)
                                : HexColor(grey),
                            imagePath: 'categories',
                          ),
                        ),
                        label: appTranslation(context).categories,
                      ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [

                            Padding(
                              padding: const EdgeInsetsDirectional.only(top: 10.0, start: 6.0, end: 6.0),
                              child: AssetSvg(
                                color: MainCubit.get(context).currentIndex == 2
                                    ? HexColor(mainColor)
                                    : HexColor(grey),
                                imagePath: 'cart',
                              ),
                            ),
                            CircleAvatar(
                              radius: 8.0,
                              backgroundColor: HexColor(red),
                              child: Text(
                                MainCubit.get(context).cartMap.length > 9
                                    ? '+9'
                                    : MainCubit.get(context)
                                    .cartMap
                                    .length
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: HexColor(white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        label: appTranslation(context).cart,
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: MainCubit.get(context).currentIndex == 3
                                ? HexColor(mainColor)
                                : HexColor(grey),
                            imagePath: 'heart',
                          ),
                        ),
                        label: appTranslation(context).wishlist,
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: AssetSvg(
                            color: MainCubit.get(context).currentIndex == 4
                                ? HexColor(mainColor)
                                : HexColor(grey),
                            imagePath: 'user',
                          ),
                        ),
                        label: appTranslation(context).profile,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          fallbackBuilder: (context) => const InternetConnectionPage(),
        );
      },
    );
  }
}
