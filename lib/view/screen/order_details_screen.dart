import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/view/widget/review_widget/review_info.dart';
import 'package:komkum/view/widget/review_widget/review_tile.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = "/order/:id";
  String orderId;
  OrderDetailsScreen({required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var orderController = Get.find<Ordercontroller>();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      orderController.getOrderDetails(widget.orderId, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: orderController.orderDetails != null,
          exception: orderController.exception,
          isDataLoading: orderController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text("Order details"),
                centerTitle: true,
                pinned: true,
                expandedHeight: 350,
                flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      color: Colors.amberAccent,
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 16),
                    UIHelper.showPrice(context,
                        fixedPrice: orderController.orderDetails?.order?.price,
                        minPrice: orderController
                            .orderDetails?.order?.priceRange?.min,
                        maxPrice: orderController
                            .orderDetails?.order?.priceRange?.max,
                        fontSize: 20),
                    const SizedBox(height: 8),
                    CustomText(
                      "Code : ${orderController.orderDetails?.order?.code}",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: CustomText(
                        "15% total discount",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: CustomText(
                        "10% Cashback",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Divider(height: 16),
                  ],
                ),
              ),
              if (orderController.orderDetails?.items?.isNotEmpty == true) ...[
                ListHeader("Items"),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount:
                          orderController.orderDetails?.items?.length ?? 0,
                      (context, index) => ListTile(
                            leading: CustomImage(
                              orderController.orderDetails?.items?[index]
                                  .serviceItem?.images?.first,
                              width: 50,
                              height: 50,
                            ),
                            title: CustomText(
                              "${orderController.orderDetails?.items?[index].serviceItem?.name}",
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: CustomText(
                              "${orderController.orderDetails?.items?[index].price ?? '1500 Birr'}",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )),
                ),
              ],
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(height: 16),
                    orderController.orderDetails?.userReviewInfo?.reviews
                                ?.isNotEmpty ==
                            true
                        ? ReviewTile(
                            reviewInfo: orderController
                                .orderDetails!.userReviewInfo!.reviews!.first)
                        : ListTile(
                            leading: const Icon(Icons.reviews),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomText(
                                "Write review",
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            subtitle: CustomText(
                              "Give your honest rating and review to help other people",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                    const Divider(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Spacer(),
            CustomButton("Get Direction", onPressed: () {}),
          ],
        )
      ],
    );
  }
}
