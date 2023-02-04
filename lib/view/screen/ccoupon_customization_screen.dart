import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/coupon_controller.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class CouponCustomizationScreen extends StatefulWidget {
  static const routeName = "/customizecoupon";

  CouponViewmodel couponViewmodel;
  List<Product> serviceProducts;
  String callToActionText;

  CouponCustomizationScreen({
    required this.serviceProducts,
    required this.callToActionText,
    required this.couponViewmodel,
  });

  @override
  State<CouponCustomizationScreen> createState() =>
      _CouponCustomizationScreenState();
}

class _CouponCustomizationScreenState extends State<CouponCustomizationScreen> {
  var loadOrderController = Get.lazyPut(() => Ordercontroller());

  var orderController = Get.find<Ordercontroller>();
  var couponController = Get.find<CouponController>();
  var expanedPanelIndex = 0;
  List<OrderItemViewmodel> customizedItems = [];
  bool canActivateButton = false;
  var totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose one or more products"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
      ),
      body: Obx(() => UIHelper.displayContent(
            showWhen: true,
            exception: orderController.exception,
            isDataLoading: orderController.isDataLoading,
            content: ProductList(
              products: widget.serviceProducts,
              isSliver: false,
              shrinkWrap: true,
              callToAction: widget.callToActionText,
              height: 320,
              showDetailsInDialog: true,
              showCouponFooter: true,
              discountAmount:
                  widget.couponViewmodel.couponInfo?.discountAmount ?? 0,
              onOrderedItemSelected: (orderedItem) {
                setState(() {
                  addToCustomizedOrderdItems(orderedItem);
                });
              },
            ),

            // SingleChildScrollView(
            //   child: ExpansionPanelList(
            //     elevation: 3,
            //     dividerColor: Colors.grey,
            //     expandedHeaderPadding: const EdgeInsets.all(0),
            //     expansionCallback: (panelIndex, isExpanded) {
            //       setState(() {
            //         expanedPanelIndex = panelIndex;
            //       });
            //     },
            //     animationDuration: const Duration(milliseconds: 00),
            //     children: widget.couponViewmodel.services!
            //         .asMap()
            //         .entries
            //         .map(
            //           (entries) => ExpansionPanel(
            //             canTapOnHeader: true,
            //             isExpanded: expanedPanelIndex == entries.key,
            //             headerBuilder: (context, isExpanded) => Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 16, vertical: 8),
            //               child: CheckboxListTile(
            //                 value: isProductCustomomizedForOrder(
            //                     entries.value.serviceItems!),
            //                 contentPadding: EdgeInsets.zero,
            //                 enabled: true,
            //                 controlAffinity: ListTileControlAffinity.leading,
            //                 onChanged: (value) {},
            //                 title: CustomText(
            //                   "${entries.value.service?.name}",
            //                   textStyle: Theme.of(context).textTheme.titleLarge,
            //                 ),
            //                 subtitle: CustomText(
            //                   "${widget.couponViewmodel.services![entries.key].service?.businessName}",
            //                   textStyle: Theme.of(context).textTheme.bodyMedium,
            //                 ),
            //               ),
            //             ),
            //             body: ProductList(
            //               products: entries.value.serviceItems,
            //               isSliver: false,
            //               shrinkWrap: true,
            //               callToAction: entries.value.service?.callToAction,
            //               height: 320,
            //               showDetailsInDialog: true,
            //               showCouponFooter: true,
            //               discountAmount: widget
            //                       .couponViewmodel.couponInfo?.discountAmount ??
            //                   0,
            //               onOrderedItemSelected: (orderedItem) {
            //                 setState(() {
            //                   addToCustomizedOrderd(orderedItem);
            //                 });
            //               },
            //             ),
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),
          )),
      persistentFooterButtons: [
        CustomButton(enabled: canActivateButton, "Continue", onPressed: () {
          couponController.persistent = "newly added data";
          couponController.customizedProductsFromCoupon.addAll(customizedItems);
          UIHelper.goBack(context);
        })
        //   Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       SizedBox(
        //         height: 70,
        //         width: MediaQuery.of(context).size.width,
        //         child: ListView.builder(
        //           shrinkWrap: true,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: customizedItems.length,
        //           itemBuilder: (context, index) => Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 8),
        //             child: CustomContainer(
        //               padding: 4,
        //               color: Colors.grey[200],
        //               width: 170,
        //               height: 100,
        //               child: Row(
        //                 children: [
        //                   CustomImage(
        //                     customizedItems[index].image,
        //                     width: 50,
        //                     height: 50,
        //                   ),
        //                   const SizedBox(width: 8),
        //                   Expanded(
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         CustomText(
        //                           "${customizedItems[index].product?.name}",
        //                           textStyle:
        //                               Theme.of(context).textTheme.bodyMedium,
        //                         ),
        //                         const SizedBox(height: 8),
        //                         CustomText(
        //                           "Qty - ${customizedItems[index].qty}",
        //                           textStyle:
        //                               Theme.of(context).textTheme.bodySmall,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 16),
        //       CustomButton(
        //           enabled: canActivateButton,
        //           "Order (${totalPrice} Birr)", onPressed: () {
        //         UIHelper.goToScreen(
        //           context,
        //           OrderSummaryScreen.routeName,
        //           extra: {
        //             "CALLTOACTION": "Order using Coupon",
        //           },
        //         );
        //       })
        //     ],
        //   )
      ],
    );
  }

  addToCustomizedOrderdItems(OrderItemViewmodel item) {
    print("item business info , ${item.business?.id}");
    item.coupon = widget.couponViewmodel.couponInfo;
    item.service = widget.couponViewmodel.services
        ?.firstWhereOrNull(
            (serviceInfo) => serviceInfo.service?.id == item.product?.service)
        ?.service;
    item.business = Business(
        id: item.business?.id, name: widget.couponViewmodel.couponInfo?.name);
    item.coupon = widget.couponViewmodel.couponInfo;
    var isExistBeforeInList = customizedItems
        .indexWhere((element) => element.product?.id == item.product?.id);
    if (isExistBeforeInList > -1) {
      customizedItems[isExistBeforeInList] = item;
    } else {
      customizedItems.add(item);
    }
    // totalPrice = customizedItems.sum((orderItem) =>
    //     (orderItem.price! * orderItem.qty) -
    //     (((orderItem.price! * orderItem.qty) *
    //             widget.couponViewmodel.couponInfo!.discountAmount!) ~/
    //         100));
    canActivateButton = canActivateOrderButton();
  }

  bool isProductCustomomizedForOrder(List<Product> serviceProducts) {
    var customizedProductids =
        customizedItems.map((e) => e.product?.id).toList();
    var serviceproductsIds = serviceProducts.map((e) => e.id).toList();
    return customizedProductids.any(
      (customizedProductId) => serviceproductsIds.contains(customizedProductId),
    );
  }

  bool canActivateOrderButton() {
    var serviceIdsFromCustomizedOrderItems =
        customizedItems.map((e) => e.product?.service).toSet();

    return serviceIdsFromCustomizedOrderItems.isNotEmpty;
  }
}
