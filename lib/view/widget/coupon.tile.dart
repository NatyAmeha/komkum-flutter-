import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(
            couponViewmodel.couponInfo?.images?.first,
            width: width * 0.4,
            height: height,
          ),
          Column(
            children: [
              CustomText(
                "${couponViewmodel.couponInfo?.name}",
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              CustomText(
                "${couponViewmodel.couponInfo?.description}",
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TimerCounter(timeInSecond: 234567, onFinished: () {})
            ],
          )
        ],
      ),
    );
  }
}
