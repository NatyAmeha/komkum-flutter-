import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/business_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/business_widget/business_list.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';

class BusinessListScreen extends StatefulWidget {
  static const routeName = "/businesses";
  String title;
  BusinessListDataType? dataType;
  List<BusienssViewmodel>? businesses;
  BusinessListScreen({required this.title, this.dataType, this.businesses});

  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  var businessController = Get.put(BusinessController());

  loadData(BuildContext context) {
    if (widget.businesses != null) {
      businessController.businessLists = widget.businesses;
    } else {
      if (widget.dataType == BusinessListDataType.USER_FAVORITE_BUSINESS) {
        Future.delayed(Duration.zero, () {
          businessController.getUserFavoriteBusinesses(context);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Obx(
        () => UIHelper.displayContent(
            showWhen: businessController.businessLists?.isNotEmpty == true,
            exception: businessController.exception,
            isDataLoading: businessController.isDataLoading,
            content: Padding(
              padding: const EdgeInsets.all(8),
              child: BusinessList(
                businesses: businessController.businessLists ?? [],
                isSliver: false,
                listType: BusinessListType.VERTICAL,
                height: 260,
              ),
            )),
      ),
    );
  }
}
