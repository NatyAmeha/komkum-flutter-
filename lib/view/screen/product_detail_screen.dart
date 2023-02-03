import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/product_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/business_widget/business_info_tile.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/view/widget/key_point.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/view/widget/service_widget/product_variant_list_tile.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "/product/:id";
  String productId;
  ProductDetailScreen({required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var productController = Get.put(ProductController());

  loadData(BuildContext context) {
    Future.delayed(Duration.zero, () {
      productController.getProductDetails(widget.productId, context);
    });
  }

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var carouselController = CarouselController();
    return Scaffold(
      body: Obx(() => UIHelper.displayContent(
            showWhen: productController.productDetail != null,
            exception: productController.exception,
            isDataLoading: productController.isDataLoading,
            content: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  title: Text(
                      productController.productDetail?.serviceItem?.name ??
                          "Product Details"),
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ImageCarousel(
                      images:
                          productController.productDetail?.serviceItem?.images,
                      controller: carouselController,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                productController
                                        .productDetail?.serviceItem?.name ??
                                    "",
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Obx(
                              () => !productController.isProductInFavorite.value
                                  ? IconButton(
                                      icon: const Icon(Icons.favorite_outline),
                                      onPressed: () {
                                        productController.addProductToFavorite([
                                          productController
                                              .productDetail!.serviceItem!.id!
                                        ], context);
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        productController
                                            .removeProductFromFavorite([
                                          productController
                                              .productDetail!.serviceItem!.id!
                                        ], context);
                                      },
                                    ),
                            )
                          ],
                        ),
                      ),
                      productController
                                  .productDetail?.serviceItem?.fixedPrice !=
                              null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CustomText(
                                "${productController.productDetail?.serviceItem?.fixedPrice} Birr",
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CustomText(
                                "${productController.productDetail?.serviceItem?.minPrice} Birr - ${productController.productDetail?.serviceItem?.maxPrice} Birr",
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                      const SizedBox(height: 16),
                      if (productController
                              .productDetail?.serviceItem?.moreInfo?.entries !=
                          null)
                        ...productController
                            .productDetail!.serviceItem!.moreInfo!.entries
                            .map((e) =>
                                KeyPointWidget(text: "${e.key} -> ${e.value}"))
                            .toList(),
                      CustomText(
                        productController
                                .productDetail?.serviceItem?.description ??
                            "",
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Divider(height: 10),
                      if (productController
                              .productDetail?.serviceItem?.variants?.length
                              .isGreaterThan(0) ==
                          true) ...[
                        ListHeader("Options",
                            isSliver: false, bottomPadding: 0),
                        CustomContainer(
                          padding: 0,
                          margin: 0,
                          height: 100,
                          width: double.infinity,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 220,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) => Obx(
                              () => ProductVariantListTile(
                                productVariant: productController.productDetail!
                                    .serviceItem!.variants![index],
                                index: index,
                                SelectedIndex: productController
                                    .selectedVariantIndex.value,
                                onSelected: (newSelectedVariant) {
                                  productController
                                      .changeSelectedVariant(index);
                                },
                              ),
                            ),
                            itemCount: productController
                                .productDetail!.serviceItem!.variants!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      ],
                      const Divider(height: 10),
                      if (productController.productDetail?.businessInfo != null)
                        BusinessInfoTile(
                          business:
                              productController.productDetail!.businessInfo!,
                        ),
                      const Divider(height: 10),
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
                                          productController.remvoeQty();
                                        },
                                        icon: const Icon(Icons.remove)),
                                    const SizedBox(width: 8),
                                    Obx(() => CustomContainer(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey[200],
                                          child: CustomText(
                                            "${productController.selectedQty}",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        )),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        productController.addQty();
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
                    ],
                  ),
                ),
                if (productController
                        .productDetail?.relatedServiceItems?.isNotEmpty ==
                    true) ...[
                  ListHeader("Related products"),
                  SliverToBoxAdapter(
                    child: ProductList(
                        productViewmodels: productController
                            .productDetail!.relatedServiceItems!),
                  )
                ]
              ],
            ),
          )),
      persistentFooterButtons: [
        Obx(
          () => Visibility(
            visible: !productController.isDataLoading &&
                productController.productDetail != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "${productController.productDetail?.serviceItem?.fixedPrice} Birr",
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  CustomButton(
                      productController
                              .productDetail?.serviceInfo?.callToAction ??
                          productController
                              .productDetail?.serviceItem?.callToAction ??
                          "Order", onPressed: () {
                    productController.generateOrderSummary(
                        context, productController.productDetail!);
                  })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
