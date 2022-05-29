import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/di/injection.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/network/local/cache_helper.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/translation.dart';
import 'package:medical_empire_app/features/categories/presentation/pages/categories_demo.dart';
import 'package:medical_empire_app/features/home_feed/presentation/pages/home_page.dart';
import 'package:medical_empire_app/features/main/presentation/pages/cart_page.dart';
import 'package:medical_empire_app/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:medical_empire_app/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:url_launcher/url_launcher.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

const String mainColor = '005C89';
const String secondary = '005C89';
const String secondColor = 'da7339';
const String thirdColor = '1da1f2';
const String darkWhite = 'e0e0e0';
const String black = '#5E5F61';
const Color secondaryVariant = Color.fromRGBO(33, 36, 36, 0.7);
const String productBackground = '#F8F8F8';
const String surface = '#FFFFFF';
const String green = '#1fcd6c';
const String red = '#F21A0E';
const String grey = '#898989';
const String blueGrey = '#5E5F61';
const String black_e = '#282828';
const String white = '#FFFFFF';
const String greyWhite = '#EFEFEF';
const String starColor = '#FEC258';

//dark theme
const String secondBackground = '393d40';
const String secondaryVariantDark = '8a8a89';

// final ThemeData lightTheme = ThemeData(
//   scaffoldBackgroundColor: Colors.white,
//   appBarTheme: AppBarTheme(
//     systemOverlayStyle: Platform.isIOS
//         ? null
//         : const SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//     backgroundColor: Colors.white,
//     elevation: 0.0,
//     titleSpacing: 0.0,
//     iconTheme: const IconThemeData(
//       color: Colors.black,
//       size: 20.0,
//     ),
//     titleTextStyle: const TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: Colors.white,
//     elevation: 50.0,
//     selectedItemColor: HexColor(mainColor),
//     unselectedItemColor: Colors.grey[400],
//     type: BottomNavigationBarType.fixed,
//     selectedLabelStyle: const TextStyle(
//       height: 1.5,
//     ),
//   ),
//   primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
// );

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('1B1C30'),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: Platform.isIOS
        ? null
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleSpacing: 20.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('1B1C30'),
    elevation: 50.0,
    selectedItemColor: HexColor(mainColor),
    //FFF047
    //FFEC00
    unselectedItemColor: Colors.grey[400],
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(
      height: 1.5,
    ),
  ),
  primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
);

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

