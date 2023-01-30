import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';

class ReviewKeypointTile extends StatelessWidget {
  KeyReview keyReviewPoint;
  int index;
  int selectedIndex;
  Function(String)? onSelected;
  ReviewKeypointTile(
      {required this.keyReviewPoint,
      required this.index,
      required this.selectedIndex,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        onTap: () {
          onSelected?.call(keyReviewPoint.key!);
        },
        margin: 8,
        width: 200,
        height: 20,
        borderColor: selectedIndex == index ? Colors.green : Colors.grey,
        color: selectedIndex == index ? Colors.green : Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "${keyReviewPoint.key}",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                CustomText(
                  "${keyReviewPoint.rating}",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                CustomRatingBar(starCount: 1, size: 30, ratingValue: 5),
              ],
            ),
            const SizedBox(height: 8),
            CustomText(
              "${keyReviewPoint.count} reviews",
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ));
  }
}
