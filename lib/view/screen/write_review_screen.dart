import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:komkum/controller/order_controller.dart';
import 'package:komkum/controller/user_controller.dart';
import 'package:komkum/model/review.dart';
import 'package:komkum/view/widget/button_with_progressbar.dart';
import 'package:komkum/view/widget/custom_button.dart';
import 'package:komkum/view/widget/custom_container.dart';
import 'package:komkum/view/widget/custom_text.dart';
import 'package:komkum/view/widget/custom_text_field.dart';
import 'package:komkum/view/widget/review_widget/custom_rating_bar.dart';

class WriteReviewScreen extends StatefulWidget {
  static const routeName = "/create_review";
  String title;
  List<String> reviewKeys;
  Review review;
  WriteReviewScreen({
    required this.title,
    required this.reviewKeys,
    required this.review,
  });

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  var loadUserController = Get.lazyPut(() => UserController());
  var userController = Get.find<UserController>();
  var descriptionController = TextEditingController();
  bool isLoading = false;
  List<KeyReview> keyPointReviews = [];

  @override
  Widget build(BuildContext context) {
    print("review points ${widget.reviewKeys}");
    return Scaffold(
      appBar: AppBar(title: Text("Write review")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomContainer(
                color: Colors.grey[200],
                child: CustomText(
                  "${widget.review.businessName} > ${widget.title}",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              ...widget.reviewKeys
                  .asMap()
                  .entries
                  .map(
                    (entries) => Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            entries.value,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          CustomRatingBar(
                            enableRating: true,
                            size: 50,
                            onRatingUpdated: (ratingValue) {
                              addKeyPointReview(
                                  ratingValue.toInt(), entries.value);
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 16),
              CustomTextField(
                  hint: "Add description...",
                  label: "Add description",
                  controller: descriptionController,
                  multiLine: true,
                  onchanged: (value) {
                    setState(() {});
                  })
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Obx(
          () => ButtonWithProgressbar(
            text: "Post Review",
            isLoading: userController.isDataLoading,
            onClick: () {
              widget.review.keyPoints = keyPointReviews;
              widget.review.description = descriptionController.text;
              userController.addReviewToService(widget.review, context);
            },
          ),
        )
      ],
    );
  }

  addKeyPointReview(int ratingValue, String key) {
    var index = keyPointReviews.indexWhere((element) => element.key == key);
    if (index > -1) {
      keyPointReviews[index].rating = ratingValue.toDouble();
    } else {
      var NewRatingInfo = KeyReview(key: key, rating: ratingValue.toDouble());
      keyPointReviews.add(NewRatingInfo);
    }
  }
}
