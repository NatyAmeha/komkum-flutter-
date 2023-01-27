import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/view/widget/custom_text.dart';

class CustomBadge extends StatelessWidget {
  Widget? content;
  Function? onclick;
  Color badgeColor;
  Color borderColor;
  String? text;
  CustomBadge({
    this.content,
    this.text,
    this.onclick,
    this.badgeColor = Colors.transparent,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: text != null ? Text(text!) : content,
      ),
      badgeColor: badgeColor,
      borderSide: BorderSide(color: borderColor),
      animationType: BadgeAnimationType.scale,
      animationDuration: Duration.zero,
      shape: BadgeShape.square,
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
