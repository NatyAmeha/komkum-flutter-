import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/service_widget/product_tile.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductList extends StatelessWidget {
  bool isSliver;
  List<Product>? products;
  List<ProductViewmodel>? productViewmodels;
  ProductListType productListType;
  int discountAmount;
  double height;
  ProductList({
    this.products,
    this.productViewmodels,
    this.isSliver = true,
    this.productListType = ProductListType.GRID,
    this.height = 220,
    this.discountAmount = 0,
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
            ),
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
              ),
              childCount: productViewmodels?.length ?? products?.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: height,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8),
          );
        } else {
          return GridView.builder(
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
            ),
            itemCount: productViewmodels?.length ?? products?.length,
          );
        }
    }
  }
}
