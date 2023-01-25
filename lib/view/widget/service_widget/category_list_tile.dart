import 'package:flutter/material.dart';
import 'package:komkum/view/widget/custom_text.dart';

class CategoryTile extends StatelessWidget {
  String category;
  double width;
  double height;
  Color? color;
  CategoryTile(
      {required this.category,
      this.width = double.infinity,
      this.height = 100,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: width,
      height: height,
      child: Row(
        children: [
          Container(
            height: height,
            width: 10,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomText(
              category,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
