import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_empire_app/core/di/injection.dart';
import 'package:medical_empire_app/core/models/about_us_model.dart';
import 'package:medical_empire_app/core/models/address_model.dart';
import 'package:medical_empire_app/core/models/blog_details_model.dart';
import 'package:medical_empire_app/core/models/blog_model.dart';
import 'package:medical_empire_app/core/models/brands_details_model.dart';
import 'package:medical_empire_app/core/models/brands_model.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/models/categories_model.dart';
import 'package:medical_empire_app/core/models/compares_model.dart';
import 'package:medical_empire_app/core/models/coupons_model.dart';
import 'package:medical_empire_app/core/models/create_checkout_item_model.dart';
import 'package:medical_empire_app/core/models/get_faqs_model.dart';
import 'package:medical_empire_app/core/models/grid_model.dart';
import 'package:medical_empire_app/core/models/home_feed_model.dart';
import 'package:medical_empire_app/core/models/my_account_model.dart';
import 'package:medical_empire_app/core/models/notification_model.dart';
import 'package:medical_empire_app/core/models/order_details_model.dart';
import 'package:medical_empire_app/core/models/orders_model.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/models/read_notification_model.dart';
import 'package:medical_empire_app/core/models/search_feeds_model.dart';
import 'package:medical_empire_app/core/models/simple_model.dart';
import 'package:medical_empire_app/core/models/used_market_cat_details_model.dart';
import 'package:medical_empire_app/core/models/used_market_model.dart';
import 'package:medical_empire_app/core/models/used_product_details_model.dart';
import 'package:medical_empire_app/core/models/wishlist_model.dart';
import 'package:medical_empire_app/core/network/local/cache_helper.dart';
import 'package:medical_empire_app/core/network/repository.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/translation.dart';
import 'package:medical_empire_app/core/util/widgets/two_options_dialog.dart';

import '../constants.dart';

class MainCubit extends Cubit<MainState> {
  final Repository _repository;

  MainCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static MainCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController();

  int currentIndex = 0;

  void bottomChanged(int index) {
    if (index == 4) {
      getAccount();
      currentIndex = index;
      emit(BottomChanged());
    }

    currentIndex = index;

    pageController.jumpToPage(
      index,
    );

    // if (pageController.hasClients) {
    //   pageController.jumpToPage(currentIndex);
    // }
    //
    // print(currentIndex);
    // print(pageController.page);

    emit(BottomChanged());
  }

  int currentParentCategorySelected = 0;

  void changeParentCategorySelection(int index) {
    currentParentCategorySelected = index;
    emit(CategoriesChangeParentCategoryState(
      index: currentParentCategorySelected,
    ));
  }

  // dark colors
  String scaffoldBackground = '333739';

  String secondaryDark = 'ffffff';
  String secondaryVariantDark = '8a8a89';

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  late String family;

  bool isRtl = false;
  bool isDark = false;

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isDark = dark;
    isRtl = rtl;

    print('dark mode ------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Poppins';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: secondaryVariant,
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 11.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(scaffoldBackground),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
                statusBarColor: HexColor(scaffoldBackground),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: HexColor(grey),
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        headline6: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 11.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  void changeMode() {
    isDark = !isDark;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeLanguage() async {
    isRtl = !isRtl;

    sl<CacheHelper>().put('isRtl', isRtl);

    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    changeTheme();

    emit(ChangeLanguageState());
  }

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    // if(translation == null) {
    //   translationModel = TranslationModel.fromJson(json.decode(
    //     _translation,
    //   ));
    // } else {
    //   translationModel = TranslationModel.fromJson(json.decode(
    //     translation,
    //   ));
    // }

    emit(LanguageLoaded());
  }

  CategoriesModel? categoriesModel;

  void getCategories() async {
    emit(CategoriesLoadingState());

    await _repository.getCategories().then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(
        CategoriesSuccessState(),
      );
    }).catchError((error) {
      print('can not get categories');
      print(error.toString());
      emit(Error());
    });
  }

  BrandsModel? brandsModel;

  void getBrands() async {
    await _repository.getBrands().then((value) {
      brandsModel = BrandsModel.fromJson(value.data);
      print('brands ------------------------------------------------------');
      print(brandsModel!.brands[0].image);
      emit(
        HomeSuccessState(),
      );
    }).catchError((error) {
      print(
          'brands ------------------------------------------------------ error ${error.toString()}');
      emit(HomeErrorState());
    });
  }

  BlogModel? bLogModel;

  void getBlogs() async {
    emit(BlogsLoadingState());
    await _repository.getBlogs().then((value) {
      bLogModel = BlogModel.fromJson(value.data);
      print('blogs ------------------------------------------------------');
      print(bLogModel!.data.blog[0].title);
      emit(BlogsSuccessState());
    }).catchError((error) {
      emit(Error());
    });
  }

  HomeFeedModel? homeFeedModel;

  void getHomeFeed() async {
    emit(HomeLoadingState());

    await _repository.getHome().then((value) {
      print('home --------');
      print(value.data);
      homeFeedModel = HomeFeedModel.fromJson(value.data);
      emit(
        HomeSuccessState(),
      );
    }).catchError((error) {
      emit(Error());
    });
  }

