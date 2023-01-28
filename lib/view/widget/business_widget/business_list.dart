import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/business_widget/business.tile.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessList extends StatelessWidget {
  List<BusienssViewmodel> businesses;
  BusinessListType listType;
  bool isSliver;
  double width;
  double height;
  BusinessList({
    required this.businesses,
    this.listType = BusinessListType.HORIZONTAL,
    this.height = 300,
    this.width = 300,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (listType) {
      case BusinessListType.HORIZONTAL:
        if (isSliver) {
          return SliverToBoxAdapter(
              child: CustomContainer(
            margin: 8,
            padding: 0,
            height: height,
            width: width,
            child: Container(
              width: width,
              height: height,
              child: ListView.builder(
                itemCount: businesses.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => BusinessTile(
                  businessInfo: businesses[index],
                  width: width,
                  height: height,
                ),
              ),
            ),
          ));
        } else {
          return ListView.builder(
            itemCount: businesses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BusinessTile(
              businessInfo: businesses[index],
              width: width,
              height: height,
            ),
          );
        }
      default:
        if (isSliver) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: businesses.length,
              (context, index) => BusinessTile(
                businessInfo: businesses[index],
                width: width,
                height: height,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: businesses.length,
            itemBuilder: (context, index) => BusinessTile(
              businessInfo: businesses[index],
              width: width,
              height: height,
            ),
          );
        }
    }
  }
}
