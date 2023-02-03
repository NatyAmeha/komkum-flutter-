import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/order_widget/order_summary_tile.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

import '../../controller/order_controller.dart';

class OrderSummaryScreen extends StatefulWidget {
  static const routeName = "/summary";
  String? callToAction;
  OrderSummaryScreen({this.callToAction});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  var orderController = Get.put(Ordercontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary"), centerTitle: true),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            ListHeader(
              "Select shipping Address",
              showMore: true,
              trailing: const Text("Change address"),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                const SizedBox(height: 16),
                CustomButton("Select Shipping Address", onPressed: () {}),
                const SizedBox(height: 16),
                const Divider(thickness: 1),
              ]),
            ),
            ListHeader(
              "Items",
              showMore: true,
              trailing:
                  Text("${orderController.appController.cartCount} items"),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: orderController.appController.cartCount,
                (context, index) => OrderSummaryTile(
                  orderedItemInfo: orderController.appController.cart[index],
                  onQtyAdd: () {
                    orderController.appController.addQty(
                      orderController.appController.cart[index].product!.id!,
                    );
                  },
                  onQtyRemove: () {
                    orderController.appController.removeQty(
                      orderController.appController.cart[index].product!.id!,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "Total",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      CustomText(
                        "${orderController.appController.totalPrice} Birr",
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        CustomButton(widget.callToAction ?? "Complete", onPressed: () {})
      ],
    );
  }
}
