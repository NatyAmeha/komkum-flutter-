import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/view/widget/service_widget/business_services_list_tile.dart';
import 'package:komkum/view/widget/service_widget/horizontal_service_list_tile.dart';
import 'package:komkum/view/widget/service_widget/vertical_service_list_tile.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class ServiceList extends StatelessWidget {
  ServiceListType? listtype;
  List<ServiceViewmodel> services;
  bool isSliver;
  double width;
  double height;
  int discount;
  ServiceList(
      {required this.services,
      this.isSliver = false,
      this.listtype = ServiceListType.HORIZONTAL,
      this.height = 310,
      this.width = 300,
      this.discount = 0});

  @override
  Widget build(BuildContext context) {
    if (listtype == ServiceListType.HORIZONTAL) {
      if (isSliver) {
        return SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            height: height,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => HorizontalServiceListTile(
                serviceInfo: services[index],
                height: 150,
                width: 250,
                discount: discount,
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          height: height,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: services.length,
            scrollDirection: Axis.horizontal,
            itemExtent: width,
            itemBuilder: (context, index) => HorizontalServiceListTile(
              serviceInfo: services[index],
              height: 200,
              width: 150,
              discount: discount,
            ),
          ),
        );
      }
    } else if (listtype == ServiceListType.BUSINESS_SERVICES_LIST) {
      if (isSliver) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => BusinessServicesListTile(
              serviceInfo: services[index],
              height: height,
              discount: discount,
            ),
            childCount: services.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: height,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
        );
      } else {
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: height,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) => BusinessServicesListTile(
                  serviceInfo: services[index],
                  height: height,
                  discount: discount,
                ),
            itemCount: services.length);
      }
    } else {
      if (isSliver) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: services.length,
          (context, index) => VerticalServiceListTile(
            serviceInfo: services[index],
            discount: discount,
          ),
        ));
      } else {
        return ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) => VerticalServiceListTile(
            serviceInfo: services[index],
            discount: discount,
          ),
        );
      }
      // } else {
      //   if (isSliver) {
      //     return SliverGrid(
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 0),
      //         delegate: SliverChildBuilderDelegate(
      //           childCount: services.length,
      //           (context, index) => TriviaTile(
      //             trivia: trivias[index],
      //           ),
      //         ));
      //   } else {
      //     return GridView.builder(
      //       itemCount: trivias.length,
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         mainAxisSpacing: 2,
      //         crossAxisSpacing: 2,
      //       ),
      //       itemBuilder: (context, index) => TriviaTile(
      //         trivia: trivias[index],
      //       ),
      //     );
      //   }
    }
  }
}