// wishlist ---------------- start

  List<int> wishlistId = [];

  WishlistModel? wishlistModel;

  void getWishListModel() async {
    if (userSigned) {
      emit(WishlistLoadingState());
      await _repository.getWishList().then((value) {
        print('wishlis --------');
        print(value.data);
        wishlistModel = WishlistModel.fromJson(value.data);
        for (var element in wishlistModel!.products) {
          if (!wishlistId.contains(element.id)) {
            wishlistId.add(element.id);
          }
        }
        emit(
          WishlistSuccessState(),
        );
      }).catchError((error) {
        print('Wishlist Error -------- ${error.toString()}');
        emit(WishlistErrorState());
      });
    }
  }

  void addToWishList(
      {required int productId, required BuildContext context}) async {
    if (wishlistId.contains(productId)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return TwoOptionsDialog(
              pushButtonVoidCallback: () {
                print(wishlistId.toString());

                wishlistId.remove(productId);

                print(wishlistId.toString());

                removeFromWishList(productId: productId);
                Navigator.pop(context);
              },
              popButtonVoidCallback: () {
                Navigator.pop(context);
              },
              message: appTranslation(context).are_you_sure_to_remove,
              // title: 'title',
              pushButtonText: appTranslation(context).remove,
              popButtonText: appTranslation(context).cancel,
            );
          });
    } else {
      wishlistId.add(productId);
      emit(WishlistLoadingState());
      await _repository.addToWishList(productId: productId).then((value) {
        print('wishlis --------');
        print(value.data);
        getWishListModel();
      }).catchError((error) {
        emit(WishlistErrorState());
      });
    }
  }

  void removeFromWishList({required int productId}) async {
    emit(WishlistLoadingState());

    await _repository.deleteFromWishList(productId: productId).then((value) {
      print('wishlis --------');
      print(value.data);
      getWishListModel();
    }).catchError((error) {
      emit(WishlistErrorState());
    });
  }

  // wishlist ---------------- start

// change grid to list ---------------- start
  bool gridNotList = true;

  void changeGridToList(bool value) {
    gridNotList = value;
    emit(ChangeGridToList());
  }

// change grid to list ---------------- end

// login ---------------- start

  SimpleModel? simpleModelLogin;

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    await _repository.login(email: email, password: password).then((value) {
      if (value.statusCode == 200) {
        simpleModelLogin = SimpleModel.fromJson(value.data);
        // print('login ------------------------------------------------------');
        // print(simpleModelLogin!.token);
        // print(simpleModelLogin!.status);
        token = simpleModelLogin!.token;
        userSigned = true;
        getWishListModel();
        getAccount();
        emit(LoginSuccess(simpleModelLogin!));
      } else {
        emit(LoginError(value.data['error']));
      }
    }).catchError((error) {
      print(
          'login error ------------------------------------------------------');
      print(error.toString());
      print(
          'login error ------------------------------------------------------');
      emit(Error());
    });
  }

// login ---------------- end

  // register ---------------- start

  SimpleModel? simpleModelRegister;

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(RegisterLoading());
    await _repository
        .register(
      name: name,
      phone: phone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    )
        .then((value) {
      if (value.statusCode == 200) {
        simpleModelRegister = SimpleModel.fromJson(value.data);
        print(
            'register ------------------------------------------------------');
        // print(simpleModelRegister!.status);
        emit(RegisterSuccess(simpleModelRegister!));
      } else {
        emit(Error());
      }
    }).catchError((error) {
      print(error.toString());
      print(
          'error is here ------------------------------------------------------');
      emit(Error());
    });
  }

