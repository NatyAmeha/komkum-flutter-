import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/coupon_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/coupons_widget/coupon_card.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';

class CouponScreen extends StatefulWidget {
  static const routeName = "/coupon/:id";
  String couponId;
  CouponScreen({required this.couponId});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  var couponController = Get.put(CouponController());

  loadData(BuildContext context) {
    Future.delayed(Duration.zero, () {
      couponController.getCouponDetails(widget.couponId, context);
    });
  }

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: couponController.couponDetails != null,
          exception: couponController.exception,
          isDataLoading: couponController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text("Coupon details"),
                centerTitle: true,
                expandedHeight: 300,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: couponController.couponDetails != null
                      ? Stack(
                          children: [
                            CustomContainer(
                              height: 250,
                              color: Colors.green,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      "${couponController.couponDetails?.couponInfo?.name} ",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CouponCard(coupon: [
                                    couponController.couponDetails!
                                  ]),
                                ),
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomText(
                    "${couponController.couponDetails?.couponInfo?.description} ",
                    textStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              if (couponController.couponDetails?.services?.isNotEmpty ==
                  true) ...[
                ListHeader("Select Services"),
                ServiceList(
                  services: couponController.couponDetails!.services!,
                  isSliver: true,
                  listtype: ServiceListType.VERTICAL,
                  discount: couponController
                          .couponDetails?.couponInfo?.discountAmount ??
                      0,
                )
              ]
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        CustomButton("Order Using Coupon", onPressed: () {})
      ],
    );
  }
}
