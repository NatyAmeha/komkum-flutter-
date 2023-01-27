import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/app_controller.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/loading_progressbar.dart';

class SearchScreen extends StatefulWidget {
  var appController = Get.find<AppController>();
  String query;
  SearchScreen({required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   if (widget.appController.searhResult == null) {
    //     widget.appController.getSearchResult(widget.query);
    //   }
    // });

    return Obx(
      () => UIHelper.displayContent(
        showWhen: true,
        exception: widget.appController.exception,
        isDataLoading: widget.appController.isDataLoading,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey[400],
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(text: "Services"),
                Tab(text: "Businesses"),
                Tab(text: "Coupons"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ),
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
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingProgressbar(loadingState: true);
        } else if (snapshot.hasData) {
          return Container();
        } else {
          return const SizedBox();
        }
      },
    );

    // return SearchScreen(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // appController.searhResult = null;
    return Container();
  }
}
