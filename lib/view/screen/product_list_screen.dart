import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/product_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = "/products";
  String title;
  ProductListDataType? listDataType;
  List<ProductViewmodel>? products;
  ProductListScreen({required this.title, this.listDataType, this.products});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var productController = Get.put(ProductController());

  loadData(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        if (widget.products == null) {
          if (widget.listDataType == ProductListDataType.USER_FAVORITE_PRDUCTS)
            productController.getUserFavoriteProducts(context);
        } else {
          productController.productLists = widget.products;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: productController.productLists?.isNotEmpty == true,
          exception: productController.exception,
          isDataLoading: productController.isDataLoading,
          content: ProductList(
            productViewmodels: productController.productLists,
            isSliver: false,
            height: 320,
            productListType: ProductListType.GRID,
          ),
        ),
      ),
    );
  }
}
