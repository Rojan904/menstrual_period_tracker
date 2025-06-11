import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingComponent extends StatelessWidget {
  const RatingComponent(
      {Key? key,
      required this.initialRating,
      this.ignoreGestures = false,
      this.color = Colors.amber,
      this.onRatingUpdate,
      this.itemSize,
      this.unratedColor,
      this.itemCount})
      : super(key: key);
  final double initialRating;
  final bool ignoreGestures;
  final Color color;
  final Color? unratedColor;

  final double? itemSize;
  final Function(double)? onRatingUpdate;
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      unratedColor: unratedColor,
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount ?? 5,
      itemSize: itemSize ?? 30,
      ignoreGestures: ignoreGestures,
      ratingWidget: RatingWidget(
          full: Icon(
            Icons.water_drop,
            color: color,
          ),
          half: Icon(
            Icons.water_drop,
            color: color,
          ),
          empty: Icon(
            Icons.water_drop_outlined,
            color: color,
          )),
      // itemBuilder: (BuildContext context, int index) {
      //   return Icon(
      //     Icons.water_drop_outlined,
      //     color: color,
      //   );
      // },
      onRatingUpdate: onRatingUpdate != null ? onRatingUpdate! : (rating) {},
    );
  }
}
