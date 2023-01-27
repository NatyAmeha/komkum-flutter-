import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/coupon.tile.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponsList extends StatelessWidget {
  List<CouponViewmodel> coupons;
  bool isSliver;
  CouponsList({required this.coupons, this.isSliver = true});

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverToBoxAdapter(
          child: Container(
        height: 200,
        width: 350,
        child: ListView.builder(
          itemCount: coupons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => CouponTile(
            couponViewmodel: coupons[index],
            height: 200,
            width: 350,
          ),
        ),
      ));
    } else {
      return Container(
        height: 300,
        width: double.infinity,
        child: ListView.builder(
          itemCount: coupons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => CouponTile(
            couponViewmodel: coupons[index],
            height: 300,
          ),
        ),
      );
    }
  }
}
