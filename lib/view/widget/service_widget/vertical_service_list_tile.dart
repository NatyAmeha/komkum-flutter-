import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class VerticalServiceListTile extends StatelessWidget {
  ServiceViewmodel serviceInfo;
  double height;

  VerticalServiceListTile({required this.serviceInfo, this.height = 200});
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: Row(
      children: [
        Stack(
          children: [
            ImageCarousel(
              images: serviceInfo.service?.images ?? [],
              controller: carouselController,
              height: height,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
            child: Column(
          children: [
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
                children: [Text("Business name")],
              ),
            )
          ],
        ))
      ],
    ));
  }
}
