import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:komkum/controller/service_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/coupons_widget/coupon_card.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_collection.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/photo_viewer.dart';
import 'package:komkum/view/widget/review_widget/review_info.dart';
import 'package:komkum/view/widget/service_widget/category_list_tile.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class ServiceDetailScreen extends StatefulWidget {
  static const routeName = "/service/:id";
  String serviceId;
  ServiceDetailScreen({required this.serviceId});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  var serviceController = Get.put(ServiceController());

  loadData(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      serviceController.getServiceDetails(widget.serviceId, context);
    });
  }

  @override
  void initState() {
    print("controller init  state");
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: true,
          exception: serviceController.exception,
          isDataLoading: serviceController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: InkWell(
                    onTap: () {
                      PhotoViewer(
                          images: serviceController
                              .serviceDetails!.service!.images!);
                    },
                    child: Text(
                        serviceController.serviceDetails?.service?.name ?? "")),
                centerTitle: true,
              ),
              if (serviceController
                      .serviceDetails?.service?.images?.isNotEmpty ==
                  true)
                SliverToBoxAdapter(
                  child: CustomContainer(
                    padding: 0,
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ImageCollection(
                          images: serviceController
                                  .serviceDetails?.service?.images ??
                              [],
                        ),
                        if (serviceController
                                .serviceDetails!.service!.images!.length >
                            4)
                          Positioned.fill(
                              right: 50,
                              bottom: 50,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CustomText(
                                  "+${serviceController.serviceDetails!.service!.images!.length - 4}",
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                              ))
                      ],
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "${serviceController.serviceDetails?.service?.name} ",
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontWeight: FontWeight.bold,
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        "${serviceController.serviceDetails?.service?.description} ",
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          KeyPointWidget(
                              text:
                                  "${serviceController.serviceDetails?.service?.viewCount} views"),
                          const SizedBox(width: 8),
                          KeyPointWidget(
                              text:
                                  "${serviceController.serviceDetails?.serviceItems?.length} services")
                        ],
                      ),
                      CustomContainer(
                        padding: 0,
                        color: Colors.grey,
                        child: ListTile(
                          title: CustomText(
                            "${serviceController.serviceDetails?.serviceItems?.length} Products",
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      // show review info ----------------------------------------------
                      if (serviceController.serviceDetails?.reviewInfo?.reviews
                              ?.isNotEmpty ==
                          true) ...[
                        ListHeader(
                          "Rating and reviews",
                          startPadding: 0,
                          showMore: true,
                          isSliver: false,
                          onClick: () {
                            UIHelper.goToScreen(context, "/reviews",
                                queryParam: {
                                  "id":
                                      "${serviceController.serviceDetails?.service?.id}"
                                },
                                extra: {
                                  "name": serviceController
                                      .serviceDetails?.service?.name,
                                  "type": ReviewDataType.SERVCIE_REVIEW,
                                });
                          },
                        ),
                        ReviewInfo(
                            reviewViewmodel:
                                serviceController.serviceDetails!.reviewInfo!),
                      ],

                      if (serviceController
                              .serviceDetails?.coupons?.isNotEmpty ==
                          true)
                        CouponCard(
                            coupon: serviceController.serviceDetails!.coupons!)
                    ],
                  ),
                ),
              ),
              if ((serviceController.serviceDetails?.service?.images?.length ??
                      0) >
                  4) ...[
                ListHeader("Categories"),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: GridView.builder(
                      itemBuilder: (context, index) => CategoryTile(
                        category:
                            serviceController.serviceProductCategories[0]!,
                        width: 200,
                        height: 50,
                      ),
                      itemCount:
                          serviceController.serviceProductCategories.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                      ),
                    ),
                  ),
                ),
              ],
              if (serviceController.serviceDetails?.serviceItems?.isNotEmpty ==
                  true) ...[
                ListHeader("Choose Options"),
                ProductList(
                  products: serviceController.serviceDetails!.serviceItems!,
                  height: 320,
                  discountAmount: serviceController.discountAmount * 2,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
