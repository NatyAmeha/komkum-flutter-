import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';

class QuickAccessMenu extends StatelessWidget {
  const QuickAccessMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: Colors.amber,
              height: 50,
              alignment: Alignment.center,
              child: CustomText(
                "Coupons",
                textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 24,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              child: CustomText(
                "Categories",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.blueGrey,
              child: CustomText(
                "Trending Services",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.blueAccent,
              child: CustomText(
                "Trending Products",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
