import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/product_controller.dart';
import 'package:komkum/controller/service_controller.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/button_with_progressbar.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/custom_text_field.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/service_widget/product_variant_list_tile.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductDetailsDialog extends StatefulWidget {
  Product productInfo;
  String callToAction;
  int discountPercent;
  ProductDetailsDialog({
    required this.productInfo,
    required this.callToAction,
    this.discountPercent = 0,
  });

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  var serviceController = Get.find<ServiceController>();
  var qtyTextController = TextEditingController(text: "1");

  ProductVariant? selectedVariant;

  @override
  Widget build(BuildContext context) {
    if (widget.productInfo.variants?.isNotEmpty == true) {
      serviceController.changeSelectedVariant(widget.productInfo.id!, 0);
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomImage(
                      serviceController.selectedVariantIndex.value > -1
                          ? widget.productInfo.variants
                              ?.elementAt(
                                  serviceController.selectedVariantIndex.value)
                              .images
                              ?.first
                          : widget.productInfo.images?.first,
                      width: 120,
                      height: 130,
                    ),
                    if (widget.discountPercent > 0)
                      Positioned(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomBadge(
                          borderColor: Colors.green,
                          badgeColor: Colors.green,
                          borderRadius: 0,
                          content: CustomText(
                            "${widget.discountPercent}% Off",
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
                    children: [
                      CustomText(
                        "${widget.productInfo.name} ${serviceController.selectedVariantIndex.value > -1 ? widget.productInfo.variants?.elementAt(serviceController.selectedVariantIndex.value).moreInfo?.values.join(",") : ''}",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      UIHelper.showPrice(context,
                          fixedPrice: widget.productInfo.fixedPrice,
                          minPrice: widget.productInfo.minPrice,
                          maxPrice: widget.productInfo.maxPrice,
                          discountAmount: widget.discountPercent),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (widget.productInfo.moreInfo?.entries != null)
            ...widget.productInfo.moreInfo!.entries
                .map((e) => KeyPointWidget(text: "${e.key} -> ${e.value}"))
                .toList(),
          // CustomText(
          //   productController
          //           .productDetail?.serviceItem?.description ??
          //       "",
          //   textStyle: Theme.of(context).textTheme.titleMedium,
          // ),
          const Divider(height: 16),

          if (widget.productInfo.variants?.isNotEmpty == true) ...[
            ListHeader(
              "Choose options",
              isSliver: false,
              bottomPadding: 8,
              fontSize: 10,
              startPadding: 0,
            ),
            CustomContainer(
              padding: 0,
              height: 100,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 8),
                itemBuilder: (context, index) => Obx(
                  () => ProductVariantListTile(
                    productVariant: widget.productInfo.variants![index],
                    index: index,
                    SelectedIndex: serviceController.selectedVariantIndex.value,
                    onSelected: (newSelectedVariant) {
                      serviceController.changeSelectedVariant(
                          widget.productInfo.id!, index);
                    },
                  ),
                ),
                itemCount: widget.productInfo.variants?.length,
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
          const SizedBox(height: 16),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                "Qty",
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
              // const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              serviceController.remvoeQty();
                            },
                            icon: const Icon(Icons.remove)),
                        const SizedBox(width: 8),
                        Obx(() => CustomContainer(
                              width: 50,
                              height: 50,
                              color: Colors.grey[200],
                              child: CustomText(
                                "${serviceController.selectedQty}",
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                            )),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            serviceController.addQty();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1),
          TextButton(onPressed: () {}, child: Text("Add to cart")),
          const SizedBox(height: 8),
          ButtonWithProgressbar(
            text: widget.callToAction,
            isLoading: false,
            onClick: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
