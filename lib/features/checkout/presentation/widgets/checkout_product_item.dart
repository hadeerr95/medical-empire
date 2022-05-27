import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/cart_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutProductItem extends StatelessWidget {
  final CartModel cartItem;
  final BehaviorSubject<int> quantitySubject ;
  const CheckoutProductItem({Key? key, required this.cartItem,required this.quantitySubject,  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.0,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  image: NetworkImage(
                    cartItem.image,
                  ),
                  fit: BoxFit.cover),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          space10Horizontal,
          Expanded(
            child: SizedBox(
              height: 135.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MainCubit.get(context).isRtl?
                    cartItem.name.ar:cartItem.name.en,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                  space10Vertical,
                  Row(
                    children: [
                      StreamBuilder<int>(
                        stream: quantitySubject.stream,
                        builder: (context, snapshot) {
                          return Text(
                            '${appTranslation(context).egp} ${int.parse(cartItem.price) * (snapshot.data ?? cartItem.quantity)}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(mainColor),
                                ),
                          );
                        }
                      ),
                      const Spacer(),
                      Text(
                        '${appTranslation(context).quantity} :',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: HexColor(secondaryVariantDark),
                        ),
                      ),
                      space3Horizontal,
                      GestureDetector(
                        onTap: (){
                          if (cartItem.quantity < cartItem.stock){
                            cartItem.quantity++;
                            quantitySubject.sink.add(cartItem.quantity);
                            MainCubit.get(context).sumSubTotalCart();
                            MainCubit.get(context).calculateFinalTotalCart();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    color: Colors.grey.shade400,
                                    offset: const Offset(1,1)
                                )
                              ]),
                            padding: const EdgeInsets.all(4),
                            child: Icon(Icons.add , color: Theme.of(context).primaryColor,size: 16,)),
                      ),
                      space6Horizontal,
                      StreamBuilder<int>(
                        stream: quantitySubject.stream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data == null ? '${cartItem.quantity}' :
                            '${snapshot.data}',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(secondaryVariantDark),
                                ),
                            );
                        }
                      ),
                      space6Horizontal,
                      GestureDetector(
                        onTap: (){
                          if (cartItem.quantity > 0){
                            cartItem.quantity--;
                            quantitySubject.sink.add(cartItem.quantity);
                            MainCubit.get(context).sumSubTotalCart();
                            MainCubit.get(context).calculateFinalTotalCart();
                          }},
                        child: Container(
                            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 2,
                                color: Colors.grey.shade400,
                                offset: const Offset(1,1)
                              )
                            ]),
                            padding: const EdgeInsets.all(4),
                            child: Icon(Icons.remove , color: Theme.of(context).primaryColor,size: 16,)),
                      ),

                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
