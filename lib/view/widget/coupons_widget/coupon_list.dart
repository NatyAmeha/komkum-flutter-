import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/coupon.tile.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponList extends StatelessWidget {
  List<CouponViewmodel>? coupons;

  CouponList({this.coupons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => CouponTile(
        couponViewmodel: coupons![index],
        height: 200,
      ),
      itemCount: coupons?.length,
    );
  }
}
