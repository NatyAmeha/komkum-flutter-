import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ProductTile extends StatelessWidget {
  Product productInfo;
  double height;

  ProductTile({required this.productInfo, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            productInfo.images?.first,
            width: double.infinity,
            height: height * 0.5,
          ),
          const SizedBox(height: 16),
          CustomText(
            "${productInfo.fixedPrice} Birr",
            textStyle: Theme.of(context).textTheme.titleMedium,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          productInfo.fixedPrice != null
              ? CustomText(
                  "${productInfo.fixedPrice} Birr",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.bold,
                )
              : CustomText(
                  "${productInfo.minPrice} Birr - ${productInfo.maxPrice} Birr",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
          const SizedBox(height: 16),
          CustomBadge(
            content: CustomText(
              "${productInfo.variants?.length} options",
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
