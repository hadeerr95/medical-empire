// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:medical_empire_app/core/util/constants.dart';
// import 'package:medical_empire_app/core/util/cubit/cubit.dart';
// import 'package:medical_empire_app/core/util/cubit/state.dart';
// import 'package:medical_empire_app/core/util/widgets/my_button.dart';
//
// class EmptyWishlist extends StatelessWidget {
//   const EmptyWishlist({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MainCubit, MainState>(
//       builder: (BuildContext context, state) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration:  BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 80.0,
//                     color:  HexColor(thirdColor).withOpacity(0.6),
//                     spreadRadius: 40.0,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 FontAwesomeIcons.heart,
//                 color: HexColor(thirdColor),
//               ),
//             ),
//             space30Vertical,
//             Text(
//               'Wishlist',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             space10Vertical,
//             SizedBox(
//               width: double.infinity,
//               child: Text(
//                 'Simply sign in to pick up where\n you left off.',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.caption,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
//               child: MyButton(
//                 voidCallback: (){
//                   // MainCubit.get(context).addToWishList(productId: '1000');
//                 },
//                 text: 'Return to shop',
//                 color: HexColor(thirdColor),
//                 radius: 8.0,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
