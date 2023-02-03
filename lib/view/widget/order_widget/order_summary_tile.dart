import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/qty_selector.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class OrderSummaryTile extends StatelessWidget {
  OrderItemViewmodel orderedItemInfo;
  Function? onQtyAdd;
  Function? onQtyRemove;
  int discountPercent;
  OrderSummaryTile(
      {required this.orderedItemInfo,
      this.onQtyAdd,
      this.onQtyRemove,
      this.discountPercent = 0});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: Row(
      children: [
        Stack(
          children: [
            CustomImage(orderedItemInfo.image, width: 100, height: 120),
            if (orderedItemInfo.coupon?.discountAmount?.isGreaterThan(0) ==
                true)
              Positioned(
                  child: Align(
                alignment: Alignment.topLeft,
                child: CustomBadge(
                  borderColor: Colors.green,
                  badgeColor: Colors.green,
                  borderRadius: 0,
                  content: CustomText(
                    "${orderedItemInfo.coupon?.discountAmount}% Off",
                    textStyle: Theme.of(context).textTheme.caption,
                    color: Colors.white,
                  ),
                ),
              ))
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                "${orderedItemInfo.business?.name} > ${orderedItemInfo.service?.name}",
                textStyle: Theme.of(context).textTheme.bodySmall,
                color: Colors.blue,
              ),
              CustomText(
                "${orderedItemInfo.name}",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              UIHelper.showPrice(context,
                  fixedPrice: orderedItemInfo.price,
                  fontSize: 18,
                  discountAmount: orderedItemInfo.coupon?.discountAmount ?? 0),
              const SizedBox(width: 16),
              QtySelector(
                qty: orderedItemInfo.qty,
                showQtyText: false,
                onAddQty: () {
                  onQtyAdd?.call();
                },
                onRemoveQty: () {
                  onQtyRemove?.call();
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
