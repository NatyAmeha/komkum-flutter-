import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/utils/exception.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/page/error_page.dart';
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
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              text: "Bookings",
            ),
            Tab(
              text: "Purchases",
            )
          ]),
        ),
        body: Obx(
          () => UIHelper.displayContent(
            showWhen: orderController.orderLists != null,
            exception: orderController.exception,
            isDataLoading: orderController.isDataLoading,
            content: TabBarView(
              children: [
                orderController.bookings?.isNotEmpty == true
                    ? ListView.builder(
                        itemCount: orderController.bookings?.length,
                        itemBuilder: (context, index) => OrderTile(
                            orderInfo: orderController.bookings?[index]),
                      )
                    : ErrorPage(
                        exception: AppException(
                        message:
                            "Start browse services and order. Your orders will appear hear",
                        title: "No booking found",
                        actionText: "Browse services",
                      )),
                ListView.builder(
                  itemCount: orderController.orderLists?.length,
                  itemBuilder: (context, index) =>
                      OrderTile(orderInfo: orderController.orderLists?[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
