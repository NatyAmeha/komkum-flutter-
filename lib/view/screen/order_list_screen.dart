import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/order_widget/order_tile.dart';

class OrderListScreen extends StatefulWidget {
  static const routeName = "/orders";
  OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  var orderController = Get.put(Ordercontroller());

  loadData(BuildContext context) {
    Future.delayed(Duration.zero, () {
      orderController.getUserOrders(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: orderController.orderLists?.isNotEmpty == true,
          exception: orderController.exception,
          isDataLoading: orderController.isDataLoading,
          content: ListView.builder(
            itemCount: orderController.orderLists?.length,
            itemBuilder: (context, index) =>
                OrderTile(orderInfo: orderController.orderLists?[index]),
          ),
        ),
      ),
    );
  }
}
