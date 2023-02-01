import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
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
                  children: [
                    CustomText(
                      "${orderInfo?.order?.name}",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      "${orderInfo?.order?.price}",
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(width: 16),
              CustomText(
                "${DateFormat.yMd(orderInfo?.order?.dateCreated)}",
                textStyle: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
          const Divider(height: 16),
        ],
      ),
    );
  }
}
