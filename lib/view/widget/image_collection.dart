import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ImageCollection extends StatelessWidget {
  List<String> images;
  ImageCollection({required this.images});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: images.length < 3 ? 4 : 2,
          child: CustomContainer(
              padding: 0,
              borderRadius: 0,
              borderColor: Colors.green,
              child: CustomImage(images.first)),
        ),
        if (images.length > 1)
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: CustomContainer(
                padding: 0,
                borderRadius: 0,
                borderColor: Colors.green,
                child: CustomImage(images.elementAt(1))),
          ),
        if (images.length > 2)
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: CustomContainer(
                padding: 0,
                borderRadius: 0,
                borderColor: Colors.green,
                child: CustomImage(images.elementAt(2))),
          ),
        if (images.length > 3)
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: CustomContainer(
                padding: 0,
                borderRadius: 0,
                borderColor: Colors.green,
                child: CustomImage(images.elementAt(3))),
          ),
      ],
    );
  }
}
