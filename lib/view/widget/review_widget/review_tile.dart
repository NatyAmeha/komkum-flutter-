import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
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
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 20,
                backgroundImage: reviewInfo.profileImage != null
                    ? NetworkImage(reviewInfo.profileImage!)
                    : null,
                child: reviewInfo.profileImage == null
                    ? CustomText("${reviewInfo.username?[0]}")
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "${reviewInfo.username} ",
                      textStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    CustomRatingBar(ratingValue: finalRating, size: 20)
                  ],
                ),
              ),
              CustomText(
                "${DateFormat.yMd().format(reviewInfo.dateCreated!)}",
                textStyle: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
          const SizedBox(height: 16),
          CustomText(
            "${reviewInfo.description}",
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          if (reviewInfo.keyPoints?.isNotEmpty == true)
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: reviewInfo.keyPoints!
                    .map((review) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                              avatar: CircleAvatar(
                                  child: CustomText("${review.rating}")),
                              backgroundColor: Colors.grey[60],
                              label: CustomText("${review.key}"),
                              shadowColor: Colors.grey[400],
                              padding: const EdgeInsets.all(8.0)),
                        ))
                    .toList(),
              ),
            ),
          const Divider(thickness: 1, height: 16),
        ],
      ),
    );
  }
}