// register ---------------- end

  //product details----------------------start

  int currentSize = -1;

  void selectSize(int index) {
    currentSize = index;

    num sizePrice =
        productFeedModel!.data.product.size_attributes![currentSize].price;

    storedPrice = productFeedModel!.data.product.price;

    if (currentColor != -1) {
      num colorPrice =
          productFeedModel!.data.product.color_attributes![currentColor].price;

      if (colorPrice > sizePrice) {
        productFeedModel!.data.product.price = colorPrice.toString();
        productMainPrice = colorPrice.toString();
      } else {
        productFeedModel!.data.product.price = sizePrice.toString();
        productMainPrice = sizePrice.toString();
      }
    } else {
      productFeedModel!.data.product.price = sizePrice.toString();
      productMainPrice = sizePrice.toString();
    }

    itemCount = 1;

    emit(SelectSize());
  }

  int currentColor = -1;

  List<String> storedGallery = [];
  String storedImage = '';
  String storedPrice = '';
  num storedColorSelected = 0;

  void selectColor(int index) {
    currentColor = index;

    storedColorSelected = productFeedModel!
        .data.product.color_attributes![currentColor].attribute.id;

    num colorPrice =
        productFeedModel!.data.product.color_attributes![currentColor].price;
    String colorImage =
        productFeedModel!.data.product.color_attributes![currentColor].image ??
            productFeedModel!.data.product.image;
    // String colorImage = productFeedModel!.data.product
    //     .color_attributes![currentColor].image;

    storedPrice = productFeedModel!.data.product.price;

    if (currentSize != -1) {
      num sizePrice =
          productFeedModel!.data.product.size_attributes![currentSize].price;

      if (colorPrice > sizePrice) {
        productFeedModel!.data.product.price = colorPrice.toString();
        productMainPrice = colorPrice.toString();
      } else {
        productFeedModel!.data.product.price = sizePrice.toString();
        productMainPrice = sizePrice.toString();
      }
    } else {
      productFeedModel!.data.product.price = colorPrice.toString();
      productMainPrice = colorPrice.toString();
    }

    if (productFeedModel!.data.product.gallery != null) {
      print('has a gallery');

      productFeedModel!.data.product.gallery!.clear();
      productFeedModel!.data.product.gallery!.add(colorImage);
    } else {
      print('has an image');

      productFeedModel!.data.product.image = colorImage;
    }

    itemCount = 1;

    emit(SelectColor());
  }

  bool itemColorId() {
    return cartMap[productFeedModel!.data.product.color_attributes!
            .map((e) => e.attribute.id)] !=
        storedColorSelected;
  }

  void clearVariations() {
    currentColor = -1;
    currentSize = -1;

    productFeedModel!.data.product.price = storedPrice;
    productMainPrice = storedPrice;

    print(storedImage);
    print(storedGallery);

    productFeedModel!.data.product.image = storedImage;
    productFeedModel!.data.product.gallery = storedGallery;
    itemCount = 1;

    emit(ClearVariationsState());
  }

  int itemCount = 1;

  void addition() {
    if (productFeedModel!.data.product.quantityInStock == itemCount) {
      itemCount = productFeedModel!.data.product.quantityInStock;
    } else {
      itemCount++;
      productFeedModel!.data.product.price =
          (int.parse(productFeedModel!.data.product.price) +
                  int.parse(productMainPrice))
              .toString();
      productFeedModel!.data.product.price =
          (int.parse(productFeedModel!.data.product.price) +
                  int.parse(productMainPrice))
              .toString();
      emit(Addition());
    }
  }

  void subtraction() {
    if (itemCount <= 1) {
      itemCount = 1;
    } else {
      itemCount--;
      productFeedModel!.data.product.price =
          (int.parse(productFeedModel!.data.product.price) -
                  int.parse(productMainPrice))
              .toString();
      productFeedModel!.data.product.price =
          (int.parse(productFeedModel!.data.product.price) -
                  int.parse(productMainPrice))
              .toString();
    }
    emit(Subtraction());
  }

  cartAddition({
    required int id,
  }) async {
    if (cartMap[id]!.quantity < cartMap[id]!.stock) {
      cartMap[id]!.quantity = cartMap[id]!.quantity + 1;

      if (cartListData == null) {
        sl<CacheHelper>().get('cart').then((value) {
          print('cart ---------------------------- $value');
          if (value != null) {
            cartListData = MainCartModel.fromJson(value).data;
          }
        });
      }
      for (int i = 0; i < cartListData!.length; i++) {
        if (cartListData![i].id == id) {
          cartListData![i] = cartMap[id]!;
        }
      }

      MainCartModel model = MainCartModel(
        data: cartListData!,
      );

      sl<CacheHelper>()
          .put(
        'cart',
        model.toJson(),
      )
          .then((value) {
        print('cart inserted !!!');
      });
    }

    await sumSubTotalCart();
    sumShipping();

    emit(CartAddition());
  }

  Future<int> cartSubtraction({
    required int id,
  }) async {
    if (cartMap[id]!.quantity > 1) {
      cartMap[id]!.quantity = cartMap[id]!.quantity - 1;
      if (cartListData == null) {
        sl<CacheHelper>().get('cart').then((value) {
          print('cart ---------------------------- $value');
          if (value != null) {
            cartListData = MainCartModel.fromJson(value).data;
          }
        });
      }
      for (int i = 0; i < cartListData!.length; i++) {
        if (cartListData![i].id == id) {
          cartListData![i] = cartMap[id]!;
        }
      }

      MainCartModel model = MainCartModel(
        data: cartListData!,
      );

      sl<CacheHelper>()
          .put(
        'cart',
        model.toJson(),
      )
          .then((value) {
        print('cart inserted !!!');
      });
      await sumSubTotalCart();
      sumShipping();

      emit(CartSubtraction());
      return 1;
    }
    return -1;
  }

  num subtotalCart = 0;
  num firstTotalCart = 0;

  sumSubTotalCart() async {
    subtotalCart = 0;

    cartMap.forEach((key, value) {
      subtotalCart = subtotalCart + (value.quantity * int.parse(value.price));
    });

    if (couponsModel != null && couponsModel!.data != null) {
      firstTotalCart = subtotalCart - couponsModel!.data!.coupon.amount;
    } else {
      firstTotalCart = subtotalCart;
    }
    print("===========================$firstTotalCart");

    emit(CartSubTotal());
  }

  Map<int, CartModel> cartMap = {};

  void fillCartMap() {
    if (cartListData != null && cartListData!.isNotEmpty) {
      for (var element in cartListData!) {
        cartMap.addAll({
          element.id: element,
        });
      }

      sumSubTotalCart();

      emit(FillCartMapState());
    }
  }

  bool noInternetConnection = false;

  void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('Internet Connection ------------------------');
      print(result.index);
      print(result.toString());
      if (result.index == 0 || result.index == 1) {
        noInternetConnection = false;
      } else if (result.index == 2) {
        noInternetConnection = true;
      }

      emit(InternetState());
    });
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      noInternetConnection = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      noInternetConnection = false;
    } else {
      noInternetConnection = true;
    }
    emit(InternetState());
  }

  void removeFromCartMap(int id) {
    cartMap.removeWhere((key, value) => key == id);
    if (cartMap.isEmpty) {
      sl<CacheHelper>().clear('coupon').then((value) {
        couponsModel = null;
        couponEditingController.text = "";
      });
    }
    sumSubTotalCart();
    emit(RemoveFromCartMapState());
  }

  void addToCartMap(CartModel model) {
    cartMap.addAll({
      model.id: model,
    });

    sumSubTotalCart();

    emit(AddToCartMapState());
  }

  ProductFeedModel? productFeedModel;
  String productMainPrice = '';

  // bool isProductInCart = false;

  void getProductFeed({
    required String slug,
  }) async {
    productFeedModel = null;
    storedImage = '';
    storedGallery = [];
    itemCount = 1;
    currentColor = -1;
    currentSize = -1;

    emit(ProductDetailsLoading());

    await _repository
        .getProductDetails(
      // slug: '50',
      slug: slug,
    )
        .then((value) {
      print('------------ ProductDetails --------');
      print(slug);
      // print(value.data);
      productFeedModel = ProductFeedModel.fromJson(value.data);
      productMainPrice = productFeedModel!.data.product.price;
      storedGallery = productFeedModel!.data.product.gallery!;
      storedImage = productFeedModel!.data.product.image;

      // for(int i = 0 ; i < model.length ; i ++) {
      //   if(model[i].id == productFeedModel!.data.product.id) {
      //     isProductInCart = true;
      //   }
      // }

      // print(productFeedModel!.data.product.gallery[0]);
      // print(productFeedModel!.data.product.gallery[1]);
      emit(
        ProductDetailsSuccess(),
      );
    }).catchError((error) {
      print('ProductDetailsError --------$error');
      emit(ProductDetailsError());
    });
  }

  // void changeCartState(bool state) {
  //   isProductInCart = state;
  //
  //   emit(ChangeCartState());
  // }

