import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/service_widget/product_tile.dart';

class ProductList extends StatelessWidget {
  bool isSliver;
  List<Product> products;
  ProductListType productListType;
  int discountAmount;
  double height;
  ProductList({
    required this.products,
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
            itemBuilder: (context, index) => ProductTile(
              productInfo: products[index],
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
                productInfo: products[index],
                height: height,
                discountAmount: discountAmount,
              ),
              childCount: products.length,
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
              productInfo: products[index],
              height: height,
              discountAmount: discountAmount,
            ),
            itemCount: products.length,
          );
        }
    }
  }
}
