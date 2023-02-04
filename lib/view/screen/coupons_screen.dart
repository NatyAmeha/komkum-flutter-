import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/coupon_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/ccoupon_customization_screen.dart';
import 'package:komkum/view/screen/order_summary_screen.dart';
import 'package:komkum/view/widget/coupons_widget/coupon_card.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/qty_selector.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

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
                      : const SizedBox(),
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
              if (couponController.customizedProductsFromCoupon.isNotEmpty) ...[
                ListHeader("Selected", topPadding: 16),
                buildSelectedProductFromCouponService()
              ],
              if (couponController.couponDetails?.services?.isNotEmpty ==
                  true) ...[
                ListHeader(
                  "Available services",
                  subtitle: "Select products from below services",
                ),
                Obx(
                  () => ServiceList(
                    services: couponController.couponDetails!.services!,
                    isSliver: true,
                    listtype: ServiceListType.VERTICAL,
                    discount: couponController
                            .couponDetails?.couponInfo?.discountAmount ??
                        0,
                    selectedServiceindexes:
                        couponController.customizedServicesIndexes,
                    onServiceSelected: (selectedService) {
                      UIHelper.goToScreen(
                        context,
                        CouponCustomizationScreen.routeName,
                        extra: {
                          "COUPON": couponController.couponDetails,
                          "CALLTOACTION":
                              selectedService?.service?.callToAction ??
                                  "Service Call",
                          "PRODUCTS": selectedService?.serviceItems,
                        },
                      );
                    },
                  ),
                )
              ]
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        CustomButton("Order Using Coupon", onPressed: () {
          var isAllSelected = canActivateOrderCouponBtn();
          if (!isAllSelected) {
            UIHelper.showToast(context,
                "You need order or book atleast 1 product from each services");
          } else {
            UIHelper.goToScreen(
              context,
              OrderSummaryScreen.routeName,
              extra: {
                "CALLTOACTION": "Complete Order/Booking",
                "ORDERNAME":
                    "${couponController.couponDetails?.couponInfo?.name}"
              },
            );
          }
        })
      ],
    );
  }

  bool canActivateOrderCouponBtn() {
    var serviceIdsFromCustomizedOrderItems = couponController
        .customizedProductsFromCoupon
        .map((e) => e.product?.service)
        .toSet();

    return serviceIdsFromCustomizedOrderItems.length ==
        couponController.couponDetails?.services?.length;
  }

  Widget buildSelectedProductFromCouponService() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: couponController.customizedProductsFromCoupon.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomContainer(
              onTap: () {
                UIHelper.showBottomSheetDialog(
                  context,
                  body: buildOrderedItemDetailModal(
                      context,
                      couponController.customizedProductsFromCoupon[index],
                      index),
                );
              },
              padding: 4,
              color: Colors.grey[200],
              width: 170,
              height: 100,
              child: Row(
                children: [
                  CustomImage(
                    couponController.customizedProductsFromCoupon[index].image,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "${couponController.customizedProductsFromCoupon[index].product?.name}",
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          "Qty  ${couponController.customizedProductsFromCoupon[index].qty}",
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderedItemDetailModal(
      BuildContext context, OrderItemViewmodel orderitem, int index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomImage(
                      orderitem.image,
                      width: 100,
                      height: 120,
                    ),
                    if (orderitem.coupon?.discountAmount?.isGreaterThan(0) ==
                        true)
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomBadge(
                          borderColor: Colors.green,
                          badgeColor: Colors.green,
                          borderRadius: 0,
                          content: CustomText(
                            "${orderitem.coupon?.discountAmount}% Off",
                            textStyle: Theme.of(context).textTheme.caption,
                            color: Colors.white,
                          ),
                        ),
                      ))
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "${orderitem.service?.name}",
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        color: Colors.blue,
                      ),
                      CustomText(
                        "${orderitem.name}",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      UIHelper.showPrice(
                        context,
                        fixedPrice: (orderitem.price ?? 0) * orderitem.qty,
                        discountAmount: orderitem.coupon?.discountAmount ?? 0,
                        fontSize: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            QtySelector(
              qty: couponController.customizedProductsFromCoupon[index].qty,
              showQtyText: true,
              onAddQty: () {
                couponController.addQtyToCustomizedItem(orderitem);
              },
              onRemoveQty: () {
                couponController.removeQtyCustomizedItem(orderitem);
              },
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            CustomButton("Remove", onPressed: () {
              couponController.removeItemFromCustomizedOrder(orderitem);
              UIHelper.goBack(context);
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
