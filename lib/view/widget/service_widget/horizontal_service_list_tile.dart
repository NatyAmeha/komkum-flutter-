import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/service_detail_screen.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class HorizontalServiceListTile extends StatelessWidget {
  ServiceViewmodel serviceInfo;
  double height;
  double width;
  int discount;

  HorizontalServiceListTile(
      {required this.serviceInfo,
      required this.height,
      required this.width,
      this.discount = 0});

  @override
  Widget build(BuildContext context) {
    var carouselController = CarouselController();
    return Card(
      child: CustomContainer(
          margin: 8,
          padding: 0,
          height: height,
          width: width,
          onTap: () {
            UIHelper.goToScreen(context, "/service/${serviceInfo.service?.id}");
          },
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCarousel(
                    images: serviceInfo.service?.images ?? [],
                    controller: carouselController,
                    autoScroll: true,
                    height: 150,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    serviceInfo.service?.name ?? "",
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "150 Birr - 600 Birr",
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  CustomContainer(
                    padding: 0,
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          "${serviceInfo.reviewInfo?.rating ?? 5}",
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                        CustomRatingBar(starCount: 1, size: 20),
                        // CustomBadge(
                        //   text: "${serviceInfo.coupons?.length} coupons",
                        //   borderColor: Colors.green,
                        //   badgeColor: Colors.transparent,
                        // ),
                        CustomText(
                          "${serviceInfo.reviewInfo?.count ?? 0} reviews",
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // if (serviceInfo.service?.tags?.isNotEmpty == true)
                        //   ...serviceInfo.service!.tags!.map(
                        //     (e) => Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 8),
                        //       child: Text(e),
                        //     ),
                        //   )
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
          )),
    );
  }
}
