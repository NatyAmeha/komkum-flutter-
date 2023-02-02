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
  int index;
  int SelectedIndex;
  Function(ProductVariant)? onSelected;
  ProductVariantListTile({
    required this.productVariant,
    required this.index,
    this.SelectedIndex = -1,
    this.width = 150,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        onSelected?.call(productVariant);
      },
      color: index == SelectedIndex ? Colors.green : Colors.transparent,
      borderColor: index == SelectedIndex ? Colors.green : Colors.grey,
      padding: 16,
      child: Row(
        children: [
          CustomImage(productVariant.images?.first, width: 60, height: 60),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productVariant.moreInfo!.entries
                  .map((info) => CustomText(
                        "${info.key} - ${info.value}",
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