//product details----------------------end

  CategoriesDetails? gridModel;

  int categoryProductCurrentPage = 1;
  int categoryProductTotalPages = 0;

  void getCategoryProduct({
    required int id,
    bool isFirst = false,
  }) async {
    if (isFirst) {
      productsList = [];
      categoryProductCurrentPage = 1;
      emit(CategoryProductsLoadingState());
    } else {
      emit(CategoryProductsLoadingMoreState());
    }

    await _repository
        .getCategoryProducts(
      id: id,
      page: categoryProductCurrentPage,
    )
        .then((value) {
      gridModel = CategoriesDetails.fromJson(value.data);
      productsList.addAll(gridModel!.data.products.productsList);

      categoryProductCurrentPage++;
      hasEnd = true;

      if (categoryProductTotalPages == 0) {
        categoryProductTotalPages = gridModel!.data.products.lastPage;
      }

      emit(CategoryProductsSuccessState());
    }).catchError((error) {
      print('getCategoryProduct error');
      print(error.toString());
      emit(CategoryProductsErrorState(error.toString()));
    });
  }

  bool hasEnd = false;

  void changeHasEnd() {
    hasEnd = false;

    emit(ChangeHasEndState());
  }

  bool userSigned = false;

  void changeUser(bool user) {
    userSigned = user;
    emit(SignInState());
  }

//my Address----------------------start
  AddressFeedModel? addressFeedModel;
  GovernmentModel? selectedGovernment;
  CitiesModel? selectedCity;

  void selectGovernment(GovernmentModel model, {CitiesModel? citiesModel}) {
    selectedGovernment = model;
    selectedCity = citiesModel ?? selectedGovernment!.cities[0];
    if (checkoutModel != null) {
      print("********* " + selectedCity!.name + selectedGovernment!.name);
      ;
      sumShipping(
          governorateID: model.id,
          updateShippingAddressesSelected: citiesModel == null);
    }
    emit(SelectedGovernmentState());
  }

  void selectCity(CitiesModel model) {
    selectedCity = model;
    sumShipping(governorateID: model.governorateId);
    emit(SelectedCityState());
  }

  getMyAddress() async {
    emit(MyAddressLoadingState());
    await _repository.getAddress().then((value) {
      addressFeedModel = AddressFeedModel.fromJson(value.data);
      selectedGovernment = addressFeedModel!.data.governorates!
          .singleWhere((element) => element.name == 'Cairo');
      selectedCity = selectedGovernment!.cities[0];
      emit(MyAddressSuccessState());
    }).catchError((error) {
      print('my Address Error------------------------');
      print(error.toString());
      emit(MyAddressErrorState(error.toString()));
    });
  }

  addMyAddress({
    required String buildingNumber,
    required int city,
    required int governorate,
    required String specialMarker,
    required String streetName,
  }) async {
    emit(AddAddressLoadingState());
    await _repository
        .addAddress(
      building_number: buildingNumber,
      city: city,
      governorate: governorate,
      special_marker: specialMarker,
      street_name: streetName,
    )
        .then((value) async {
      SimpleModel model = SimpleModel.fromJson(value.data);
      await getMyAddress();
      if (model.message != null) {
        emit(AddAddressSuccessState(model.message!));
      }
    }).catchError((error) {
      print('Add Address Error------------------------');
      print(error.toString());
      emit(AddAddressErrorState(error.toString()));
    });
  }

  void deleteMyAddress({
    required int addressId,
  }) async {
    emit(DeleteAddressLoadingState());
    await _repository.deleteAddress(addressId: addressId).then((value) {
      SimpleModel model = SimpleModel.fromJson(value.data);
      emit(DeleteAddressSuccessState(model.message!));
      getMyAddress();
    }).catchError((error) {
      print('Delete Address Error------------------------');
      print(error.toString());
      emit(DeleteAddressErrorState(error.toString()));
    });
  }

//my Address----------------------end

// Get all brands ----------------------start
//   BrandsModel? allBrands;
//
//   void getAllBrands() async {
//     emit(GetAllBrandsLoading());
//     await _repository.getAllBrands().then((value) {
//       allBrands = BrandsModel.fromJson(value.data);
//       print(' --------------------------------------------all brands');
//       //print(allBrands!.brands.brands[0].name);
//       emit(GetAllBrandsSuccess());
//     }).catchError((error) {
//       print(error.toString());
//       print(' --------------------------------------------all brands error');
//       emit(Error());
//     });
//   }

