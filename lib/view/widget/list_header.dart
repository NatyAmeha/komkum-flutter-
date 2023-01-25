import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'custom_text.dart';

class ListHeader extends StatelessWidget {
  bool? isSliver;
  String headerText;
  String? subtitle;
  double topPadding;
  double bottomPadding;
  double startPadding;
  bool showMore;
  Widget? trailing;
  double? fontSize;
  Function? onClick;

  ListHeader(
    this.headerText, {
    this.subtitle,
    this.isSliver = true,
    this.showMore = false,
    this.trailing,
    this.fontSize = 21,
    this.topPadding = 24,
    this.bottomPadding = 8,
    this.startPadding = 16,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (isSliver == true) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
              left: startPadding,
              top: topPadding,
              bottom: bottomPadding,
              right: startPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      headerText,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (subtitle != null)
                      CustomText(
                        subtitle!,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        maxLine: 1,
                      )
                  ],
                ),
              ),
              if (showMore)
                trailing != null
                    ? InkWell(
                        onTap: () {
                          onClick!();
                        },
                        child: trailing)
                    : IconButton(
                        onPressed: () {
                          onClick?.call();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: startPadding,
            top: topPadding,
            bottom: bottomPadding,
            right: startPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    headerText,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (subtitle != null)
                    CustomText(
                      subtitle!,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    )
                ],
              ),
            ),
            if (showMore)
              if (showMore)
                trailing != null
                    ? InkWell(
                        onTap: () {
                          onClick!();
                        },
                        child: trailing)
                    : IconButton(
                        onPressed: () {
                          onClick?.call();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
          ],
        ),
      );
    }
  }
}
