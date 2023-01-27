import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/timer_counter.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponCard extends StatelessWidget {
  List<CouponViewmodel> coupon;
  CouponCard({required this.coupon});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var couponRemainingTime = 0;
    var remainingCoupons = 0;
    var discount = 0;
    var activeCoupons =
        coupon.where((cp) => cp.couponInfo?.endDate?.isAfter(today) == true);
    if (activeCoupons.isNotEmpty) {
      var selectedCoupon = activeCoupons.first;
      var coupons = selectedCoupon.couponInfo?.couponCodes
          ?.where((cp) => cp.used == false)
          .toList();
      remainingCoupons = coupons?.length ?? 0;
      couponRemainingTime =
          selectedCoupon.couponInfo?.endDate?.difference(today).inSeconds ?? 0;
      discount = selectedCoupon.couponInfo?.discountAmount ?? 0;
    }
    if (remainingCoupons > 0 && couponRemainingTime > 0) {
      return Card(
        child: CustomContainer(
            color: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Remaining Coupons",
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    CircleAvatar(
                      child: CustomText(
                        "${remainingCoupons}",
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Divider(height: 16, thickness: 2),
                KeyPointWidget(text: "${discount}% discount"),
                Row(
                  children: [
                    KeyPointWidget(text: "Expires in"),
                    const SizedBox(width: 16),
                    TimerCounter(
                      timeInSecond: couponRemainingTime,
                      color: Colors.transparent,
                      onFinished: () {},
                    ),
                  ],
                )
              ],
            )),
      );
    } else {
      return const SizedBox();
    }
  }
}