// Get all brands----------------------end

  // Get brand details  ----------------------start
  BrandsDetailsModel? brandDetails;
  List<ProductModel> productsList = [];

  void getBrandDetails({
    required int id,
  }) async {
    productsList.clear();
    emit(GetBrandDetailsLoading());
    await _repository.getBrandDetails(id: id).then((value) {
      brandDetails = BrandsDetailsModel.fromJson(value.data);
      productsList =
          brandDetails!.brandsDetailsDataModel.productsDataModel.productsList;
      print(' --------------------------------------------brand details');
      //print(allBrands!.brands.brands[0].name);
      emit(GetBrandDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      print(' --------------------------------------------brand details error');
      emit(Error());
    });
  }

// Get brand details ----------------------end

  // Get blog details  ----------------------start
  BLogDetailsModel? bLogDetailsModel;

  void getBlogDetails({
    required int id,
  }) async {
    bLogDetailsModel = null;
    emit(GetBlogDetailsLoading());
    await _repository.getBlogDetails(id: id).then((value) {
      bLogDetailsModel = BLogDetailsModel.fromJson(value.data);
      print(
          ' --------------------------------------------blog details success');
      emit(GetBlogDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      print(' --------------------------------------------blog details error');
      emit(Error());
    });
  }

// Get blog details ----------------------end

  //Search----------------------start
  SearchFeedsModel? searchFeedsModel;
  List<ProductModel> searchProductsList = [];

  int searchProductCurrentPage = 1;
  int searchProductTotalPages = 0;

  void getSearch({
    required String productName,
    int? categoryId,
    int? brandId,
    bool isFirst = false,
  }) async {
    if (isFirst) {
      searchProductsList = [];
      searchProductCurrentPage = 1;
      emit(SearchLoadingState());
    } else {
      emit(SearchLoadingMoreState());
    }

    await _repository
        .getSearch(
      productName: productName,
      categoryId: categoryId,
      brandId: brandId,
      page: searchProductCurrentPage,
    )
        .then((value) {
      searchFeedsModel = SearchFeedsModel.fromJson(value.data);

      searchProductsList.addAll(searchFeedsModel!.data.products.data);

      searchProductCurrentPage++;
      hasEnd = true;

      if (searchProductTotalPages == 0) {
        searchProductTotalPages = searchFeedsModel!.data.products.last_page;
      }

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }

  void clearSearch() {
    searchFeedsModel = null;
    emit(ClearSearchState());
  }

  int? brandId;
  String brandName = '';

  void selectBrand(brand_id, brand_name) {
    if (brandId == brand_id) {
      brandId = -1;
      brandName = '';
    } else {
      brandId = brand_id;
      brandName = brand_name;
    }
    emit(SelectBrand());
  }

  int? categoryId;
  String categoryName = '';

  void selectCategories(categoriesId, category_name) {
    if (categoryId == categoriesId) {
      categoryId = -1;
      categoryName = '';
    } else {
      categoryId = categoriesId;
      categoryName = category_name;
    }
    emit(SelectBrand());
  }

  bool changeCategoriesBottomSheet = false;

  void changeCategoriesBottomSheetTile(bool state) {
    changeCategoriesBottomSheet = state;
    emit(ChangeExpansionTile());
  }

  bool changeBrandBottomSheet = false;

  void changeBrandBottomSheetTile(bool state) {
    changeBrandBottomSheet = state;
    emit(ChangeExpansionTile());
  }

  void closeBottomSheet({required context}) {
    Navigator.pop(context);
    changeBrandBottomSheet = false;
    changeCategoriesBottomSheet = false;
    emit(CloseBottomSheet());
  }

  //Search----------------------end

  MyAccountModel? myAccountModel;

  void getAccount() async {
    if (userSigned) {
      print('----------------My Account------------------');
      emit(MyAccountLoadingState());
      await _repository.getMyAccount().then((value) {
        myAccountModel = MyAccountModel.fromJson(value.data);
        emit(MyAccountSuccessState());
        print('----------------My Account------------------ Success');
      }).catchError((error) {
        emit(MyAccountErrorState(error.toString()));
        print(
            '----------------My Account------------------ Error${error.toString()}');
      });
    }
  }

  updateAccount({
    required String name,
    required String email,
    required String phone,
  }) async {
    print('----------------update Account------------------');
    emit(UpdateAccountLoadingState());
    await _repository
        .updateAccount(
      name: name,
      email: email,
      phone: phone,
      image: imageFile,
    )
        .then((value) {
      SimpleModel model = SimpleModel.fromJson(value.data);
      if (model.message != null) {
        emit(UpdateAccountSuccessState(model.message!));
      }
      getAccount();
      print('----------------update Account------------------ Success');
    }).catchError((error) {
      emit(UpdateAccountErrorState(error.toString()));
      print(
          '----------------update Account------------------ Error${error.toString()}');
    });
  }

//Edit Account----------------------end

//notification----------------------start

  NotificationFeedModel? notificationFeedModel;

  void getNotification() async {
    notificationFeedModel = null;
    print('----------------Notification------------------');
    emit(NotificationLoadingState());
    await _repository.getNotification().then((value) {
      notificationFeedModel = NotificationFeedModel.fromJson(value.data);
      emit(NotificationSuccessState());
      print('----------------Notification------------------ Success');
    }).catchError((error) {
      emit(NotificationErrorState(error.toString()));
      print(
          '----------------Notification------------------ Error ${error.toString()}');
    });
  }

//notification----------------------end

//get about us----------------------start

  AboutUsModel? aboutUsModel;

  void getAboutUs() async {
    print('----------------About Us loading------------------');
    emit(AboutUsLoadingState());
    await _repository.getAboutUs().then((value) {
      aboutUsModel = AboutUsModel.fromJson(value.data);
      print(aboutUsModel!.data.name);
      print('----------------About Us success ------------------ Success');
      emit(AboutUsSuccessState());
    }).catchError((error) {
      emit(AboutUsErrorState(error.toString()));
      print(
          '----------------About Us error------------------ Error ${error.toString()}');
      print(
          '----------------About Us error------------------ Error ${error.toString()}');
    });
  }

//get about us----------------------end

//Compares----------------------start

  ComparesModel? comparesModel;

  void getCompares() async {
    print('----------------Compares------------------');
    emit(ComparesLoadingState());
    await _repository.getCompares().then((value) {
      comparesModel = ComparesModel.fromJson(value.data);
      emit(ComparesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ComparesErrorState(error.toString()));
    });
  }

  void addCompares({
    required int productId,
  }) async {
    print('----------------Add Compares------------------');
    emit(AddComparesLoadingState());
    await _repository.addCompares(productId: productId).then((value) {
      SimpleModel model = SimpleModel.fromJson(value.data);
      emit(AddComparesSuccessState(model.message!));
      getCompares();
    }).catchError((error) {
      print(error.toString());
      emit(AddComparesErrorState(error.toString()));
    });
  }

  void removeFromCompares({
    required int compareId,
  }) async {
    print('----------------RemoveCompare------------------');
    emit(RemoveComparesLoadingState());
    await _repository.removeCompare(compareId: compareId).then((value) {
      SimpleModel model = SimpleModel.fromJson(value.data);
      print('----------------RemoveCompare------------------ success');
      emit(RemoveComparesSuccessState(model.message!));
      getCompares();
    }).catchError((error) {
      print(error.toString());
      print('----------------RemoveCompare------------------ error');
      emit(RemoveComparesErrorState(error.toString()));
    });
  }

//Compares----------------------end

  // contact us ---------------- start

  // String? responseMessage;
  // int? responseState;

  void contactUs({
    required String name,
    required String phone,
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(ContactUsLoadingState());
    await _repository
        .contactUs(
      name: name,
      phone: phone,
      email: email,
      subject: subject,
      message: message,
    )
        .then((value) {
      // responseMessage = value.data['message'];
      // responseState = value.data['state'];
      print(
          'contact us ------------------------------------------------------');
      print(value.data['message']);
      emit(ContactUsSuccessState(value.data['message']));
    }).catchError((error) {
      print(error.toString());
      print(
          'error is here ------------------------------------------------------');
      emit(Error());
    });
  }

// contact us ---------------- end

// get FAQs ------------------ start
  FAQsModel? faqsModel;

  void getFAQs() async {
    print('----------------Compares------------------');
    emit(FAQsLoadingState());
    await _repository.getFAQs().then((value) {
      faqsModel = FAQsModel.fromJson(value.data);
      print(faqsModel!.faqs[0].question);
      emit(FAQsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(Error());
    });
  }

// get FAQs ------------------ end

  // news letter ------------------ start

  void newsLetter({
    required String email,
  }) async {
    print('----------------news letter------------------');
    emit(NewsLetterLoadingState());
    await _repository.newsLetter(email: email).then((value) {
      print('----------------news letter success------------------');
      emit(NewsLetterSuccessState(value.data['message']));
    }).catchError((error) {
      print(error.toString());
      emit(Error());
    });
  }

// news letter ------------------ end

//Used Market----------------------start

  UsedProductFeedModel? usedProductFeedModel;

  void getUsedProduct({
    required int productId,
  }) async {
    print('----------------Used Product------------------');
    emit(UsedProductLoadingState());
    await _repository.usedMarketProduct(productId: productId).then((value) {
      print('----------------Used Product- no parsing -----------------');
      usedProductFeedModel = UsedProductFeedModel.fromJson(value.data);
      emit(UsedProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UsedProductErrorState(error.toString()));
    });
  }

//Used Market----------------------end

//Get Used Market----------------------start

  UsedMarketModel? usedMarketModel;

  void getUsedMarket() async {
    print('---------------------------------- Used Product Loading');
    emit(GetUsedMarketLoadingState());
    await _repository.getUsedMarket().then((value) {
      usedMarketModel = UsedMarketModel.fromJson(value.data);
      print('---------------------------------- Used Product Success');
      emit(GetUsedMarketSuccessState());
    }).catchError((error) {
      print('---------------------------------- Used Product Error');
      print(error.toString());
      emit(Error());
    });
  }

//Get Used Market----------------------end

  // get UsedMarketCat details  ----------------------start
  UsedMarketCatDetailsModel? usedMarketCatDetailsModel;

  void getUsedMarketCatDetails({
    required int id,
  }) async {
    usedMarketCatDetailsModel = null;
    print(
        ' --------------------------------------------getUsedMarketCatDetails loading');
    emit(GetUsedMarketDetailsLoading());
    await _repository.getUsedMarketCatDetails(id: id).then((value) {
      usedMarketCatDetailsModel =
          UsedMarketCatDetailsModel.fromJson(value.data);
      print(
          ' --------------------------------------------getUsedMarketCatDetails success');
      //print(allBrands!.brands.brands[0].name);
      emit(GetUsedMarketDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      print(
          ' --------------------------------------------getUsedMarketCatDetails error');
      emit(Error());
    });
  }

// get UsedMarketCat details ----------------------end

//Add Review----------------------start

  void addReview({
    required int productId,
    required double rating,
    required String review,
  }) async {
    print('----------------Add Review------------------');
    emit(AddReviewLoadingState());
    await _repository
        .addReview(
      productId: productId,
      rating: rating,
      review: review,
    )
        .then((value) {
      SimpleModel model = SimpleModel.fromJson(value.data);
      emit(AddReviewSuccessState(model.message!));
    }).catchError((error) {
      print(error.toString());
      emit(AddReviewErrorState(error.toString()));
    });
  }

//Add Review----------------------end

  // Get orders details  ----------------------start
  OrdersModel? ordersModel;

  void getOrders() async {
    print(' --------------------------------------------get orders loading');
    emit(GetOrdersLoading());
    await _repository.getOrders().then((value) {
      ordersModel = OrdersModel.fromJson(value.data);
      print(' --------------------------------------------get orders success');
      emit(GetOrdersSuccess());
    }).catchError((error) {
      print(error.toString());
      print(' --------------------------------------------get orders error');
      emit(Error());
    });
  }

// Get orders details ----------------------end

  int shippingAddressIndex = 0;

  void changeShippingAddressIndex({
    required int index,
  }) {
    shippingAddressIndex = index;
    sumShipping();
    emit(ChangeShippingAddressIndex());
  }

  int paymentMethodIndex = 0;

  void changePaymentMethodIndex({
    required int index,
  }) {
    paymentMethodIndex = index;
    emit(ChangePaymentMethodIndex());
  }

  // getCheckout  ----------------------start
  AddressFeedModel? checkoutModel;

  getCheckout() async {
    checkoutModel = null;
    print(' -------------------------------------------getCheckout loading');
    emit(GetCheckoutLoading());
    await _repository.getCheckout().then((value) {
      checkoutModel = AddressFeedModel.fromJson(value.data);
      sumShipping();
      // print(checkoutModel!.data.addresses![0].street_name);
      print(' -------------------------------------------getCheckout success');
      emit(GetCheckoutSuccess());
    }).catchError((error) {
      print(error.toString());
      print(' -------------------------------------------getCheckout error');
      emit(Error());
    });
  }

// getCheckout ----------------------end

  // getOrderDetails  ----------------------start
  OrderDetailsModel? orderDetailsModel;

  void getOrderDetails({
    required int id,
  }) async {
    orderDetailsModel = null;
    print(' --------------------------------------------getOrderDetails error');
    emit(GetOrderDetailsLoading());
    await _repository.getOrderDetails(id: id).then((value) {
      orderDetailsModel = OrderDetailsModel.fromJson(value.data);
      print(
          ' --------------------------------------------getOrderDetails success');
      print(orderDetailsModel!.data.orderItems[0].price);
      emit(GetOrderDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      print(
          ' --------------------------------------------getOrderDetails error');
      emit(Error());
    });
  }

  void cancelOrderDetails() async {
    print(
        ' --------------------------------------------cancelOrderDetails error');
    emit(CancelOrderDetailsLoading());
    await _repository
        .orderCancel(orderId: orderDetailsModel!.data.order.id)
        .then((value) {
      getOrders();
      print(
          ' --------------------------------------------cancelOrderDetails success');
      emit(CancelOrderDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      print(
          ' --------------------------------------------cancelOrderDetails error');
      emit(Error());
    });
  }

  double totalAmount() {
    double amount = 0;

    amount = double.parse(orderDetailsModel!.data.order.totalAmount) +
        double.parse(orderDetailsModel!.data.order.shipping_price) +
        double.parse(orderDetailsModel!.data.order.extra_shipping) +
        double.parse(orderDetailsModel!.data.order.overweight_price);
    return amount;
  }

// getOrderDetails ----------------------end

// select profile image

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  void selectImage() async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      imageFile = File(value!.path);
    });

    emit(SelectProfileImage());
  }

  void clearSelectedImage() async {
    imageFile = null;

    emit(ClearProfileImage());
  }

  // readNotification  ----------------------start
  ReadNotificationModel? readNotificationModel;

  void readNotification({
    required String notificationId,
  }) async {
    readNotificationModel = null;
    print(
        ' --------------------------------------------readNotification loading');
    emit(ReadNotificationLoading());
    await _repository
        .readNotification(notificationId: notificationId)
        .then((value) {
      readNotificationModel = ReadNotificationModel.fromJson(value.data);
      print(
          ' --------------------------------------------readNotification success');
      print(readNotificationModel!.data.order.name);
      emit(ReadNotificationSuccess());
    }).catchError((error) {
      print(error.toString());
      print(
          ' --------------------------------------------readNotification error');
      emit(Error());
    });
  }

// readNotification ----------------------end

  // changePassword  ----------------------start
  SimpleModel? changePasswordModel;

  void changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    changePasswordModel = null;
    print(
        ' --------------------------------------------changePassword loading');
    emit(ChangePasswordLoading());
    await _repository
        .changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    )
        .then((value) {
      print('done');
      changePasswordModel = SimpleModel.fromJson(value.data);
      print(changePasswordModel!.message);
      print(
          ' --------------------------------------------changePassword success');
      emit(ChangePasswordSuccess(changePasswordModel!.message!));
    }).catchError((error) {
      print(error.toString());
      print(
          ' --------------------------------------------changePassword error');
      emit(Error());
    });
  }

// changePassword ----------------------end

//Drawer --------------------------start

  int defaultExpansionTile = -1;

  void changeExpansionTile(bool state, int id) {
    defaultExpansionTile = state ? id : -1;
    emit(ChangeExpansionTile());
  }

  int defaultSubExpansionTile = -1;

  void changeSubExpansionTile(bool state, int id) {
    defaultSubExpansionTile = state ? id : -1;
    emit(ChangeExpansionTile());
  }

//Drawer --------------------------end

  // getCheckout  ----------------------start
  // AddressFeedModel? checkoutModel;

  SimpleModel? checkoutSimpleModel;

  void createCheckout() async {
    print(' -------------------------------------------createCheckout loading');

    List items = [];

    cartMap.values.toList().forEach((e) {
      // print(' -------------------------------------------images ${e.attributeImage!.split('/').last}');

      items.add(CreateCheckoutItemModel(
        price: int.parse(e.price),
        id: e.id,
        quantity: e.quantity,
        attributes: CreateCheckoutItemModelAttributes(
          image: e.attributeImage != null
              ? e.attributeImage!.split('/').last
              : null,
          size: e.size,
          type: e.color != null
              ? 'color'
              : e.size != null
                  ? 'size'
                  : null,
          color: e.color,
        ),
      ).toJson());
    });

    emit(CreateCheckoutLoading());

    if (checkoutModel == null ||
        checkoutModel!.data.shippingAddresses == null ||
        checkoutModel!.data.shippingAddresses!.isEmpty) {
      await getCheckout();
    }
    await getCheckout();
    await _repository
        .createCheckout(
      city: checkoutModel!.data.shippingAddresses![shippingAddressIndex]
          .shippingAddressCitiesModel.id
          .toString(),
      buildingNumber: checkoutModel!
          .data.shippingAddresses![shippingAddressIndex].buildingNumber,
      streetName: checkoutModel!
          .data.shippingAddresses![shippingAddressIndex].streetName,
      phone: checkoutModel!.data.user.phone,
      email: checkoutModel!.data.user.email,
      specialMarker: checkoutModel!
          .data.shippingAddresses![shippingAddressIndex].specialMarker,
      government: checkoutModel!.data.shippingAddresses![shippingAddressIndex]
          .shippingAddressGovernmentModel.id
          .toString(),
      name: checkoutModel!.data.user.name,
      paymentMethod:
          checkoutModel!.data.paymentMethod![paymentMethodIndex].id.toString(),
      extraShipping: extraShippingPrice.toString(),
      items: items,
      notes: note,
      overweightPrice: overWeightTax.toString(),
      promoCode: couponsModel != null && couponsModel!.data != null
          ? couponsModel!.data!.coupon.name
          : '',
      shippingPrice: totalShippingPrice.toString(),
    )
        .then((value) {
      // checkoutModel = AddressFeedModel.fromJson(value.data);
      // print(checkoutModel!.data.addresses[0].street_name);

      checkoutSimpleModel = SimpleModel.fromJson(value.data);

      print(
          '-------------------------------------------createCheckout success');
      emit(CreateCheckoutSuccess(checkoutSimpleModel!.message!));
    }).catchError((error) {
      print(error.toString());
      print('-------------------------------------------createCheckout error');
      emit(Error());
    });
  }

  void clearCart() {
    sl<CacheHelper>().clear('cart').then((value) {
      sl<CacheHelper>().clear('coupon').then((value) {
        cartMap = {};
        couponsModel = null;
        couponEditingController.text = "";
        print("asdasdsa" + cartMap.toString());
        cartListData = [];
        emit(CartClear());
      });
    });
  }

// createCheckout ----------------------end

  // coupon  ----------------------start
  TextEditingController couponEditingController = TextEditingController();

  CouponsModel? couponsModel;

  getCouponModelIfExist() async {
    var couponJson = await sl<CacheHelper>().get('coupon');
    if (couponJson != null) {
      couponsModel = CouponsModel.fromJson(couponJson);
    }
    return couponsModel;
  }

  void applyCoupon({
    required String coupon,
  }) async {
    emit(ApplyCouponLoading());
    await _repository
        .getApplyCoupon(
      coupon: coupon,
    )
        .then((value) {
      print('done');
      couponsModel = CouponsModel.fromJson(value.data);

      if (value.data["data"] == null) {
        emit(ApplyCouponError(value.data["message"].toString()));
      } else if (couponsModel!.data != null) {
        firstTotalCart = subtotalCart - couponsModel!.data!.coupon.amount;

        sl<CacheHelper>()
            .put(
          'coupon',
          couponsModel!.toJson(),
        )
            .then((value) {
          print(
              ' --------------------------------------------apply Coupon success');
          emit(ApplyCouponSuccess(couponsModel!.message.isNotEmpty
              ? couponsModel!.message
              : couponsModel!.data!.coupon.desc));
        });
      }
    }).catchError((error) {
      print(error.toString());
      print(' --------------------------------------------apply Coupon error');
      emit(ApplyCouponError(error.toString()));
    });
  }

// coupon  ----------------------end

// sum shipping  ----------------------start
  num finalTotalCart = 0;
  int totalShippingPrice = 0;
  int extraShippingPrice = 0;
  num overWeightTax = 0;
  String note = "";

  void sumShipping(
      {int governorateID = 0,
      num? overTax,
      bool? updateShippingAddressesSelected}) {
    if (checkoutModel!.data.shippingAddresses!.isEmpty ||
        (updateShippingAddressesSelected != null &&
            updateShippingAddressesSelected)) {
      for (var governorate in checkoutModel!.data.governorates!) {
        if (governorate.id == governorateID) {
          for (var city in governorate.cities) {
            if (city.id == selectedCity!.id) {
              totalShippingPrice = city.shippingPrice?.price ?? 0;
              print("city $totalShippingPrice");
              if (totalShippingPrice == 0) {
                totalShippingPrice =
                    governorate.governmentShippingPriceModel.price;
                print("governorate $totalShippingPrice");
              }
            }
          }
        }
      }
    } else {
      print("---------------else -------");
      int cityShippingPrice = checkoutModel!
          .data
          .shippingAddresses![shippingAddressIndex]
          .shippingAddressCitiesModel
          .shipping_price!;

      if (cityShippingPrice == 0) {
        totalShippingPrice = checkoutModel!
            .data
            .shippingAddresses![shippingAddressIndex]
            .shippingAddressGovernmentModel
            .governorateShippingPrice
            .price;
        // in case user not have any shipping addresses
        print("-----------cityShippingPrice == $shippingAddressIndex--------");
      } else {
        totalShippingPrice = cityShippingPrice;
      }

      // int i = cartMap.values.toList()[0].vendorId;
      //
      // cartMap.values.toList().forEach((element) {
      //   if (element.vendorId != i) {
      //     extraShippingPrice += 10;
      //   }
      //
      //   print(">>>>>>>>>>>>>>>>>>>>${element.vendorId}");
      // });
    }

    finalTotalCart = firstTotalCart + totalShippingPrice + extraShippingPrice;
    overWeightTax = 0;
    if (overTax == null) {
      finalTotalCart = firstTotalCart + totalShippingPrice + extraShippingPrice;
    } else {
      overWeightTax = overTax;
      finalTotalCart =
          firstTotalCart + totalShippingPrice + extraShippingPrice + overTax;
    }
    print(">>>>>>>>>>>>>>>>>>>>$extraShippingPrice");
    print(">>>>>>>>>>>>>>>>>>>>$totalShippingPrice");
    print(">>>>>>>>>>>>>>>>>>>>$firstTotalCart");
    print(">>>>>>>>>>>>>>>>>>>>$finalTotalCart");
  }

// sum shipping  ----------------------end

  void updateNote(String orderNote) {
    note = "";
    note = orderNote;
  }
}
