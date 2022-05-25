import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/di/injection.dart' as di;
import 'package:medical_empire_app/core/di/injection.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/main/presentation/pages/main_page.dart';

import 'core/network/local/cache_helper.dart';
import 'core/util/bloc_observer.dart';
import 'features/internet_connection/page/internet_connection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isRtl = false;

  await sl<CacheHelper>().get('isRtl').then((value) {
    print('trl ------------- $value');
    if (value != null) {
      isRtl = value;
    }
  });

  String translation =
  await rootBundle.loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  bool isDark = false;


  await sl<CacheHelper>().get('isDark').then((value) {
    print('dark mode ------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  sl<CacheHelper>().get('token').then((value) {
    print('token_---------------------------- $value');
    if (value == null) {
      token = '';
    } else {
      token = value;
    }
  });

  // sl<CacheHelper>().clear('cart');

  sl<CacheHelper>().get('cart').then((value) {
    print('cart ---------------------------- $value');

    if(value != null) {
      cartListData = MainCartModel.fromJson(value).data;

    }
    // CartModel cartModel = CartModel.fromJson(value);

    // print('cart ---------------------------- ${cartListData![0].image}');
    // print('cart ---------------------------- ${cartListData!.length}');
    // print('cart ---------------------------- ${cartListData![0].price}');
  });

  print('dark mode ------------- $isDark');

  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MyApp(
    isDark: isDark,
    isRtl: isRtl,
    translation: translation,
  ));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  final bool isRtl;
  final String translation;

  const MyApp({
    Key? key,
    required this.isDark,
    required this.isRtl,
    required this.translation,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<MainCubit>()
            ..setThemes(
              dark: widget.isDark,
              rtl: widget.isRtl,
            )
            ..changeUser(token!.isNotEmpty)
            ..getHomeFeed()
            ..fillCartMap()
            ..getCategories()
            ..getWishListModel()
            ..getFAQs()
            ..getUsedMarketCatDetails(id: 1)
            ..getAboutUs()
            ..getBrands()
            ..getAccount()
            ..setTranslation(
              translation: widget.translation,
            )
          ..checkInternet()
          ..checkConnectivity(),
        ),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Medical Empire',
            debugShowCheckedModeBanner: false,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: MainCubit.get(context).lightTheme,
            darkTheme: MainCubit.get(context).darkTheme,
            home: MainPage(),
          );
        },
      ),
    );
  }
}
