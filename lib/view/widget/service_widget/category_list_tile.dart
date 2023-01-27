import 'package:flutter/material.dart';
import 'package:komkum/view/widget/custom_container.dart';
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
      height: height,
      color: Colors.grey[400],
      child: Row(
        children: [
          Container(
            height: height,
            width: 10,
            color: color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomText(
                category,
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
