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
  int index;
  ServiceViewmodel serviceInfo;
  double height;
  int discount;
  List<int> selectedServiceIndexes;
  Function? onServiceSelected;

  VerticalServiceListTile({
    required this.index,
    required this.serviceInfo,
    this.height = 200,
    this.discount = 0,
    this.selectedServiceIndexes = const [],
    this.onServiceSelected,
  });
  var carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    var servicePriceRange = UIHelper.getServicePriceRange(serviceInfo);

    return CustomContainer(
        onTap: () {
          if (onServiceSelected != null) {
            onServiceSelected!.call();
          } else {
            UIHelper.goToScreen(context, "/service/${serviceInfo.service?.id}");
          }
        },
        child: Row(
          children: [
            Container(
              height: height,
              width: 150,
              child: Stack(
                children: [
                  ImageCarousel(
                    images: serviceInfo.service?.images ?? [""],
                    controller: carouselController,
                    height: height,
                  ),
                  if (selectedServiceIndexes.contains(index))
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.white70,
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ))
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
                      if (serviceInfo.reviewInfo?.rating != null) ...[
                        CustomText(
                          "${serviceInfo.reviewInfo?.rating ?? 4.5}",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                        CustomRatingBar(
                          ratingValue: serviceInfo.reviewInfo?.rating ?? 4.5,
                          starCount: 1,
                          size: 50,
                        ),
                      ],
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
