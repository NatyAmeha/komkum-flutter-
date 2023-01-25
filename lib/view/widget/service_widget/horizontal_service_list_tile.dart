import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class HorizontalServiceListTile extends StatelessWidget {
  ServiceViewmodel serviceInfo;
  double height;
  double width;

  HorizontalServiceListTile({
    required this.serviceInfo,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    var carouselController = CarouselController();
    return CustomContainer(
        child: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageCarousel(
              images: serviceInfo.service?.images ?? [],
              controller: carouselController,
              autoScroll: true,
              height: height * 0.5,
            ),
            const SizedBox(height: 8),
            CustomText(
              serviceInfo.service?.name ?? "",
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
            CustomText(
              "150 Birr - 600 Birr",
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            CustomContainer(
              height: 60,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RatingBarIndicator(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    rating: 5,
                    itemCount: 1,
                    itemSize: 50,
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
                children: [CustomText("Business name")],
              ),
            )
          ],
        ),
        Positioned.fill(
            left: 8,
            top: 8,
            child: Align(
              alignment: Alignment.topLeft,
              child: CustomBadge(
                text: "${serviceInfo.coupons?.length} coupons",
                badgeColor: Colors.redAccent,
              ),
            ))
      ],
    ));
  }
}
