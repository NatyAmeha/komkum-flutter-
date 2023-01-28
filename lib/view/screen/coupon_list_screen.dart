import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/coupon.tile.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';

class CouponListScreen extends StatefulWidget {
  static const routeName = "/coupons";
  List<CouponViewmodel>? coupons;

  CouponListScreen({this.coupons});
  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupons"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CouponTile(
          couponViewmodel: widget.coupons![index],
          height: 200,
        ),
        itemCount: widget.coupons?.length,
      ),
    );
  }
}
