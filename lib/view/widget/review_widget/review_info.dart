import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';

class ReviewInfo extends StatelessWidget {
  ReviewViewmodel reviewViewmodel;
  bool showKeyPointReview;
  ReviewInfo({required this.reviewViewmodel, this.showKeyPointReview = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "${reviewViewmodel.rating}",
              textStyle: Theme.of(context).textTheme.displayMedium,
            ),
            CustomRatingBar(
              ratingValue: reviewViewmodel.rating,
              size: 20,
              starCount: 5,
            ),
            CustomText(
              "${reviewViewmodel.count ?? reviewViewmodel.reviews?.length} reviews",
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const SizedBox(width: 24),
        if (showKeyPointReview)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: reviewViewmodel.keyPoint!
                  .map((keyPoint) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  "${keyPoint.key} ",
                                  textStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  "${keyPoint.rating} ",
                                  textStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                                CustomRatingBar(
                                  size: 20,
                                  starCount: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              color: Colors.amberAccent,
                              value: (keyPoint.rating ?? 0) / 5,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
      ],
    );
  }
}
