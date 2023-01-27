import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/timer_counter.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponTile extends StatelessWidget {
  CouponViewmodel couponViewmodel;
  double width;
  double height;
  CouponTile({
    required this.couponViewmodel,
    this.width = double.infinity,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: 0,
      margin: 8,
      color: Colors.blueGrey,
      borderColor: Colors.green,
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if ((couponViewmodel.couponInfo?.images?.length ?? 0) > 0)
          //   CustomImage(
          //     couponViewmodel.couponInfo?.images?[0],
          //     width: 150,
          //     height: height,
          //   ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "${couponViewmodel.couponInfo?.name}",
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "${couponViewmodel.couponInfo?.description}",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    maxLine: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  TimerCounter(timeInSecond: 234567, onFinished: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
