import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/order_summary_screen.dart';
import 'package:komkum/view/widget/custom_text.dart';

class CartIcon extends StatelessWidget {
  int cartCount;
  CartIcon({this.cartCount = 0});

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Padding(
        padding: const EdgeInsets.all(4),
        child: CustomText(
          "$cartCount",
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      child: IconButton(
        onPressed: () {
          UIHelper.goToScreen(context, OrderSummaryScreen.routeName);
        },
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
