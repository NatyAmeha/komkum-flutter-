import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/business_controller.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/ui_helper.dart';
import 'package:komkum/view/widget/business_widget/business_list.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/image_carousel.dart';
import 'package:komkum/view/widget/image_collection.dart';
import 'package:komkum/view/widget/list_header.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';
import 'package:komkum/view/widget/review_widget/review_info.dart';
import 'package:komkum/view/widget/service_widget/coupons.list.dart';
import 'package:komkum/view/widget/service_widget/service_list.dart';

class BusinessScreen extends StatefulWidget {
  static const routeName = "/business/:id";
  String businessId;
  BusinessScreen({required this.businessId});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  var businessController = Get.put(BusinessController());

  loadData(BuildContext context) {
    Future.delayed(Duration.zero, () {
      businessController.getBusinessDetails(widget.businessId, context);
    });
  }

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Name"),
        centerTitle: true,
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: businessController.businessDetails != null,
          exception: businessController.exception,
          isDataLoading: businessController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: ImageCollection(
                        images: businessController
                                .businessDetails?.businessInfo?.images ??
                            [],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              "${businessController.businessDetails?.businessInfo?.name} ",
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Obx(
                            () => !businessController.isBusinessInFavorite.value
                                ? IconButton(
                                    onPressed: () {
                                      businessController.addBusinessToFavorite(
                                        businessController
                                            .businessDetails!.businessInfo!.id!,
                                        context,
                                      );
                                    },
                                    icon: const Icon(Icons.favorite_outline))
                                : IconButton(
                                    onPressed: () {
                                      businessController
                                          .removeBusinessFromFavorite(
                                        businessController
                                            .businessDetails!.businessInfo!.id!,
                                        context,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.green,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24)
                  ],
                ),
              ),
              if (businessController.businessDetails?.services?.isNotEmpty ==
                  true)
                ServiceList(
                  services: businessController.businessDetails!.services!,
                  height: 150,
                  isSliver: true,
                  listtype: ServiceListType.BUSINESS_SERVICES_LIST,
                ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Divider(height: 16, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomText(
                        "${businessController.businessDetails?.businessInfo?.description} ",
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Divider(height: 24),
                    if (businessController.businessDetails?.reviewInfo != null)
                      ListTile(
                        onTap: () {
                          UIHelper.goToScreen(context, "/reviews", queryParam: {
                            "id":
                                "${businessController.businessDetails?.businessInfo?.id}"
                          }, extra: {
                            "name": businessController
                                .businessDetails?.businessInfo?.name,
                            "type": ReviewDataType.BUSINESSS_REVIEW,
                          });
                        },
                        title: CustomText(
                          "Rating",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Row(
                          children: [
                            CustomRatingBar(
                              ratingValue: businessController
                                  .businessDetails!.reviewInfo!.rating,
                              size: 40,
                              starCount: 1,
                            ),
                            CustomText(
                              "${businessController.businessDetails!.reviewInfo!.rating!}",
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              "${businessController.businessDetails!.reviewInfo!.reviews?.length} reviews",
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                      ),
                    const Divider(height: 16),
                  ],
                ),
              ),
              if (businessController.businessDetails?.coupons?.isNotEmpty ==
                  true) ...[
                ListHeader("Coupons services"),
                CouponsList(
                    coupons: businessController.businessDetails!.coupons!)
              ],
              if (businessController
                      .businessDetails?.relatedBusinesses?.isNotEmpty ==
                  true) ...[
                ListHeader("Related Businesses"),
                BusinessList(
                  businesses:
                      businessController.businessDetails!.relatedBusinesses!,
                  listType: BusinessListType.HORIZONTAL,
                  height: 275,
                )
              ]
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
            Spacer(),
            CustomButton(
              "Direction",
              onPressed: () {},
              icon: Icons.directions,
            )
          ],
        )
      ],
    );
  }
}
