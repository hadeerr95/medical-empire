class TranslationModel {
  late String selectLanguage;
  late String coupon;
  late String enter_coupon_code;
  late String apply;
  late String shipping;
  late String total;
  late String create_account;
  late String sign_in;
  late String welcome;
  late String my_account;
  late String my_addresses;
  late String comparison;
  late String my_orders;
  late String about_us;
  late String contact_us;
  late String faq;
  late String news_letter;
  late String type_yor_email_to_get_news_letter;
  late String email_must_not_be_empty;
  late String email;
  late String submit;
  late String sign_out;
  late String your_account;
  late String edit_account;
  late String change_password;
  late String address_billing;
  late String address_shipping;

  late String name;
  late String address;
  late String mobile_phone;

  late String select_government;
  late String select_city;
  late String street_name;
  late String building_number_address;
  late String special_marker;
  late String save;

  late String comparisons;
  late String product_details;
  late String out_of_stock;
  late String in_stock;
  late String country;
  late String brand;
  late String rating;
  late String description;
  late String size;
  late String no_information_available;
  late String color;
  late String weight;
  late String addToCart;
  late String delete;

  late String get_in_touch;
  late String contact_us_partnerships;
  late String name_must_not_be_empty;
  late String phone_must_not_be_empty;
  late String subject_must_not_be_empty;
  late String message_must_not_be_empty;
  late String phone;
  late String subject;
  late String message;

  late String used_market;
  late String used_products;
  late String first_name;
  late String email_address;
  late String phone_star;

  late String username_email_address;
  late String username_email_address_empty;
  late String password;
  late String confirm_password;
  late String confirm_password_empty;
  late String password_empty;
  late String forget_password;
  late String your_email_is_unacceptable;
  late String your_password_is_too_short;
  late String do_have_an_account;
  late String register_now;
  late String register;

  late String clear_all;
  late String add_to_comparisons;
  late String addition_information;
  late String reviews;
  late String related_product;
  late String egp;

  late String category;
  late String length;
  late String height;
  late String width;
  late String write_review;
  late String tab_to_star;
  late String write__rating_here;

  late String help_info;
  late String blogs;
  late String privacy_policies;
  late String remove_from_cart;
  late String remove;

  late String checkout;
  late String products;
  late String payment_method;
  late String shipping_address;
  late String subtotal;
  late String quantity;

  late String home;
  late String categories;
  late String cart;
  late String wishlist;
  late String profile;
  late String bestOffers;

  late String darkMode;
  late String changeLanguage;
  late String cash_on_delivery;
  late String paypal;
  late String vodafone_cash;
  late String pending;
  late String processing;
  late String shipping_state;
  late String pending_delivery;
  late String delivered;
  late String canceled;

  late String order_number;
  late String date;
  late String order_details;

  late String see_all;
  late String search_for_product;
  late String add_some_products_to_cart;
  late String search;
  late String inbox_notification;
  late String sale;
  late String addToCompare;

  late String old_password_cant_be_empty;
  late String old_password;
  late String new_password_cant_be_empty;
  late String new_password;
  late String confirm_password_cant_be_empty;
  late String make_sure_that_you_write_the_same_password;
  late String cancel;
  late String filter;

  late String add_some_products_to_wish_list;
  late String are_you_sure_to_remove;
  late String please_login_to_get_notifications;
  late String please_login_to_add_or_remove_from_cart;
  late String please_login_to_compare;
  late String please_login_to_add_or_remove_from_wish_list;
  late String view;
  late String add_some_products_to_comparison;
  late String selected;
  late String error_phone;
  late String pleaseSelectColor;
  late String pleaseSelectSize;
  late String aboutUsText;
  late String completeOrder;

  late String proceedCheckout;
  late String signFirst;

  late String overweight_price;
  late String extra_shipping;
  late String areYouSureRemoveCart;

  late String streetNameEmpty;
  late String buildingNumberEmpty;
  late String specialMarkerEmpty;
  late String personalInformation;
  late String yourComment;
  late String overWeightTax;
  late String couponEmpty;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    overweight_price = json['overweight_price'];
    extra_shipping = json['extra_shipping'];

    proceedCheckout = json['proceedCheckout'];
    signFirst = json['signFirst'];

    completeOrder = json['completeOrder'];
    pleaseSelectColor = json['pleaseSelectColor'];
    pleaseSelectSize = json['pleaseSelectSize'];
    aboutUsText = json['aboutUsText'];

    streetNameEmpty = json['streetNameEmpty'];
    buildingNumberEmpty = json['buildingNumberEmpty'];
    specialMarkerEmpty = json['specialMarkerEmpty'];

    pleaseSelectColor = json['pleaseSelectColor'];
    pleaseSelectSize = json['pleaseSelectSize'];
    aboutUsText = json['aboutUsText'];
    error_phone = json['error_phone'];
    selected = json['selected'];
    add_some_products_to_comparison = json['add_some_products_to_comparison'];
    view = json['view'];
    filter = json['filter'];
    cancel = json['cancel'];
    addToCompare = json['addToCompare'];
    sale = json['sale'];
    inbox_notification = json['inbox_notification'];
    search = json['search'];
    search_for_product = json['search_for_product'];
    add_some_products_to_cart = json['add_some_products_to_cart'];
    see_all = json['see_all'];
    darkMode = json['darkMode'];
    changeLanguage = json['changeLanguage'];
    home = json['home'];
    categories = json['categories'];
    cart = json['cart'];
    wishlist = json['wishlist'];
    profile = json['profile'];
    bestOffers = json['bestOffers'];
    selectLanguage = json['selectLanguage'];
    coupon = json['coupon'];
    enter_coupon_code = json['enter_coupon_code'];
    apply = json['apply'];
    shipping = json['shipping'];
    total = json['total'];
    create_account = json['create_account'];
    sign_in = json['sign_in'];
    welcome = json['welcome'];
    my_account = json['my_account'];
    my_addresses = json['my_addresses'];
    comparison = json['comparison'];
    my_orders = json['my_orders'];
    about_us = json['about_us'];
    contact_us = json['contact_us'];
    faq = json['faq'];
    news_letter = json['news_letter'];
    type_yor_email_to_get_news_letter =
        json['type_yor_email_to_get_news_letter'];
    email_must_not_be_empty = json['email_must_not_be_empty'];
    email = json['email'];
    submit = json['submit'];
    sign_out = json['sign_out'];
    your_account = json['your_account'];
    edit_account = json['edit_account'];
    change_password = json['change_password'];
    address_billing = json['address_billing'];
    address_shipping = json['address_shipping'];

    name = json['name'];
    address = json['address'];
    mobile_phone = json['mobile_phone'];

    select_government = json['select_government'];
    select_city = json['select_city'];
    street_name = json['street_name'];
    building_number_address = json['building_number_address'];
    special_marker = json['special_marker'];
    save = json['save'];

    comparisons = json['comparisons'];
    product_details = json['product_details'];
    out_of_stock = json['out_of_stock'];
    in_stock = json['in_stock'];
    country = json['country'];
    brand = json['brand'];
    rating = json['rating'];
    description = json['description'];
    size = json['size'];
    no_information_available = json['no_information_available'];
    color = json['color'];
    weight = json['weight'];
    addToCart = json['add_to_cart'];
    delete = json['delete'];

    get_in_touch = json['get_in_touch'];
    contact_us_partnerships = json['contact_us_partnerships'];
    name_must_not_be_empty = json['name_must_not_be_empty'];
    phone_must_not_be_empty = json['phone_must_not_be_empty'];
    subject_must_not_be_empty = json['subject_must_not_be_empty'];
    message_must_not_be_empty = json['message_must_not_be_empty'];
    phone = json['phone'];
    subject = json['subject'];
    message = json['message'];

    used_market = json['used_market'];
    used_products = json['used_products'];
    first_name = json['first_name'];
    email_address = json['email_address'];
    phone_star = json['phone_star'];

    username_email_address = json['username_email_address'];
    username_email_address_empty = json['username_email_address_empty'];
    password = json['password'];
    confirm_password = json['confirm_password'];
    confirm_password_empty = json['confirm_password_empty'];
    password_empty = json['password_empty'];
    forget_password = json['forget_password'];
    your_email_is_unacceptable = json['your_email_is_unacceptable'];
    your_password_is_too_short = json['your_password_is_too_short'];
    do_have_an_account = json['do_have_an_account'];
    register_now = json['register_now'];
    register = json['register'];

    clear_all = json['clear_all'];
    add_to_comparisons = json['add_to_comparisons'];
    addition_information = json['addition_information'];
    reviews = json['reviews'];
    related_product = json['related_product'];
    egp = json['egp'];

    category = json['category'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    write_review = json['write_review'];
    tab_to_star = json['tab_to_star'];
    write__rating_here = json['write__rating_here'];

    help_info = json['help_info'];
    blogs = json['blogs'];
    privacy_policies = json['privacy_policies'];

    remove_from_cart = json['remove_from_cart'];
    remove = json['remove'];

    checkout = json['checkout'];
    products = json['products'];
    payment_method = json['payment_method'];
    shipping_address = json['shipping_address'];
    subtotal = json['subtotal'];
    quantity = json['quantity'];
    cash_on_delivery = json['cash_on_delivery'];
    vodafone_cash = json['vodafone_cash'];
    paypal = json['paypal'];
    pending = json['pending'];
    processing = json['processing'];
    shipping_state = json['shipping_state'];
    pending_delivery = json['pending_delivery'];
    delivered = json['delivered'];
    canceled = json['canceled'];

    order_number = json['order_number'];
    date = json['date'];
    order_details = json['order_details'];

    old_password_cant_be_empty = json['old_password_cant_be_empty'];
    old_password = json['old_password'];
    new_password_cant_be_empty = json['new_password_cant_be_empty'];
    new_password = json['new_password'];
    confirm_password_cant_be_empty = json['confirm_password_cant_be_empty'];
    make_sure_that_you_write_the_same_password =
        json['make_sure_that_you_write_the_same_password'];

    please_login_to_add_or_remove_from_wish_list =
        json['please_login_to_add_or_remove_from_wish_list'];
    please_login_to_compare = json['please_login_to_compare'];
    please_login_to_add_or_remove_from_cart =
        json['please_login_to_add_or_remove_from_cart'];
    please_login_to_get_notifications =
        json['please_login_to_get_notifications'];
    add_some_products_to_wish_list = json['add_some_products_to_wish_list'];
    are_you_sure_to_remove = json['are_you_sure_to_remove'];
    areYouSureRemoveCart = json['areYouSureRemoveCart'];
    personalInformation = json['personalInformation'];
    yourComment = json['yourComment'];
    overWeightTax = json['overWeightTax'];
    couponEmpty = json['couponEmpty'];
  }

// Map toJson() => {
//       sale: sale,
//       'selectLanguage': selectLanguage,
//       coupon: 'coupon',
//       enter_coupon_code: 'enter_coupon_code',
//       apply: 'apply',
//       shipping: 'shipping',
//       total: 'total',
//       create_account: 'create_account',
//       sign_in: 'sign_in',
//       welcome: 'welcome',
//       my_account: 'my_account',
//       my_addresses: 'my_addresses',
//       comparison: 'comparison',
//       my_orders: 'my_orders',
//       about_us: 'about_us',
//       contact_us: 'contact_us',
//       faq: 'faq',
//       news_letter: 'news_letter',
//       type_yor_email_to_get_news_letter: 'type_yor_email_to_get_news_letter',
//       email_must_not_be_empty: 'email_must_not_be_empty',
//       email: 'email',
//       submit: 'submit',
//       sign_out: 'sign_out',
//       checkout: 'checkout',
//       products: 'products',
//       payment_method: 'payment_method',
//       shipping_address: 'shipping_address',
//       subtotal: 'subtotal',
//       quantity: 'quantity',
//       cash_on_delivery: 'cash_on_delivery',
//   vodafone_cash: 'vodafone_cash',
//       paypal: 'paypal',
//       pending:'pending',
//       processing:'processing',
//       shipping_state:'shipping_state',
//       pending_delivery:'pending_delivery',
//       delivered:'delivered',
//       canceled:'canceled',
// order_number:'order_number',
// date:'date',
// order_details:'order_details',
//     };
}
