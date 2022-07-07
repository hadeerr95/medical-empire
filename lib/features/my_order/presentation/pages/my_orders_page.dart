import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/my_order/presentation/widgets/order_item.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  void initState() {
    super.initState();
    MainCubit.get(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      title: appTranslation(context).my_orders,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return BuildCondition(
            condition: MainCubit.get(context).ordersModel != null,
            builder: (context) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => OrderItem(
                order: MainCubit.get(context).ordersModel!.orders.orders[index],
                index: index,
              ),
              // separatorBuilder: (context, index) => SizedBox(),
              itemCount:
                  MainCubit.get(context).ordersModel!.orders.orders.length,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
