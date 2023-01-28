import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/business_widget/business_list.dart';
import 'package:komkum/view/widget/coupons_widget/coupon_list.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';
import 'package:komkum/view/widget/service_widget/product_list.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';
import 'package:komkum/viewmodel/search_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  SearchViewmodel serachResult;
  SearchScreen({required this.serachResult});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey[400],
            isScrollable: true,
            tabs: const [
              Tab(text: "Products"),
              Tab(text: "Services"),
              Tab(text: "Businesses"),
              // Tab(text: "Coupons"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Expanded(
                  child: ProductList(
                    productViewmodels: serachResult!.products!,
                    isSliver: false,
                    height: 320,
                  ),
                ),
                Expanded(
                    child: ServiceList(
                  services: serachResult.services!,
                  listtype: ServiceListType.VERTICAL,
                  isSliver: false,
                  height: 200,
                )),
                Expanded(
                    child: BusinessList(
                  businesses: serachResult.businesses!,
                  listType: BusinessListType.VERTICAL,
                  height: 250,
                  width: double.infinity,
                  isSliver: false,
                )),
                // Expanded(
                //     child: CouponList(
                //   coupons: searchResult!.coupons!,
                // )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDeligate extends SearchDelegate {
  var appController = Get.find<AppController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = "";
          },
        )
      ];
    } else {
      return null;
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    print("data is called");
    if (appController.searchResult != null) {
      return SearchScreen(serachResult: appController.searchResult!);
    } else {
      return FutureBuilder<SearchViewmodel?>(
        future: appController.search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingProgressbar(loadingState: true);
          } else if (snapshot.hasData) {
            print("data is ${snapshot.data?.services}");
            var searchResult = snapshot.data;
            return SearchScreen(serachResult: searchResult!);
          } else {
            return Text("ERror occured ${snapshot.error.toString()}");
          }
        },
      );
    }

    // return SearchScreen(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // appController.searhResult = null;
    return Container();
  }
}
