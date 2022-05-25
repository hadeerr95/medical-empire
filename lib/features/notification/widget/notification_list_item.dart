import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/notification_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';
import 'package:medical_empire_app/core/util/cubit/cubit.dart';
import 'package:medical_empire_app/core/util/cubit/state.dart';
import 'package:medical_empire_app/features/my_order/presentation/pages/my_order_details_page.dart';

class NotificationListItem extends StatelessWidget {
  NotificationsData model;

  NotificationListItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, state) {
        return InkWell(
          onTap: () {
            MainCubit.get(context).readNotification(notificationId: model.id);
            navigateTo(
              context,
              MyOrderDetailsPage(
                orderId: model.data.order,
              ),
            );
          },
          child: Container(
            color: model.readAt == null
                ? MainCubit.get(context).isDark
                    ? HexColor(secondBackground)
                    : HexColor(greyWhite)
                : Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      backgroundColor: HexColor(mainColor).withOpacity(0.2),
                      child: Icon(
                        FontAwesomeIcons.comment,
                        color: HexColor(mainColor),
                      ),
                    ),
                    if (model.readAt == null)
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 5.0,
                          backgroundColor: HexColor(green),
                        ),
                      ),
                  ],
                ),
                space10Horizontal,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MainCubit.get(context).isRtl
                            ? model.data.title.ar
                            : model.data.title.en,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      space8Vertical,
                      Text(
                        MainCubit.get(context).isRtl
                            ? model.data.body.ar
                            : model.data.body.en,
                        style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: HexColor(secondaryVariantDark),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
