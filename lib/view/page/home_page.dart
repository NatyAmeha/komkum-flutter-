import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/login_screen.dart';
import 'package:komkum/view/screen/search_screen.dart';
import 'package:komkum/view/widget/coupon.tile.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/quick_access_menu.dart';
import 'package:komkum/view/widget/search_widget.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/view/widget/service_widget/product_tile.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => UIHelper.displayContent(
          showWhen: appController.browseResult != null,
          exception: appController.exception,
          isDataLoading: appController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                  size: 30,
                ),
                title: CustomText(
                  "Komkum",
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      UIHelper.goToScreen(context, LoginScreen.routeName);
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, color: Colors.grey),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: CustomContainer(
                  onTap: () {
                    showSearch(
                        context: context, delegate: CustomSearchDeligate());
                  },
                  padding: 16,
                  child: SearchBar(
                      borderRadius: 16,
                      hintText: "Search services, businesses and coupons"),
                ),
              ),
              ListHeader("Quick Access"),
              SliverToBoxAdapter(child: QuickAccessMenu()),
              if (appController.browseResult?.featuredServices?.isNotEmpty ==
                  true) ...[
                ListHeader("Featured services"),
                SliverToBoxAdapter(
                  child: ServiceList(
                      height: 350,
                      services: appController.browseResult!.featuredServices!,
                      listtype: ServiceListType.HORIZONTAL),
                )
              ],
              if (appController.browseResult?.products?.isNotEmpty == true) ...[
                ListHeader("Recommended"),
                ProductList(
                  products: appController.browseResult!.products!,
                  height: 320,
                )
              ],
              ListHeader("Coupons"),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CouponTile(
                    couponViewmodel: couponViewmode,
                    height: 200,
                  ),
                  childCount: 4,
                ),
              )
            ],
          ),
        ));
  }
}
