import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class VerticalServiceListTile extends StatelessWidget {
  ServiceViewmodel serviceInfo;
  double height;
  int discount;

  VerticalServiceListTile(
      {required this.serviceInfo, this.height = 200, this.discount = 0});
  var carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    print("service discount amount $discount");
    var servicePriceRange = UIHelper.getServicePriceRange(serviceInfo);

    return CustomContainer(
        onTap: () {
          UIHelper.goToScreen(context, "/service/${serviceInfo.service?.id}");
        },
        child: Row(
          children: [
            Container(
              height: height,
              width: 150,
              child: Stack(
                children: [
                  ImageCarousel(
                    images: serviceInfo.service?.images ?? [],
                    controller: carouselController,
                    height: height,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  serviceInfo.service?.name ?? "",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                UIHelper.showPrice(
                  context,
                  minPrice: servicePriceRange.min,
                  maxPrice: servicePriceRange.max,
                  discountAmount: discount,
                ),
                const SizedBox(height: 8),
                CustomContainer(
                  height: 60,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CustomText(
                        "${serviceInfo.reviewInfo?.reviews?.length ?? 4.5}",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      CustomRatingBar(
                        ratingValue: serviceInfo.reviewInfo?.rating ?? 4.5,
                        starCount: 1,
                        size: 50,
                      ),
                      if (serviceInfo.service?.tags?.isNotEmpty == true)
                        ...serviceInfo.service!.tags!.map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(e),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomBadge(
                  content: Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          serviceInfo.service?.businessName ?? "",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
