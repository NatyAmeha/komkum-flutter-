import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ProductVariantListTile extends StatelessWidget {
  ProductVariant productVariant;
  double width;
  ProductVariantListTile({
    required this.productVariant,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.grey[400],
      padding: 12,
      child: Row(
        children: [
          CustomImage(productVariant.images?.first, width: 60, height: 60),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: productVariant.moreInfo!.entries
                  .map((info) => CustomText(
                        "${info.key} - ${info.value}",
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
