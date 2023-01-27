import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/custom_text.dart';

class BusinessInfoTile extends StatelessWidget {
  Business business;
  BusinessInfoTile({required this.business});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        UIHelper.goToScreen(context, "/business/${business.id}");
      },
      title: CustomText(
        "${business.name} ",
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: CustomText(
        "${business.services?.length} services",
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(business.images!.first),
      ),
    );
  }
}
