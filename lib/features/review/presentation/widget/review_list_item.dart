import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_empire_app/core/models/product_details_model.dart';
import 'package:medical_empire_app/core/util/constants.dart';

class ReviewListItem extends StatelessWidget {

  final ReviewsModel model;

  const ReviewListItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'NOV 22, 2021',
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: Theme.of(context).textTheme.caption,
          // ),
          Text(
            model.body,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: HexColor(grey),
            ),
          ),
          space10Vertical,
          RatingBar.builder(
            ignoreGestures: true,
            tapOnlyMode: true,
            updateOnDrag: false,
            initialRating: model.rating.toDouble(),
            minRating: 1,
            itemSize: 16.0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: HexColor(secondColor),
            ),
            onRatingUpdate: (rating) {
              // print(rating);
            },
          ),
        ],
      ),
    );
  }
}
