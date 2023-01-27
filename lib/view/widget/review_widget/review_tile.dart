import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';

class ReviewTile extends StatelessWidget {
  Review reviewInfo;
  ReviewTile({required this.reviewInfo});

  @override
  Widget build(BuildContext context) {
    var totalRating = reviewInfo.keyPoints
            ?.map((kp) => kp.rating ?? 0)
            .toList()
            .sum((p0) => p0) ??
        0;
    var finalRating = totalRating / (reviewInfo.keyPoints?.length ?? 0);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 20,
                backgroundImage: reviewInfo.user?.profileImage != null
                    ? NetworkImage(reviewInfo.user!.profileImage!)
                    : null,
                child: reviewInfo.user?.profileImage == null
                    ? CustomText("${reviewInfo.user?.username?[0]}")
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "${reviewInfo.user?.username} ",
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    CustomRatingBar(ratingValue: finalRating)
                  ],
                ),
              ),
              CustomText(
                "${DateFormat.yMd().format(reviewInfo.dateCreated!)}",
                textStyle: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const SizedBox(height: 16),
          CustomText(
            "${reviewInfo.description}",
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          if (reviewInfo.keyPoints?.isNotEmpty == true)
            Container(
              height: 80,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: reviewInfo.keyPoints!
                    .map((review) => CustomBadge(
                          content:
                              CustomText("${review.key}   ${review.rating}"),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
