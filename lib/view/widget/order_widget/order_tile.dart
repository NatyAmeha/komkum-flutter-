import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

class OrderTile extends StatelessWidget {
  OrderViewmodel? orderInfo;
  OrderTile({this.orderInfo});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        UIHelper.goToScreen(context, "/order/${orderInfo?.order?.id}");
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomImage(
                orderInfo?.order?.image?.first,
                width: 75,
                height: 75,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "${orderInfo?.order?.name}",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    UIHelper.showPrice(context,
                        fixedPrice: orderInfo?.order?.price,
                        minPrice: orderInfo?.order?.priceRange?.min,
                        maxPrice: orderInfo?.order?.priceRange?.max),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              CustomText(
                "${DateFormat.yMd().format(orderInfo?.order?.dateCreated ?? DateTime.now())}",
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(height: 16),
        ],
      ),
    );
  }
}
