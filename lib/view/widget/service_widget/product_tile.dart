import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/product_detail_screen.dart';
import 'package:komkum/view/widget/custom_badge.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ProductTile extends StatelessWidget {
  Product productInfo;
  int discountAmount;
  double height;

  ProductTile(
      {required this.productInfo, this.height = 160, this.discountAmount = 10});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: 8,
      child: Card(
        margin: const EdgeInsets.all(4),
        elevation: 0,
        child: CustomContainer(
          padding: 0,
          onTap: () {
            UIHelper.goToScreen(context, "/product/${productInfo.id}");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImage(
                    productInfo.images?.first,
                    width: double.infinity,
                    height: 160,
                  ),
                  if (discountAmount > 0)
                    Positioned(
                        child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomBadge(
                        borderColor: Colors.green,
                        badgeColor: Colors.green,
                        borderRadius: 0,
                        content: CustomText(
                          "${discountAmount}% Off",
                          textStyle: Theme.of(context).textTheme.caption,
                          color: Colors.white,
                        ),
                      ),
                    ))
                ],
              ),
              const SizedBox(height: 4),
              CustomText(
                "${productInfo.name}",
                textStyle: Theme.of(context).textTheme.titleMedium,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              productInfo.fixedPrice != null
                  ? showPrice(context,
                      fixedPrice: productInfo.fixedPrice,
                      discountAmount: discountAmount)
                  : showPrice(context,
                      minPrice: productInfo.minPrice,
                      maxPrice: productInfo.maxPrice,
                      discountAmount: 10),
              const SizedBox(height: 16),
              CustomBadge(
                content: CustomText(
                  "${productInfo.variants?.length} options",
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showPrice(BuildContext context,
      {int? fixedPrice, int? minPrice, int? maxPrice, int discountAmount = 0}) {
    if (fixedPrice != null) {
      if (discountAmount > 0) {
        var discountedPrice = fixedPrice - (fixedPrice * discountAmount) ~/ 100;
        return Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "$fixedPrice Birr\n",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "$discountedPrice Birr",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      } else {
        return CustomText(
          "${productInfo.fixedPrice} Birr",
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        );
      }
    } else {
      if (discountAmount > 0) {
        var discountedMin = minPrice! - (minPrice * discountAmount) ~/ 100;
        var discountedMax = maxPrice! - (maxPrice * discountAmount) ~/ 100;
        return Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "$minPrice Birr - $maxPrice Birr\n",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              TextSpan(
                text: "$discountedMin Birr - $discountedMax Birr",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      } else {
        return CustomText(
          "${productInfo.minPrice} Birr - ${productInfo.maxPrice} Birr",
          textStyle: Theme.of(context).textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        );
      }
    }
  }
}
