import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';

class QtySelector extends StatelessWidget {
  Function? onRemoveQty;
  Function? onAddQty;
  int qty;
  bool showQtyText;
  QtySelector(
      {this.qty = 1, this.onRemoveQty, this.onAddQty, this.showQtyText = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showQtyText)
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
                        if (qty > 1) onRemoveQty?.call();
                      },
                      icon: const Icon(Icons.remove)),
                  const SizedBox(width: 8),
                  CustomContainer(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                    child: CustomText(
                      "$qty",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      onAddQty?.call();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
