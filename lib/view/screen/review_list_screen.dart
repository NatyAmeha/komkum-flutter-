import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/review_controller.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/screen/write_review_screen.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/review_widget/review_info.dart';
import 'package:komkum/view/widget/review_widget/review_keypoint_tile.dart';
import 'package:komkum/view/widget/review_widget/review_tile.dart';

class ReviewListScreen extends StatefulWidget {
  static const routeName = "/reviews";
  String? id;

  ReviewDataType reviewType;
  String name;
  ReviewListScreen({
    required this.reviewType,
    required this.name,
    this.id,
  });

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  var reviewController = Get.put(ReviewController());

  loaddata(BuildContext context, {String? keyPoint}) {
    if (widget.reviewType == ReviewDataType.BUSINESSS_REVIEW) {
      reviewController.getBusinessReviewInfo(widget.id!, context,
          keyPoint: keyPoint);
    } else if (widget.reviewType == ReviewDataType.SERVCIE_REVIEW) {
      reviewController.getServcieReviewInfo(widget.id!, context,
          keyPoint: keyPoint);
    }
  }

  @override
  void initState() {
    loaddata(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
        centerTitle: true,
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: reviewController.reviewData != null,
          exception: reviewController.exception,
          isDataLoading: reviewController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomText(
                        "${widget.name}",
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount:
                            (reviewController.reviewData?.keyPoint?.length ??
                                    0) +
                                1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Obx(() {
                          if (index == 0) {
                            return ReviewKeypointTile(
                              keyReviewPoint: KeyReview(
                                  key: "All",
                                  rating: reviewController.reviewData?.rating,
                                  count: reviewController
                                      .reviewData?.reviews?.length),
                              index: index,
                              selectedIndex: reviewController
                                  .selectedKeyReviewPointIndex.value,
                              onSelected: (selectedKey) {
                                loaddata(context);
                                reviewController
                                    .selectedKeyReviewPointIndex(index);
                              },
                            );
                          } else {
                            return ReviewKeypointTile(
                              keyReviewPoint: reviewController
                                  .reviewData!.keyPoint![index - 1],
                              index: index,
                              selectedIndex: reviewController
                                  .selectedKeyReviewPointIndex.value,
                              onSelected: (selectedKey) {
                                loaddata(context, keyPoint: selectedKey);
                                reviewController
                                    .selectedKeyReviewPointIndex(index);
                              },
                            );
                          }
                        }),
                      ),
                    ),
                    const Divider(height: 16, thickness: 1),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ReviewTile(
                          reviewInfo:
                              reviewController.reviewData!.reviews![index],
                        ),
                    childCount: reviewController.reviewData?.reviews?.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
