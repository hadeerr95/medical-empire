// import 'package:app_bear/modules/all_reviews/all_reviews_screen.dart';
// import 'package:app_bear/modules/product_details/cubit/cubit.dart';
// import 'package:app_bear/modules/product_details/cubit/states.dart';
// import 'package:app_bear/shared/components/components.dart';
// import 'package:app_bear/shared/components/constants.dart';
// import 'package:app_bear/shared/components/post_items.dart';
// import 'package:app_bear/shared/components/tabs_layouts.dart';
// import 'package:app_bear/shared/configuration/configuration.dart';
// import 'package:app_bear/shared/styles/icon_broken.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// const slider = [
//   [
//     'https://lh3.googleusercontent.com/RjKpuPd6egEn0X6mNUyzvRsnEzYlS27qctSdMY-TQ-0NAEJZN9pQP9VASTgP4Nd5TbfBcegvmMe08512hJIr9QVgumUdO0q-L3s=w1014',
//     'https://lh3.googleusercontent.com/8G1XJ3_wiD8e6ENUoiEF5c4wHw30u2D5UznnsNgqwlOVlPG2L7DEJ0qEThC9VGR0loCZ1EKnMRXjBGxywySOcrhn4EAHQjrjYPo=w1014',
//     'https://lh3.googleusercontent.com/LGVWe2ga_6SaMsDmE_d0Tnu05VNWOMxpt3m3tDhnYQZ6oVxiR7lsM6fCOEBFVpfXg6na-4nR4hpK0NxJKbRX__zPE8AM3AKCkQE=w1014',
//   ],
//   [
//     'https://lh3.googleusercontent.com/zbuxqo5tNfr-vfbykG9TVEWoUMFLyPLkpSR_GN3stPpnVFq7ORjc8XOYe45me1QGPwITyVXhsqQInaHj2HukC2i3hgoA1-iWeUE=w1014',
//     'https://lh3.googleusercontent.com/r2ukKxIl0HMeHNv8O2Eh8Sv1SeaDRNU8c3DaZM2h6ZxcEYGG0xmYxf2lynTWO7_tHXXU2QfniH_HD5n8X0pk67YYDx5UEGIYCJ8A=w1014',
//   ],
// ];
//
// const colors = [
//   {
//     'icon':'https://lh3.googleusercontent.com/y8uKnoY_S3pO02QO9OURmm1p3b1MM0vvV5lGZLkId00zXo7C6ClMPCRNGFc9eJpXTFQIlyfe5H_Ym0h0DY8xbTBzk63ePfJ3hF4W',
//     'name':'Stormy Black',
//   },
//   {
//     'icon':'https://lh3.googleusercontent.com/sWJ6E1TWpouJWdEfRCl8sGU2dTOMaea3rKcUEX9PX1jI96CWw6SI1skrv2b6DG5YcqfWsPAFhlzkgG8iggR_k1XsA6CNcZzchEM',
//     'name':'Sorta Sunny',
//   },
// ];
//
// class ProductDetailsScreen extends StatelessWidget {
//   // List<String> images = [
//   //   'https://cf3.s3.souqcdn.com/item/2021/01/11/13/22/62/65/9/item_XL_132262659_97d72db42e5dd.jpg',
//   //   'https://cf5.s3.souqcdn.com/item/2021/01/11/13/22/62/65/9/item_XL_132262659_e8835d8609d76.jpg',
//   //   'https://cf4.s3.souqcdn.com/item/2021/01/11/13/22/62/65/9/item_XL_132262659_9ca474ae46391.jpg',
//   //   'https://cf5.s3.souqcdn.com/item/2021/01/11/13/22/62/65/9/item_XL_132262659_24c1cf8019739.jpg',
//   // ];
//
//   List<SectionsModel> tabs = [
//     SectionsModel(
//       tabTitle: 'Overview',
//     ),
//     SectionsModel(
//       tabTitle: 'Specifications',
//     ),
//     SectionsModel(
//       tabTitle: 'Reviews',
//     ),
//   ];
//
//   List<Widget> tabsHeader = [];
//
//   List<Widget> tabsContent = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         tabsHeader = [
//           ...tabs.map(
//                 (tab) => Tab(
//               text: tab.tabTitle,
//             ),
//           ),
//         ];
//
//         tabsContent =
//         [
//           OverviewTab(),
//           SpecificationsTab(),
//           ReviewsTab(),
//         ];
//
//         return BlocProvider(
//           create: (BuildContext context) => ProductDetailsCubit(),
//           child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               return Scaffold(
//                 appBar: singleAppBar(
//                   context: context,
//                   title: '',
//                   bottom: defaultDividerBottom(context),
//                 ),
//                 body: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'Samsung',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2!
//                                             .copyWith(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary),
//                                       ),
//                                       Spacer(),
//                                       SizedBox(
//                                         width: 10.0,
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 4.0,
//                                           vertical: 2.0,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             2.0,
//                                           ),
//                                           color: Colors.amber,
//                                         ),
//                                         child: Text(
//                                           '4.8',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .button,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10.0,
//                                       ),
//                                       Text(
//                                         '(29 ratings)',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .caption!
//                                             .copyWith(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10.0,
//                                   ),
//                                   Text(
//                                     'Samsung Galaxy S21 Dual SIM Mobile - 6.2 inches, 128  GB, 8 GB RAM, 5G - Violet with Samsung Wireless Power Bank, 10000 mAh and Samsung Fit 2 Watch',
//                                     style:
//                                     Theme.of(context).textTheme.bodyText2,
//                                   ),
//                                   SizedBox(
//                                     height: 20.0,
//                                   ),
//                                   Stack(
//                                     alignment: AlignmentDirectional.topEnd,
//                                     children: <Widget>[
//                                       CarouselSlider(
//                                         items: slider[ProductDetailsCubit.get(context).currentColorIndex]
//                                             .asMap()
//                                             .map((index, i) {
//                                           return MapEntry(
//                                             index,
//                                             GestureDetector(
//                                               onTap: () {},
//                                               child: Image(
//                                                 image: NetworkImage(i),
//                                                 // loadingBuilder: imageLoadingBuilder,
//                                               ),
//                                             ),
//                                           );
//                                         })
//                                             .values
//                                             .toList(),
//                                         options: CarouselOptions(
//                                           height: 300,
//                                           viewportFraction: 0.8,
//                                           initialPage: 0,
//                                           enableInfiniteScroll: true,
//                                           reverse: false,
//                                           autoPlay: true,
//                                           autoPlayInterval:
//                                           Duration(seconds: 3),
//                                           autoPlayAnimationDuration:
//                                           Duration(seconds: 1),
//                                           autoPlayCurve: Curves.fastOutSlowIn,
//                                           enlargeCenterPage: true,
//                                           onPageChanged: (index, reason) {
//                                             ProductDetailsCubit.get(context)
//                                                 .changeIndicator(index);
//                                           },
//                                           scrollDirection: Axis.horizontal,
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                           defaultIconButton(
//                                             context: context,
//                                             function: () {},
//                                             isCircle: true,
//                                             circleColor: Theme.of(context)
//                                                 .colorScheme
//                                                 .surface,
//                                             icon: Icons.favorite_outline,
//                                           ),
//                                           defaultIconButton(
//                                             context: context,
//                                             function: () {},
//                                             isCircle: true,
//                                             circleColor: Theme.of(context)
//                                                 .colorScheme
//                                                 .surface,
//                                             icon: Icons.share,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: slider[ProductDetailsCubit.get(context).currentColorIndex].map((url) {
//                                       int index = slider[ProductDetailsCubit.get(context).currentColorIndex].indexOf(url);
//                                       return Container(
//                                         width: 8.0,
//                                         height: 8.0,
//                                         margin: const EdgeInsets.symmetric(
//                                             vertical: 20.0, horizontal: 3.0),
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color:
//                                             ProductDetailsCubit.get(context)
//                                                 .currentIndicator ==
//                                                 index
//                                                 ? Theme.of(context)
//                                                 .colorScheme
//                                                 .primary
//                                                 : Colors.transparent,
//                                             border:
//                                             ProductDetailsCubit.get(context)
//                                                 .currentIndicator !=
//                                                 index
//                                                 ? Border.all(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .secondaryVariant,
//                                               width: 0.5,
//                                             )
//                                                 : null),
//                                       );
//                                     }).toList(),
//                                   ),
//                                   Row(
//                                     textBaseline: TextBaseline.alphabetic,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.baseline,
//                                     children: [
//                                       Text(
//                                         'EGP ',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2,
//                                       ),
//                                       Text(
//                                         '21,000.00',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 5.0,
//                                   ),
//                                   Row(
//                                     textBaseline: TextBaseline.alphabetic,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.baseline,
//                                     children: [
//                                       Text(
//                                         'Delivery by ',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .caption!
//                                             .copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Sat, Apr 24',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             myDivider(context),
//                             Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Colors',
//                                     style:
//                                     Theme.of(context).textTheme.subtitle2,
//                                   ),
//                                   SizedBox(
//                                     height: 15.0,
//                                   ),
//                                   Row(
//                                     children: [
//                                       ...colors
//                                           .asMap()
//                                           .map(
//                                             (i, element) => MapEntry(
//                                           i,
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       width: 1.0,
//                                                       color: ProductDetailsCubit.get(context).currentColorIndex == i ? Theme.of(context)
//                                                           .colorScheme
//                                                           .primary : Theme.of(context)
//                                                           .colorScheme
//                                                           .surface,
//                                                     ),
//                                                   ),
//                                                   padding: EdgeInsets.symmetric(
//                                                     vertical: 10.0,
//                                                     horizontal: 5.0,
//                                                   ),
//                                                   child: Column(
//                                                     children: [
//                                                       Image(
//                                                         image: NetworkImage(
//                                                           element['icon'] as String,
//                                                         ),
//                                                         height: 70.0,
//                                                         width: 70.0,
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10.0,
//                                                       ),
//                                                       Text(
//                                                         element['name'] as String,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText2,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   ProductDetailsCubit.get(context).changeColorIndex(i);
//                                                 },
//                                               ),
//                                               SizedBox(
//                                                 width: 15.0,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                           .values
//                                           .toList(),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             myDivider(context),
//                             // Column(
//                             //   crossAxisAlignment: CrossAxisAlignment.start,
//                             //   children: [
//                             //     Row(
//                             //       children: [
//                             //         Expanded(
//                             //           child: InkWell(
//                             //             child: Padding(
//                             //               padding: const EdgeInsets.symmetric(
//                             //                 vertical: 15.0,
//                             //               ),
//                             //               child: Text(
//                             //                 'Overview',
//                             //                 textAlign: TextAlign.center,
//                             //                 style: Theme.of(context)
//                             //                     .textTheme
//                             //                     .subtitle2
//                             //                     .copyWith(
//                             //                       color: ProductDetailsCubit.get(
//                             //                                   context)
//                             //                               .tabs[0]
//                             //                           ? Theme.of(context)
//                             //                               .colorScheme
//                             //                               .primary
//                             //                           : Theme.of(context)
//                             //                               .colorScheme
//                             //                               .secondaryVariant,
//                             //                     ),
//                             //               ),
//                             //             ),
//                             //             onTap: () {
//                             //               ProductDetailsCubit.get(context)
//                             //                   .changeTabs(
//                             //                 index: 0,
//                             //               );
//                             //             },
//                             //           ),
//                             //         ),
//                             //         Expanded(
//                             //           child: InkWell(
//                             //             child: Padding(
//                             //               padding: const EdgeInsets.symmetric(
//                             //                 vertical: 15.0,
//                             //               ),
//                             //               child: Text(
//                             //                 'Specifications',
//                             //                 textAlign: TextAlign.center,
//                             //                 style: Theme.of(context)
//                             //                     .textTheme
//                             //                     .subtitle2
//                             //                     .copyWith(
//                             //                       color: ProductDetailsCubit.get(
//                             //                                   context)
//                             //                               .tabs[1]
//                             //                           ? Theme.of(context)
//                             //                               .colorScheme
//                             //                               .primary
//                             //                           : Theme.of(context)
//                             //                               .colorScheme
//                             //                               .secondaryVariant,
//                             //                     ),
//                             //               ),
//                             //             ),
//                             //             onTap: () {
//                             //               ProductDetailsCubit.get(context)
//                             //                   .changeTabs(
//                             //                 index: 1,
//                             //               );
//                             //             },
//                             //           ),
//                             //         ),
//                             //         Expanded(
//                             //           child: InkWell(
//                             //             child: Padding(
//                             //               padding: const EdgeInsets.symmetric(
//                             //                 vertical: 15.0,
//                             //               ),
//                             //               child: Text(
//                             //                 'Reviews',
//                             //                 textAlign: TextAlign.center,
//                             //                 style: Theme.of(context)
//                             //                     .textTheme
//                             //                     .subtitle2
//                             //                     .copyWith(
//                             //                       color: ProductDetailsCubit.get(
//                             //                                   context)
//                             //                               .tabs[2]
//                             //                           ? Theme.of(context)
//                             //                               .colorScheme
//                             //                               .primary
//                             //                           : Theme.of(context)
//                             //                               .colorScheme
//                             //                               .secondaryVariant,
//                             //                     ),
//                             //               ),
//                             //             ),
//                             //             onTap: () {
//                             //               ProductDetailsCubit.get(context)
//                             //                   .changeTabs(
//                             //                 index: 2,
//                             //               );
//                             //             },
//                             //           ),
//                             //         ),
//                             //       ],
//                             //     ),
//                             //     Row(
//                             //       children: [
//                             //         Expanded(
//                             //           child: Container(
//                             //             height: 4.0,
//                             //             color: ProductDetailsCubit.get(
//                             //                 context)
//                             //                 .tabs[0]
//                             //                 ? Theme.of(context)
//                             //                 .colorScheme
//                             //                 .primary
//                             //                 : Theme.of(context)
//                             //                 .colorScheme
//                             //                 .surface,
//                             //           ),
//                             //         ),
//                             //         Expanded(
//                             //           child: Container(
//                             //             height: 4.0,
//                             //             color: ProductDetailsCubit.get(
//                             //                 context)
//                             //                 .tabs[1]
//                             //                 ? Theme.of(context)
//                             //                 .colorScheme
//                             //                 .primary
//                             //                 : Theme.of(context)
//                             //                 .colorScheme
//                             //                 .surface,
//                             //           ),
//                             //         ),
//                             //         Expanded(
//                             //           child: Container(
//                             //             height: 4.0,
//                             //             color: ProductDetailsCubit.get(
//                             //                 context)
//                             //                 .tabs[2]
//                             //                 ? Theme.of(context)
//                             //                 .colorScheme
//                             //                 .primary
//                             //                 : Theme.of(context)
//                             //                 .colorScheme
//                             //                 .surface,
//                             //           ),
//                             //         ),
//                             //       ],
//                             //     ),
//                             //     Padding(
//                             //       padding: const EdgeInsets.all(20.0),
//                             //       child: buildTabsContent(ProductDetailsCubit.get(context).currentTab, context),
//                             //     ),
//                             //   ],
//                             // ),
//                             DefaultTabController(
//                               length: 3,
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     height: 40.0,
//                                     width: double.infinity,
//                                     child: DecoratedTabBar(
//                                       tabBar: TabBar(
//                                         tabs: tabsHeader,
//                                         isScrollable: false,
//                                         indicatorWeight: 4.0,
//                                         indicatorColor: Theme.of(context)
//                                             .colorScheme
//                                             .primary,
//                                         labelStyle:
//                                         Theme.of(context).textTheme.button,
//                                         indicatorSize: TabBarIndicatorSize.tab,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .secondaryVariant,
//                                             width: 4.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: ProductDetailsCubit.get(context)
//                                         .contentHeight,
//                                     child: TabBarView(
//                                       physics: BouncingScrollPhysics(),
//                                       children: tabsContent,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Image(
//                               image: NetworkImage(
//                                 'https://souqcms.s3-eu-west-1.amazonaws.com/spring/images/2021/samsung/samsung-galaxy-S21/5-samsung-galaxy-S21-plus.jpg',
//                               ),
//                               width: double.infinity,
//                               height: 250.0,
//                               fit: BoxFit.cover,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).colorScheme.primary,
//                             width: 1.0,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40.0,
//                               child: MaterialButton(
//                                 onPressed: () {},
//                                 minWidth: 1.0,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'QTY',
//                                       style:
//                                       Theme.of(context).textTheme.caption!,
//                                     ),
//                                     Text(
//                                       '1',
//                                       style:
//                                       Theme.of(context).textTheme.subtitle2,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 color: Theme.of(context).colorScheme.primary,
//                                 height: 40.0,
//                                 width: double.infinity,
//                                 child: MaterialButton(
//                                   onPressed: (){},
//                                   child: Text(
//                                     'translation.addToCart.toUpperCase()',
//                                     style: Theme.of(context).textTheme.button,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class OverviewTab extends StatefulWidget {
//   @override
//   _OverviewTabState createState() => _OverviewTabState();
// }
//
// class _OverviewTabState extends State<OverviewTab> {
//   var key = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Builder(
//             builder: (BuildContext context) {
//               return NotificationListener<SizeChangedLayoutNotification>(
//                 onNotification: (notification)
//                 {
//                   ProductDetailsCubit.get(context)
//                       .changeTabsContentHeight(key.currentContext!.size!.height);
//                   print(key.currentContext!.size!.height);
//                   return true;
//                 },
//                 child: SizeChangedLayoutNotifier(
//                   child: WidgetMountedListener(
//                     onMounted: ()
//                     {
//                       ProductDetailsCubit.get(context)
//                           .changeTabsContentHeight(key.currentContext!.size!.height);
//                       print('height ===>');
//                       print(key.currentContext!.size!.height);
//                     },
//                     child: Padding(
//                       key: key,
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Highlights',
//                             style: Theme.of(context).textTheme.subtitle2,
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Text(
//                             '• The real metal finish on the main camera adds unity to the design and accentuates the luxury of the haze texture. It’s an iconic new camera design made to turn heads.',
//                             style: Theme.of(context).textTheme.bodyText2,
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           Text(
//                             '• The real metal finish on the main camera adds unity to the design and accentuates the luxury of the haze texture. It’s an iconic new camera design made to turn heads.',
//                             style: Theme.of(context).textTheme.bodyText2,
//                           ),
//                           if (ProductDetailsCubit.get(context).isOverviewMore)
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 40.0,
//                                 ),
//                                 Text(
//                                   'Highlights',
//                                   style: Theme.of(context).textTheme.subtitle2,
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 Text(
//                                   '• The real metal finish on the main camera adds unity to the design and accentuates the luxury of the haze texture. It’s an iconic new camera design made to turn heads.',
//                                   style: Theme.of(context).textTheme.bodyText2,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   '• The real metal finish on the main camera adds unity to the design and accentuates the luxury of the haze texture. It’s an iconic new camera design made to turn heads.',
//                                   style: Theme.of(context).textTheme.bodyText2,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Text(
//                                   '• The real metal finish on the main camera adds unity to the design and accentuates the luxury of the haze texture. It’s an iconic new camera design made to turn heads.',
//                                   style: Theme.of(context).textTheme.bodyText2,
//                                 ),
//                               ],
//                             ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Align(
//                             alignment: AlignmentDirectional.center,
//                             child: Container(
//                               height: 40.0,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   width: 1.0,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                               child: MaterialButton(
//                                 onPressed: ()
//                                 {
//                                   ProductDetailsCubit.get(context)
//                                       .changeOverviewMore();
//                                 },
//                                 child: Text(
//                                   ProductDetailsCubit.get(context).isOverviewMore ? 'View Less' : 'View More',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .button!
//                                       .copyWith(
//                                     color:
//                                     Theme.of(context).colorScheme.primary,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class SpecificationsTab extends StatefulWidget
// {
//   @override
//   _SpecificationsTabState createState() => _SpecificationsTabState();
// }
//
// class _SpecificationsTabState extends State<SpecificationsTab>
// {
//   var key = GlobalKey();
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
//       listener: (context, state) {},
//       builder: (context, state)
//       {
//         return SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Builder(
//             builder: (BuildContext context)
//             {
//               return NotificationListener<SizeChangedLayoutNotification>(
//                 onNotification: (notification)
//                 {
//                   ProductDetailsCubit.get(context)
//                       .changeTabsContentHeight(key.currentContext!.size!.height);
//                   print(key.currentContext!.size!.height);
//                   return true;
//                 },
//                 child: SizeChangedLayoutNotifier(
//                   child: WidgetMountedListener(
//                     onMounted: ()
//                     {
//                       ProductDetailsCubit.get(context)
//                           .changeTabsContentHeight(key.currentContext!.size!.height);
//                       print('height ===>');
//                       print(key.currentContext!.size!.height);
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       key: key,
//                       children:
//                       [
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Text(
//                             'Specifications',
//                             style: Theme.of(context).textTheme.subtitle2,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Row(
//                             children:
//                             [
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                     color: Theme.of(context).colorScheme.secondary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           color: Theme.of(context).colorScheme.surface,
//                           child: Row(
//                             children:
//                             [
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                     color: Theme.of(context).colorScheme.secondary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Row(
//                             children:
//                             [
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                     color: Theme.of(context).colorScheme.secondary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           color: Theme.of(context).colorScheme.surface,
//                           child: Row(
//                             children:
//                             [
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Dimensions',
//                                   style: Theme.of(context).textTheme.caption!.copyWith(
//                                     color: Theme.of(context).colorScheme.secondary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (ProductDetailsCubit.get(context).isSpecsMore)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10.0,
//                                   horizontal: 20.0,
//                                 ),
//                                 color: Theme.of(context).colorScheme.surface,
//                                 child: Row(
//                                   children:
//                                   [
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         'Dimensions',
//                                         style: Theme.of(context).textTheme.caption!.copyWith(
//                                           color: Theme.of(context).colorScheme.secondary,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional.center,
//                           child: Container(
//                             height: 40.0,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1.0,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                             ),
//                             child: MaterialButton(
//                               onPressed: ()
//                               {
//                                 ProductDetailsCubit.get(context)
//                                     .changeSpecsMore();
//                               },
//                               child: Text(
//                                 ProductDetailsCubit.get(context).isSpecsMore ? 'View Less' : 'View More',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .button!
//                                     .copyWith(
//                                   color:
//                                   Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ReviewsTab extends StatefulWidget {
//   @override
//   _ReviewsTabState createState() => _ReviewsTabState();
// }
//
// class _ReviewsTabState extends State<ReviewsTab> {
//   var key = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Builder(
//             builder: (BuildContext context) {
//               return NotificationListener<SizeChangedLayoutNotification>(
//                 onNotification: (notification) {
//                   ProductDetailsCubit.get(context)
//                       .changeTabsContentHeight(key.currentContext!.size!.height);
//                   print('height from ===>');
//                   print(key.currentContext!.size!.height);
//                   return true;
//                 },
//                 child: SizeChangedLayoutNotifier(
//                   child: WidgetMountedListener(
//                     onMounted: ()
//                     {
//                       ProductDetailsCubit.get(context)
//                           .changeTabsContentHeight(key.currentContext!.size!.height);
//                       print('height ===>');
//                       print(key.currentContext!.size!.height);
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       key: key,
//                       children:
//                       [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Row(
//                             children:
//                             [
//                               Text(
//                                 '4.5',
//                                 style: Theme.of(context).textTheme.headline4!.copyWith(
//                                   color: Theme.of(context).colorScheme.secondary,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15.0,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children:
//                                     [
//                                       RatingBar(
//                                         initialRating: 4.5,
//                                         minRating: 1.0,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         ignoreGestures: true,
//                                         ratingWidget: RatingWidget(
//                                           full: Icon(
//                                             Icons.star,
//                                             color: HexColor('ffc35c'),
//                                           ),
//                                           half: Icon(
//                                             Icons.star_border,
//                                             color: HexColor('ffc35c'),
//                                           ),
//                                           empty: Icon(
//                                             Icons.star_border,
//                                             color: HexColor('ffc35c'),
//                                           ),
//                                         ),
//                                         itemSize: 20.0,
//                                         onRatingUpdate: (rating)
//                                         {
//                                           print(rating);
//                                         },
//                                       ),
//                                       SizedBox(
//                                         height: 5.0,
//                                       ),
//                                       Text(
//                                         'Based on 25 ratings',
//                                         style: Theme.of(context).textTheme.caption!,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         myDivider(context),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:
//                             [
//                               Text(
//                                 'Name',
//                                 style: Theme.of(context).textTheme.subtitle2,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5.0,
//                                 ),
//                                 child: RatingBar(
//                                   initialRating: 3,
//                                   minRating: 1,
//                                   direction: Axis.horizontal,
//                                   allowHalfRating: true,
//                                   itemCount: 5,
//                                   ignoreGestures: true,
//                                   ratingWidget: RatingWidget(
//                                     full: Icon(
//                                       Icons.star,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                     half: Icon(
//                                       Icons.star_border,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                     empty: Icon(
//                                       Icons.star_border,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                   ),
//                                   itemSize: 10.0,
//                                   onRatingUpdate: (rating) {
//                                     print(rating);
//                                   },
//                                 ),
//                               ),
//                               Text(
//                                 'Dec 14, 2020',
//                                 style: Theme.of(context).textTheme.caption!,
//                               ),
//                               SizedBox(
//                                 height: 5.0,
//                               ),
//                               Text(
//                                 'Good Products',
//                                 style: Theme.of(context).textTheme.bodyText2,
//                               ),
//                             ],
//                           ),
//                         ),
//                         myDivider(context),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:
//                             [
//                               Text(
//                                 'Name',
//                                 style: Theme.of(context).textTheme.subtitle2,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5.0,
//                                 ),
//                                 child: RatingBar(
//                                   initialRating: 3,
//                                   minRating: 1,
//                                   direction: Axis.horizontal,
//                                   allowHalfRating: true,
//                                   itemCount: 5,
//                                   ignoreGestures: true,
//                                   ratingWidget: RatingWidget(
//                                     full: Icon(
//                                       Icons.star,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                     half: Icon(
//                                       Icons.star_border,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                     empty: Icon(
//                                       Icons.star_border,
//                                       color: HexColor('ffc35c'),
//                                     ),
//                                   ),
//                                   itemSize: 10.0,
//                                   onRatingUpdate: (rating) {
//                                     print(rating);
//                                   },
//                                 ),
//                               ),
//                               Text(
//                                 'Dec 14, 2020',
//                                 style: Theme.of(context).textTheme.caption!,
//                               ),
//                               SizedBox(
//                                 height: 5.0,
//                               ),
//                               Text(
//                                 'Good Products',
//                                 style: Theme.of(context).textTheme.bodyText2,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional.center,
//                           child: Container(
//                             height: 40.0,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1.0,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                             ),
//                             child: MaterialButton(
//                               onPressed: ()
//                               {
//                                 navigateTo(context, AllReviewsScreen(),);
//                               },
//                               child: Text(
//                                 'View More',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .button!
//                                     .copyWith(
//                                   color:
//                                   Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class WidgetMountedListener extends StatefulWidget {
//   WidgetMountedListener(
//       { this.onCreated, this.child, this.onDestroyed, this.onMounted});
//
//   VoidCallback? onCreated;
//   Widget? child;
//   VoidCallback? onDestroyed;
//   VoidCallback? onMounted;
//
//   @override
//   _WidgetMountedListenerState createState() => _WidgetMountedListenerState();
// }
//
// class _WidgetMountedListenerState extends State<WidgetMountedListener> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       if (widget.onMounted != null) widget.onMounted!();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child!;
//   }
// }