import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_image.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';

class BusinessServicesListTile extends StatelessWidget {
  ServiceViewmodel serviceInfo;
  double height;
  double width;
  int discount;
  BusinessServicesListTile({
    required this.serviceInfo,
    this.height = 100,
    this.width = 100,
    this.discount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        UIHelper.goToScreen(context, "/service/${serviceInfo.service?.id}");
      },
      padding: 0,
      height: height,
      width: height,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[400],
            child: CustomImage(
              serviceInfo.service?.images?.first,
              height: 70,
              width: 70,
              roundImage: true,
              borderRadius: 16,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            "${serviceInfo.service?.name}",
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
