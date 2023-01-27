import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_collection.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessTile extends StatelessWidget {
  BusienssViewmodel businessInfo;
  double height;
  double width;
  BusinessTile({
    required this.businessInfo,
    this.height = 300,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CustomContainer(
          onTap: () {
            UIHelper.goToScreen(
                context, "/business/${businessInfo.businessInfo?.id}");
          },
          borderRadius: 4,
          width: width,
          height: height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "${businessInfo.businessInfo?.name}",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              "${businessInfo.reviewInfo?.rating}",
                              textStyle: Theme.of(context).textTheme.titleSmall,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            CustomRatingBar(
                              ratingValue: businessInfo.reviewInfo?.rating ?? 5,
                              size: 30,
                              starCount: 1,
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              "(${businessInfo.reviewInfo?.count ?? 0} reviews)",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.directions),
                            const SizedBox(width: 8),
                            CustomText(
                              "(${businessInfo.businessInfo?.addresses?.first.localAddress})",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  CustomImage(
                    businessInfo.businessInfo?.images?.first,
                    width: 100,
                    height: 120,
                  ),
                ],
              ),
              Divider(height: 16),
              if (businessInfo.services?.isNotEmpty == true)
                ...businessInfo.services!
                    .map(
                      (serviceViewmodel) => KeyPointWidget(
                          text: serviceViewmodel.service?.name ?? ""),
                    )
                    .toList(),
              if ((businessInfo.services?.length ?? 0) > 1)
                KeyPointWidget(text: "+2 services")
            ],
          )),
    );
  }
}
