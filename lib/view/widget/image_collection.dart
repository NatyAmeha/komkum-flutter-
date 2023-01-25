import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';

class ImageCollection extends StatelessWidget {
  List<String> images;
  ImageCollection({required this.images});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      axisDirection: AxisDirection.right,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: images.length == 1 ? 3 : 1,
          mainAxisCellCount: 2,
          child: CustomImage(images.first),
        ),
        if (images.length > 1)
          StaggeredGridTile.count(
            crossAxisCellCount: images.length == 2 ? 2 : 1,
            mainAxisCellCount: images.length == 2 ? 2 : 1,
            child: CustomImage(images.elementAt(1)),
          ),
        if (images.length > 2)
          StaggeredGridTile.count(
            crossAxisCellCount: images.length == 3 ? 2 : 1,
            mainAxisCellCount: 1,
            child: CustomImage(images.elementAt(2)),
          ),
        if (images.length > 3)
          Stack(
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: CustomImage(images.elementAt(3)),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: CustomText(
                  "+40",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ))
            ],
          )
      ],
    );
  }
}
