import 'package:flutter/material.dart';
import 'package:komkum/view/widget/custom_text.dart';

class CustomButton extends StatelessWidget {
  String text;
  IconData? icon;
  Color? iconColor;
  Function onPressed;
  bool enabled;

  bool wrapContent;

  double textSize;
  Color? textColor;
  Color? buttonColor;
  CustomButton(this.text,
      {this.icon,
      this.iconColor,
      this.enabled = true,
      this.wrapContent = false,
      required this.onPressed,
      this.textColor = Colors.white,
      this.buttonColor = Colors.green,
      this.textSize = 17});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, foregroundColor: Colors.white),
      onPressed: enabled
          ? () {
              onPressed();
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: iconColor),
            // const SizedBox(width: 32),
            CustomText(
              text,
              fontSize: textSize,
              textStyle: Theme.of(context).textTheme.titleSmall,
              color: textColor,
            ),
            if (icon != null) const SizedBox(width: 16)
          ],
        ),
      ),
    );
  }
}
