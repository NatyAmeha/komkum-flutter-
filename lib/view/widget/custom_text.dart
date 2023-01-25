import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? alignment;
  int maxLine;
  TextOverflow? overflow;
  TextStyle? textStyle;
  CustomText(
    this.text, {
    this.fontSize,
    this.fontWeight,
    this.color,
    this.alignment,
    this.maxLine = 10,
    this.overflow,
    this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle?.copyWith(color: color, fontSize: fontSize),
      // style:
      // TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      textAlign: alignment,
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
