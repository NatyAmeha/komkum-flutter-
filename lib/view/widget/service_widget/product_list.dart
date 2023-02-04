import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/service_widget/product_tile.dart';
import 'package:komkum/viewmodel/order_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductList extends StatelessWidget {
  bool isSliver;
  List<Product>? products;
  List<ProductViewmodel>? productViewmodels;
  ProductListType productListType;
  int discountAmount;
  double height;
  String? callToAction;
  bool shrinkWrap;
  bool showDetailsInDialog;
  bool showCouponFooter;

  Function(OrderItemViewmodel)? onOrderedItemSelected;
  ProductList({
    this.products,
    this.productViewmodels,
    this.isSliver = true,
    this.productListType = ProductListType.GRID,
    this.height = 220,
    this.discountAmount = 0,
    this.shrinkWrap = false,
    this.showDetailsInDialog = false,
    this.callToAction,
    this.showCouponFooter = false,
    this.onOrderedItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    switch (productListType) {
      case ProductListType.HORIZONTAL:
        return Container(
          height: height,
          child: ListView.builder(
            itemCount: productViewmodels?.length ?? products?.length,
            itemBuilder: (context, index) => ProductTile(
                productInfo: productViewmodels?.elementAt(index).serviceItem ??
                    products![index],
                height: height,
                discountAmount: discountAmount,
                showInDialog: showDetailsInDialog,
                serviceCallToAction: callToAction,
                showCouponFooter: showCouponFooter,
                onOrderItemSelected: (orderdItem) {
                  onOrderedItemSelected?.call(orderdItem);
                }),
          ),
        );

      default:
        if (isSliver) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductTile(
                productInfo: productViewmodels?.elementAt(index).serviceItem ??
                    products![index],
                height: height,
                discountAmount: discountAmount,
                showInDialog: showDetailsInDialog,
                serviceCallToAction: callToAction,
                showCouponFooter: showCouponFooter,
                onOrderItemSelected: (orderdItem) {
                  onOrderedItemSelected?.call(orderdItem);
                },
              ),
              childCount: productViewmodels?.length ?? products?.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: height,
              crossAxisSpacing: 0,
              mainAxisSpacing: 8,
            ),
          );
        } else {
          return GridView.builder(
            shrinkWrap: shrinkWrap,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: height,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) => ProductTile(
                productInfo: productViewmodels?.elementAt(index).serviceItem ??
                    products![index],
                height: height,
                discountAmount: discountAmount,
                showInDialog: showDetailsInDialog,
                serviceCallToAction: callToAction,
                showCouponFooter: showCouponFooter,
                onOrderItemSelected: (orderdItem) {
                  onOrderedItemSelected?.call(orderdItem);
                }),
            itemCount: productViewmodels?.length ?? products?.length,
          );
        }
    }
  }
}