dynamic parseMapFromServer(String text) => jsonDecode(
    text.replaceAll(r'\', r'').replaceAll(r'\\', r'').replaceAll(r'\\\', r''));

List<Widget> bottomPages = [
  const HomePage(),
  const SectionsScreen(),
  CartPage(),
  const WishlistPage(),
  ProfilePage(),
];

String? token = '';
List<CartModel>? cartListData;

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void launchURL({required String url}) async {
  launch(url).then((value) {
    print('url oppend success');
  }).catchError((error) {
    showToast(message: 'Could not launch $url', toastStates: ToastStates.ERROR);
    print('url oppend error');
    print(error.toString());
  });
}

String getPaymentMethodType(
    {required int paymentId, required BuildContext context}) {
  if (paymentId == 1) {
    return appTranslation(context).cash_on_delivery;
  } else if (paymentId == 2) {
    return appTranslation(context).vodafone_cash;
  } else {
    return appTranslation(context).paypal;
  }
}

String getOrderStatus({required int status, required BuildContext context}) {
  if (status == 0) {
    return appTranslation(context).pending;
  } else if (status == 1) {
    return appTranslation(context).processing;
  } else if (status == 2) {
    return appTranslation(context).shipping;
  } else if (status == 3) {
    return appTranslation(context).pending_delivery;
  } else if (status == 4) {
    return appTranslation(context).delivered;
  } else {
    return appTranslation(context).canceled;
  }
}

TranslationModel appTranslation(context) =>
    MainCubit.get(context).translationModel;

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) =>
    MainCubit.get(context).isRtl ? ar : en;

void showToast({
  required String message,
  required ToastStates toastStates,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(toastStates),
        webBgColor: choseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates toastStates) {
  Color color;
  switch (toastStates) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

RegExp exp = RegExp(
  r'<[^>]*>|&[^;]+;',
  multiLine: true,
  caseSensitive: true,
);

void signOut(context) {
  sl<CacheHelper>().clear('token').then((value) {
    if (value) {
      showToast(
          message: 'Sign out Successfully', toastStates: ToastStates.SUCCESS);
      MainCubit.get(context).changeUser(false);
    }
  });
}

Widget myDivider(context) => Divider(
      height: 0.0,
      color: HexColor(grey),
    );

Widget bigDivider(context) => Container(
      width: double.infinity,
      height: 4.0,
      color: HexColor(grey),
    );

void addToCart({
  required ProductModel productModel,
  required BuildContext context,
}) {
  sl<CacheHelper>().get('cart').then((value) {
    if (value != null) {
      if (productModel.quantityInStock > 0) {
        MainCartModel model = MainCartModel.fromJson(value);

        CartModel cartModel = CartModel(
            name: productModel.name,
            slug: productModel.slug,
            id: productModel.id,
            image: productModel.image,
            price: productModel.price,
            quantity: MainCubit.get(context).itemCount,
            vendorId: productModel.vendorId,
            stock: productModel.quantityInStock,
            color: MainCubit.get(context).currentColor != -1
                ? productModel
                    .color_attributes![MainCubit.get(context).currentColor]
                    .attribute
                    .name
                : null,
            attributeImage: MainCubit.get(context).currentColor != -1
                ? productModel
                    .color_attributes![MainCubit.get(context).currentColor]
                    .image
                : null,
            weight: productModel.weight,
            size: MainCubit.get(context).currentSize != -1
                ? productModel
                    .size_attributes![MainCubit.get(context).currentSize]
                    .attribute
                    .name
                : null,
            attributeId: MainCubit.get(context).currentColor != -1
                ? productModel
                    .color_attributes![MainCubit.get(context).currentColor]
                    .attribute
                    .id
                : null);

        model.data.add(cartModel);

        sl<CacheHelper>()
            .put(
          'cart',
          model.toJson(),
        )
            .then((value) {
          MainCubit.get(context).addToCartMap(cartModel);

          print('cart inserted !!!');
        });
      }
    } else {
      if (productModel.quantityInStock > 0) {
        List<CartModel> list = [];

        CartModel cartModel = CartModel(
          name: productModel.name,
          slug: productModel.slug,
          id: productModel.id,
          image: productModel.image,
          price: productModel.price,
          quantity: MainCubit.get(context).itemCount,
          vendorId: productModel.vendorId,
          stock: productModel.quantityInStock,
          color: MainCubit.get(context).currentColor != -1
              ? productModel
                  .color_attributes![MainCubit.get(context).currentColor]
                  .attribute
                  .name
              : null,
          attributeImage: MainCubit.get(context).currentColor != -1
              ? productModel
                  .color_attributes![MainCubit.get(context).currentColor].image
              : null,
          weight: productModel.weight,
          size: MainCubit.get(context).currentSize != -1
              ? productModel
                  .size_attributes![MainCubit.get(context).currentSize]
                  .attribute
                  .name
              : null,
          attributeId: MainCubit.get(context).currentSize != -1
              ? productModel
                  .color_attributes![MainCubit.get(context).currentColor]
                  .attribute
                  .id
              : null,
        );

        list.add(cartModel);

        MainCartModel model = MainCartModel(
          data: list,
        );

        sl<CacheHelper>()
            .put(
          'cart',
          model.toJson(),
        )
            .then((value) {
          MainCubit.get(context).addToCartMap(cartModel);

          print('cart inserted !!!');
        });
      }
    }
  });
}

void removeFromCart({
  required int id,
  required BuildContext context,
}) {
  sl<CacheHelper>().get('cart').then((value) {
    if (value != null) {
      MainCartModel model = MainCartModel.fromJson(value);

      model.data.removeWhere((element) => element.id == id);

      sl<CacheHelper>()
          .put(
        'cart',
        model.toJson(),
      )
          .then((value) {
        MainCubit.get(context).removeFromCartMap(id);

        print('cart removed !!!');
      });
    }
  });
}

const space3Vertical = SizedBox(
  height: 3.0,
);

const space4Vertical = SizedBox(
  height: 4.0,
);

const space5Vertical = SizedBox(
  height: 5.0,
);

const space8Vertical = SizedBox(
  height: 8.0,
);

const space10Vertical = SizedBox(
  height: 10.0,
);

const space15Vertical = SizedBox(
  height: 15.0,
);

const space20Vertical = SizedBox(
  height: 20.0,
);

const space30Vertical = SizedBox(
  height: 30.0,
);

const space40Vertical = SizedBox(
  height: 40.0,
);

const space50Vertical = SizedBox(
  height: 50.0,
);

const space60Vertical = SizedBox(
  height: 60.0,
);

const space70Vertical = SizedBox(
  height: 70.0,
);

const space80Vertical = SizedBox(
  height: 80.0,
);

const space90Vertical = SizedBox(
  height: 90.0,
);

const space100Vertical = SizedBox(
  height: 100.0,
);

const space3Horizontal = SizedBox(
  width: 3.0,
);

const space4Horizontal = SizedBox(
  width: 4.0,
);

const space5Horizontal = SizedBox(
  width: 5.0,
);
const space8Horizontal = SizedBox(
  width: 8.0,
);

const space10Horizontal = SizedBox(
  width: 10.0,
);
const space15Horizontal = SizedBox(
  width: 15.0,
);

const space6Horizontal = SizedBox(
  width: 6.0,
);

const space6Vertical = SizedBox(
  width: 6.0,
);

const space20Horizontal = SizedBox(
  width: 20.0,
);

const space30Horizontal = SizedBox(
  width: 30.0,
);

const space40Horizontal = SizedBox(
  width: 40.0,
);

const space50Horizontal = SizedBox(
  width: 50.0,
);

const space60Horizontal = SizedBox(
  width: 60.0,
);

const space70Horizontal = SizedBox(
  width: 70.0,
);

const space80Horizontal = SizedBox(
  width: 80.0,
);

const space90Horizontal = SizedBox(
  width: 90.0,
);

const space100Horizontal = SizedBox(
  width: 100.0,
);
