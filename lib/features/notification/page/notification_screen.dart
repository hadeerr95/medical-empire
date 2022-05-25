import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/notification_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/core/util/widgets/back_scaffold.dart';
import 'package:medical_empire_app/features/notification/widget/notification_list_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return BackScaffold(
          title: appTranslation(context).inbox_notification,
          actionIcon:  IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_outline,
              color: HexColor(black),
            ),
          ),
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is ReadNotificationLoading)
                const LinearProgressIndicator(),
              Conditional.single(
                  context: context,
                  conditionBuilder: (context) => MainCubit.get(context).notificationFeedModel != null ,
                  widgetBuilder: (context) => Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>  NotificationListItem(
                        model: MainCubit.get(context).notificationFeedModel!.data.notifications.data[index],
                      ),
                      separatorBuilder: (context, index) => myDivider(context),
                      itemCount:  MainCubit.get(context).notificationFeedModel!.data.notifications.data.length,
                    ),
                  ),
                  fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}
