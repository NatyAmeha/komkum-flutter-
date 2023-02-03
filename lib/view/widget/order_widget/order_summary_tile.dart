import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
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
  OrderSummaryTile({
    required this.orderedItemInfo,
    this.onQtyAdd,
    this.onQtyRemove,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImage(orderedItemInfo.image, width: 100, height: 100),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "${orderedItemInfo.business?.name}",
                textStyle: Theme.of(context).textTheme.bodySmall,
                color: Colors.blue,
              ),
              CustomText(
                "${orderedItemInfo.name}",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              UIHelper.showPrice(
                context,
                fixedPrice: orderedItemInfo.price,
                fontSize: 18,
              ),
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
