import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  Color? color;
  double? width;
  double? height;
  double? padding;
  double? margin;
  double borderRadius;
  Color? borderColor;
  List<Color>? gradientColor;
  Alignment? alignment;
  Function? onTap;
  CustomContainer(
      {required this.child,
      this.color,
      this.width = double.infinity,
      this.height,
      this.padding,
      this.margin,
      this.borderRadius = 8,
      this.borderColor = Colors.transparent,
      this.gradientColor,
      this.alignment,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        padding: EdgeInsets.all(padding ?? 16),
        margin: EdgeInsets.all(margin ?? 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? Colors.white),
            color: color,
            gradient: gradientColor?.isNotEmpty == true
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColor!)
                : null),
        child: child,
      ),
    );
  }
}
